import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../models/user_profile_model.dart';
import 'firestore_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirestoreService _firestore = FirestoreService.instance;

  // Current user stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Current user
  User? get currentUser => _auth.currentUser;

  // Is user signed in
  bool get isSignedIn => currentUser != null;

  // Current user ID
  String? get currentUserId => currentUser?.uid;

  /// Sign up with email and password
  Future<UserCredential?> signUpWithEmail({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      // Create user account
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user != null) {
        // Update display name
        await user.updateDisplayName(fullName);

        // Send verification email
        await user.sendEmailVerification();

        // Create user profile in Firestore
        await _createUserProfile(user, fullName);

        debugPrint('✅ User signed up: ${user.uid}');
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      debugPrint('❌ Sign up error: ${e.code} - ${e.message}');
      rethrow;
    }
  }

  /// Sign in with email and password
  Future<UserCredential?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      debugPrint('✅ User signed in: ${userCredential.user?.uid}');
      return userCredential;
    } on FirebaseAuthException catch (e) {
      debugPrint('❌ Sign in error: ${e.code} - ${e.message}');
      rethrow;
    }
  }

  /// Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User canceled the sign-in
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final userCredential = await _auth.signInWithCredential(credential);

      // Create or update user profile
      if (userCredential.user != null) {
        await _createOrUpdateUserProfile(userCredential.user!);
      }

      debugPrint('✅ Google sign in: ${userCredential.user?.uid}');
      return userCredential;
    } catch (e) {
      debugPrint('❌ Google sign in error: $e');
      rethrow;
    }
  }

  /// Sign in with Apple
  Future<UserCredential?> signInWithApple() async {
    try {
      // Request Apple ID credential
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // Create an OAuth credential
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      // Sign in to Firebase with the Apple credential
      final userCredential = await _auth.signInWithCredential(oauthCredential);

      // Create or update user profile
      if (userCredential.user != null) {
        final fullName = appleCredential.givenName != null &&
                appleCredential.familyName != null
            ? '${appleCredential.givenName} ${appleCredential.familyName}'
            : null;
        await _createOrUpdateUserProfile(userCredential.user!, fullName: fullName);
      }

      debugPrint('✅ Apple sign in: ${userCredential.user?.uid}');
      return userCredential;
    } catch (e) {
      debugPrint('❌ Apple sign in error: $e');
      rethrow;
    }
  }

  /// Sign in anonymously (guest checkout)
  Future<UserCredential?> signInAnonymously() async {
    try {
      final userCredential = await _auth.signInAnonymously();
      debugPrint('✅ Anonymous sign in: ${userCredential.user?.uid}');
      return userCredential;
    } catch (e) {
      debugPrint('❌ Anonymous sign in error: $e');
      rethrow;
    }
  }

  /// Link anonymous account with email
  Future<UserCredential?> linkWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final user = currentUser;
      if (user == null || !user.isAnonymous) {
        throw Exception('No anonymous user to link');
      }

      final credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );

      final userCredential = await user.linkWithCredential(credential);
      debugPrint('✅ Anonymous account linked with email');
      return userCredential;
    } catch (e) {
      debugPrint('❌ Link with email error: $e');
      rethrow;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      debugPrint('✅ User signed out');
    } catch (e) {
      debugPrint('❌ Sign out error: $e');
      rethrow;
    }
  }

  /// Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      debugPrint('✅ Password reset email sent to: $email');
    } on FirebaseAuthException catch (e) {
      debugPrint('❌ Password reset error: ${e.code} - ${e.message}');
      rethrow;
    }
  }

  /// Change password
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final user = currentUser;
      if (user == null || user.email == null) {
        throw Exception('No user signed in');
      }

      // Re-authenticate user
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(credential);

      // Change password
      await user.updatePassword(newPassword);
      debugPrint('✅ Password changed successfully');
    } catch (e) {
      debugPrint('❌ Change password error: $e');
      rethrow;
    }
  }

  /// Update email
  Future<void> updateEmail(String newEmail) async {
    try {
      final user = currentUser;
      if (user == null) {
        throw Exception('No user signed in');
      }

      await user.updateEmail(newEmail);
      await user.sendEmailVerification();
      debugPrint('✅ Email updated and verification sent');
    } catch (e) {
      debugPrint('❌ Update email error: $e');
      rethrow;
    }
  }

  /// Send email verification
  Future<void> sendEmailVerification() async {
    try {
      final user = currentUser;
      if (user == null) {
        throw Exception('No user signed in');
      }

      if (!user.emailVerified) {
        await user.sendEmailVerification();
        debugPrint('✅ Verification email sent');
      }
    } catch (e) {
      debugPrint('❌ Send verification error: $e');
      rethrow;
    }
  }

  /// Reload user to get latest data
  Future<void> reloadUser() async {
    try {
      await currentUser?.reload();
      debugPrint('✅ User reloaded');
    } catch (e) {
      debugPrint('❌ Reload user error: $e');
    }
  }

  /// Delete account
  Future<void> deleteAccount() async {
    try {
      final user = currentUser;
      if (user == null) {
        throw Exception('No user signed in');
      }

      // Delete user data from Firestore
      await _firestore.deleteUserData(user.uid);

      // Delete Firebase Auth account
      await user.delete();
      debugPrint('✅ Account deleted');
    } catch (e) {
      debugPrint('❌ Delete account error: $e');
      rethrow;
    }
  }

  /// Get auth error message
  String getAuthErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'An account already exists for this email.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'operation-not-allowed':
        return 'This operation is not allowed.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'user-not-found':
        return 'No user found for this email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      default:
        return e.message ?? 'An unknown error occurred.';
    }
  }

  /// Create user profile in Firestore
  Future<void> _createUserProfile(User user, String fullName) async {
    final profile = UserProfile(
      id: user.uid,
      email: user.email!,
      fullName: fullName,
      memberSince: DateTime.now(),
      preferences: UserPreferences(),
      stats: UserStats(),
    );

    await _firestore.createUserProfile(profile);
  }

  /// Create or update user profile (for social sign in)
  Future<void> _createOrUpdateUserProfile(User user, {String? fullName}) async {
    // Check if profile exists
    final exists = await _firestore.userProfileExists(user.uid);

    if (!exists) {
      // Create new profile
      final profile = UserProfile(
        id: user.uid,
        email: user.email!,
        fullName: fullName ?? user.displayName ?? '',
        avatarUrl: user.photoURL,
        memberSince: DateTime.now(),
        preferences: UserPreferences(),
        stats: UserStats(),
      );

      await _firestore.createUserProfile(profile);
    } else {
      // Update existing profile
      await _firestore.updateUserProfile(user.uid, {
        'profile.avatarUrl': user.photoURL,
        'updatedAt': DateTime.now(),
      });
    }
  }
}
