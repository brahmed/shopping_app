import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shopping_app/services/firebase/auth_service.dart';
import 'package:shopping_app/services/firebase/firestore_service.dart';
import 'package:shopping_app/services/firebase/firebase_service.dart';
import 'package:shopping_app/services/firebase/storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Generate mocks using build_runner
// Run: flutter pub run build_runner build
@GenerateMocks([
  AuthService,
  FirestoreService,
  FirebaseService,
  StorageService,
  FirebaseAuth,
  FirebaseFirestore,
  User,
  UserCredential,
])
void main() {}

/// Mock Firebase Auth User
class MockFirebaseUser extends Mock implements User {
  @override
  String get uid => 'test_user_id';

  @override
  String? get email => 'test@example.com';

  @override
  String? get displayName => 'Test User';

  @override
  String? get photoURL => 'https://example.com/avatar.jpg';

  @override
  bool get emailVerified => true;

  @override
  bool get isAnonymous => false;

  @override
  UserMetadata get metadata => MockUserMetadata();

  @override
  List<UserInfo> get providerData => [];

  @override
  String? get phoneNumber => '+1234567890';

  @override
  String? get refreshToken => 'mock_refresh_token';

  @override
  String? get tenantId => null;
}

/// Mock User Metadata
class MockUserMetadata extends Mock implements UserMetadata {
  @override
  DateTime? get creationTime => DateTime(2023, 1, 1);

  @override
  DateTime? get lastSignInTime => DateTime.now();
}

/// Mock User Credential
class MockUserCredential extends Mock implements UserCredential {
  @override
  User? get user => MockFirebaseUser();

  @override
  AdditionalUserInfo? get additionalUserInfo => null;

  @override
  AuthCredential? get credential => null;
}
