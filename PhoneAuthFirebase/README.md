# Firebase Phone Auth

Stylish Login Page Integrated With Firebase Phone Auth Using SwiftUI 2.0

![PhoneAuthFirebaseScreenrecord1](https://user-images.githubusercontent.com/3436468/105577017-d93a4000-5db1-11eb-8d41-3f0988a6f45e.gif)

#### 1. Create Firebase Project for iOS app

<img width="511" alt="Firebase-create-project-ios" src="https://user-images.githubusercontent.com/3436468/103128199-500aed00-46cf-11eb-8753-78c88b64c2c5.png">

#### 2. Download Firebase info.plist

Add the .plist file to your Xcode project.

<img width="780" alt="firebase-ios-infoplist" src="https://user-images.githubusercontent.com/3436468/103128215-644eea00-46cf-11eb-9eec-334e3466b203.png">

#### 3. Enable Phone Authentication Sign-in Method in Firebase Console

Create phone numbers for testing.

<img width="1408" alt="firebase-phone-auth-enabled" src="https://user-images.githubusercontent.com/3436468/105577249-4c908180-5db3-11eb-9856-159839a97a4d.png">

#### 4. Add Firebase-ios Repository into Swift Package Manager

https://firebase.google.com/docs/ios/setup

<img width="1203" alt="firebase-ios-swift-github" src="https://user-images.githubusercontent.com/3436468/103128320-cf002580-46cf-11eb-8a86-3089e70f696e.png">

Add the **FirebaseAuth** Framework to your Xcode Project.

<img width="1286" alt="xcode-framework-fbauth" src="https://user-images.githubusercontent.com/3436468/105577285-806ba700-5db3-11eb-9dbb-ff9e60c4292a.png">

#### 5. Add the URL Schemes

Add the GoogleService-Info.plist `REVERSED_CLIENT_ID` value to your Xcode project > Info > URL Types > **URL Schemes**

<img width="1190" alt="xcode-google-plist-reversed-client-id" src="https://user-images.githubusercontent.com/3436468/105577197-f7547000-5db2-11eb-8b42-c6db43729b83.png">

<img width="1400" alt="xcode-url-types-url-schemes" src="https://user-images.githubusercontent.com/3436468/105577205-fde2e780-5db2-11eb-824b-36bb95904b35.png">

### Reference

- Part 1: https://www.youtube.com/watch?v=swbTmF0SuRw
- Part 2: https://www.youtube.com/watch?v=P4avA9K9r1U


