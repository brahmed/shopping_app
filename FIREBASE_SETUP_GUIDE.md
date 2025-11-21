# Firebase Setup Guide for Shopping App

This guide will walk you through setting up Firebase for your Shopping App from scratch.

---

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Firebase Project Setup](#firebase-project-setup)
3. [Flutter Configuration](#flutter-configuration)
4. [Platform Setup](#platform-setup)
5. [Deploy Security Rules](#deploy-security-rules)
6. [Deploy Cloud Functions](#deploy-cloud-functions)
7. [Testing](#testing)
8. [Production Deployment](#production-deployment)

---

## 1. Prerequisites

### Required Tools

```bash
# Install Firebase CLI
npm install -g firebase-tools

# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Verify installations
firebase --version
flutterfire --version
```

### Required Accounts

- Google account
- Firebase account (use same Google account)
- Flutter development environment set up

---

## 2. Firebase Project Setup

### Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click **"Add project"**
3. Enter project name: `shopping-app` (or your preferred name)
4. Enable Google Analytics (recommended)
5. Choose or create Analytics account
6. Click **"Create project"**

### Step 2: Enable Firebase Services

#### A. Authentication

1. In Firebase Console, go to **Build > Authentication**
2. Click **"Get started"**
3. Enable the following sign-in methods:
   - **Email/Password** ✅
   - **Google** ✅ (Configure OAuth consent screen)
   - **Apple** ✅ (For iOS only, configure Apple Sign In)
   - **Anonymous** ✅ (For guest checkout)

**Google Sign-In Setup**:
- Click on Google provider
- Enable it
- Enter your support email
- Download the config files when prompted

**Apple Sign-In Setup** (iOS only):
- Enable Apple provider
- Configure Team ID and Service ID in Apple Developer Console
- Add OAuth Code Flow configuration

#### B. Cloud Firestore

1. Go to **Build > Firestore Database**
2. Click **"Create database"**
3. Choose **Production mode** initially
4. Select your preferred location (choose closest to users)
5. Click **"Enable"**

#### C. Firebase Storage

1. Go to **Build > Storage**
2. Click **"Get started"**
3. Start in **Production mode**
4. Use same location as Firestore
5. Click **"Done"**

#### D. Cloud Functions

1. Go to **Build > Functions**
2. Click **"Get started"**
3. Upgrade to **Blaze plan** (pay-as-you-go, includes free tier)
   - Required for Cloud Functions
   - Free tier: 2M invocations/month
   - ~$0.40/million invocations after

#### E. Cloud Messaging (FCM)

1. Go to **Build > Cloud Messaging**
2. Already enabled by default
3. Note down your Server Key for later

#### F. Analytics & Crashlytics

1. Go to **Build > Analytics**
2. Already enabled if you enabled it during project creation
3. Go to **Build > Crashlytics**
4. Click **"Enable Crashlytics"**

---

## 3. Flutter Configuration

### Step 1: Login to Firebase

```bash
firebase login
```

### Step 2: Initialize Firebase in Project

```bash
cd shopping_app
firebase init
```

Select the following features:
- ☑ Firestore
- ☑ Functions
- ☑ Storage
- ☑ Hosting (optional, for admin panel)

**Firestore Configuration**:
- Use `firestore.rules` for rules
- Use `firestore.indexes.json` for indexes

**Functions Configuration**:
- Language: **TypeScript**
- ESLint: **Yes**
- Install dependencies: **Yes**

**Storage Configuration**:
- Use `storage.rules` for rules

**Hosting Configuration** (optional):
- Public directory: `build/web`
- Single-page app: **Yes**

### Step 3: Configure FlutterFire

```bash
flutterfire configure
```

This will:
1. List your Firebase projects
2. Let you select your project
3. Select platforms (iOS, Android, Web, macOS)
4. Generate `firebase_options.dart` with your config

Answer the prompts:
- Select your Firebase project
- Select platforms to support:
  - ☑ android
  - ☑ ios
  - ☑ web
  - ☐ macos (optional)
  - ☐ windows (optional)

### Step 4: Update `lib/main.dart`

Replace the existing main.dart with Firebase initialization:

```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/app_theme.dart';
import 'config/constants.dart';
import 'navigation/app_router.dart';
import 'providers/user_provider_riverpod.dart';
import 'services/firebase/firebase_options.dart';
import 'services/firebase/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Firebase services
  await FirebaseService.instance.initialize();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: kAppTitle,
      theme: userState.isLightTheme ? AppTheme.light() : AppTheme.dark(),
      routerConfig: appRouter,
      locale: userState.currentLocale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fr', 'FR'),
        Locale('en', 'US'),
        Locale('ar', 'TN'),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocaleLanguage in supportedLocales) {
          if (supportedLocaleLanguage.languageCode == locale?.languageCode &&
              supportedLocaleLanguage.countryCode == locale?.countryCode) {
            return supportedLocaleLanguage;
          }
        }
        return supportedLocales.first;
      },
    );
  }
}
```

---

## 4. Platform Setup

### Android Setup

#### Update `android/app/build.gradle`:

```gradle
android {
    ...
    defaultConfig {
        ...
        minSdkVersion 21  // Required for Firebase
        multiDexEnabled true  // Required for Firebase
    }
}

dependencies {
    ...
    implementation platform('com.google.firebase:firebase-bom:32.7.0')
}
```

#### Update `android/build.gradle`:

```gradle
buildscript {
    dependencies {
        ...
        classpath 'com.google.gms:google-services:4.4.0'
    }
}
```

#### Add to `android/app/build.gradle` (at the end):

```gradle
apply plugin: 'com.google.gms.google-services'
```

### iOS Setup

#### Update `ios/Podfile`:

```ruby
platform :ios, '13.0'  # Minimum iOS version for Firebase
```

#### Run pod install:

```bash
cd ios
pod install
cd ..
```

#### Add Firebase configuration:

The `flutterfire configure` command should have added `GoogleService-Info.plist` to your iOS project. If not:

1. Download `GoogleService-Info.plist` from Firebase Console
2. Add it to `ios/Runner/` directory
3. Add it to Xcode project:
   - Open `ios/Runner.xcworkspace` in Xcode
   - Drag `GoogleService-Info.plist` into Runner folder
   - Check "Copy items if needed"

---

## 5. Deploy Security Rules

### Deploy Firestore Rules

```bash
firebase deploy --only firestore:rules
```

### Deploy Firestore Indexes

```bash
firebase deploy --only firestore:indexes
```

### Deploy Storage Rules

```bash
firebase deploy --only storage
```

### Verify Deployment

1. Go to Firebase Console
2. Check **Firestore > Rules** - should show your custom rules
3. Check **Firestore > Indexes** - should show composite indexes
4. Check **Storage > Rules** - should show your custom rules

---

## 6. Deploy Cloud Functions

### Step 1: Install Dependencies

```bash
cd functions
npm install
```

### Step 2: Build Functions

```bash
npm run build
```

### Step 3: Test Locally (Optional)

```bash
npm run serve
```

This starts the Firebase Emulator Suite. Access at: `http://localhost:4000`

### Step 4: Deploy to Firebase

```bash
# Deploy all functions
firebase deploy --only functions

# Or deploy specific function
firebase deploy --only functions:onUserCreated
```

### Step 5: Verify Functions

```bash
# List deployed functions
firebase functions:list

# View function logs
firebase functions:log
```

---

## 7. Testing

### Test Authentication

```bash
# In your Flutter app
flutter run
```

1. Go to Register screen
2. Create a new account
3. Check Firebase Console > Authentication
4. Verify user was created
5. Check Firestore > users collection
6. Verify user document was created

### Test Firestore Rules

You can test rules in Firebase Console:

1. Go to **Firestore > Rules**
2. Click **Rules Playground**
3. Test different scenarios:
   - Unauthenticated user reading products (should succeed)
   - User reading own profile (should succeed)
   - User reading another user's profile (should fail)

### Test Storage Rules

1. Try uploading an avatar image
2. Check Firebase Console > Storage
3. Verify image was uploaded to correct path
4. Try accessing image URL (should work)

### Test Cloud Functions

#### Test onUserCreated:

1. Create a new user in app
2. Check Firebase Console > Functions > Logs
3. Verify function was triggered
4. Check Firestore for user document
5. Check notifications collection

#### Test validateCoupon:

```dart
// In your Flutter app
final result = await FirebaseFunctions.instance
    .httpsCallable('validateCoupon')
    .call({
      'code': 'WELCOME10',
      'cartTotal': 100.0,
      'userId': currentUserId,
    });

print(result.data);  // Should return validation result
```

---

## 8. Production Deployment

### Pre-Production Checklist

- [ ] Test all authentication methods
- [ ] Test all CRUD operations
- [ ] Verify security rules work correctly
- [ ] Test Cloud Functions locally
- [ ] Set up error monitoring
- [ ] Configure backup schedule
- [ ] Set up budget alerts

### Security Best Practices

1. **Enable App Check** (prevents API abuse):
   ```bash
   # In Firebase Console
   # Go to Build > App Check
   # Enable for all apps
   ```

2. **Set up Security Monitoring**:
   - Go to **Firestore > Usage**
   - Set up alerts for unusual activity

3. **Enable Audit Logs**:
   - Go to **IAM & Admin > Audit Logs**
   - Enable Cloud Firestore API logs

4. **Set Budget Alerts**:
   - Go to Google Cloud Console
   - Set up billing alerts
   - Recommended: Alert at 50%, 90%, 100% of budget

### Environment Variables for Functions

```bash
# Set environment variables
firebase functions:config:set stripe.secret_key="sk_test_..."
firebase functions:config:set sendgrid.api_key="SG...."

# View config
firebase functions:config:get

# Deploy with new config
firebase deploy --only functions
```

### Monitoring & Alerts

1. **Firebase Console > Analytics**
   - Monitor daily active users
   - Track conversion events

2. **Firebase Console > Crashlytics**
   - Monitor crash-free users
   - Track ANRs (Android)

3. **Firebase Console > Performance**
   - Monitor app start time
   - Track network requests

### Backup Strategy

1. **Automated Firestore Backups**:
   ```bash
   # Enable automated backups in Google Cloud Console
   # Go to Firestore > Backups
   # Schedule daily backups
   ```

2. **Storage Backup**:
   - Use Google Cloud Storage Transfer Service
   - Schedule regular backups

---

## Common Issues & Solutions

### Issue: "FirebaseApp not initialized"

**Solution**:
```dart
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

### Issue: Firestore permission denied

**Solution**:
- Check security rules
- Ensure user is authenticated
- Verify custom claims are set correctly

### Issue: Cloud Functions timeout

**Solution**:
- Increase timeout in function options:
  ```typescript
  export const myFunction = functions
    .runWith({ timeoutSeconds: 300 })
    .https.onCall(async () => {
      // ...
    });
  ```

### Issue: Storage upload fails

**Solution**:
- Check file size (max 5MB in current rules)
- Verify file is image
- Check storage rules
- Ensure user is authenticated

---

## Cost Optimization Tips

1. **Use Firestore Wisely**:
   - Minimize document reads
   - Use pagination
   - Cache frequently accessed data
   - Use collection group queries sparingly

2. **Optimize Cloud Functions**:
   - Use appropriate memory allocation
   - Set reasonable timeouts
   - Avoid cold starts with min instances
   - Use pub/sub for batch operations

3. **Storage Optimization**:
   - Compress images before upload
   - Use Cloud Functions to generate thumbnails
   - Clean up unused files regularly

4. **Enable Billing Alerts**:
   - Set daily spend limits
   - Monitor usage dashboard
   - Review costs monthly

---

## Next Steps

1. ✅ Set up Firebase project
2. ✅ Configure Flutter app
3. ✅ Deploy security rules
4. ✅ Deploy Cloud Functions
5. ⏳ Implement payment gateway
6. ⏳ Set up email notifications
7. ⏳ Implement admin dashboard
8. ⏳ Add analytics tracking
9. ⏳ Set up CI/CD pipeline

---

## Useful Commands Reference

```bash
# Firebase CLI
firebase login                          # Login to Firebase
firebase projects:list                  # List projects
firebase use <project-id>               # Switch project
firebase deploy                         # Deploy everything
firebase deploy --only firestore:rules  # Deploy only rules
firebase deploy --only functions        # Deploy only functions
firebase emulators:start                # Start emulators
firebase functions:log                  # View function logs

# FlutterFire CLI
flutterfire configure                   # Configure Firebase
flutterfire reconfigure                 # Reconfigure Firebase

# Flutter
flutter pub get                         # Get dependencies
flutter run                             # Run app
flutter build apk                       # Build Android
flutter build ios                       # Build iOS
flutter clean                           # Clean build
```

---

## Support & Resources

- **Firebase Documentation**: https://firebase.google.com/docs
- **FlutterFire Documentation**: https://firebase.flutter.dev
- **Firebase Console**: https://console.firebase.google.com
- **Firebase Support**: https://firebase.google.com/support
- **Stack Overflow**: Tag `firebase` + `flutter`

---

## Conclusion

You now have a fully configured Firebase backend for your Shopping App! 🎉

Your app includes:
- ✅ Authentication (Email, Google, Apple, Anonymous)
- ✅ Firestore Database with security rules
- ✅ Cloud Storage with security rules
- ✅ Cloud Functions for server-side logic
- ✅ Cloud Messaging for notifications
- ✅ Analytics and Crashlytics
- ✅ Production-ready architecture

**Remember**: Always test in development before deploying to production!

---

**Last Updated**: 2025-11-21
**Version**: 1.0
