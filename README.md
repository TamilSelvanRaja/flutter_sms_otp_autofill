# sms_otp_autofill

[![pub package](https://img.shields.io/pub/v/sms_autofill.svg)](https://pub.dartlang.org/packages/sms_autofill) Flutter plugin to provide SMS OTP autofill support for Android Version 10 to 14. 

For iOS, this package is not needed as the SMS autofill is provided by default, but not for Android, that's where this package is useful.

## Usage
You have one widgets at your disposable for autofill an SMS otp, Text.

Just before you sent your phone number to the backend, you need to let the plugin know that it needs to listen for the SMS with the otp.

To do that you need to do:

```dart
 telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) {
        print(message.address);
        print(message.body);

        String sms = message.body.toString();
        String appName = "SMS_Autofill"; //Replace your App Name

        if (message.body!.contains(appName)) {
          otpcode = sms.replaceAll(RegExp(r'[^0-9]'), '');
          setState(() {});
        } else {
          print("error");
        }
      },
      listenInBackground: false,
    );
```
This will listen for the SMS with the otp during 5 minutes and when received, autofill the following widget.


### Android SMS constraint
For the code to be receive, it need to follow some rules as describe here: https://developers.google.com/identity/sms-retriever/verify
- Be no longer than 140 bytes
- Contain a one-time code that the client sends back to your server to complete the verification flow

One example of SMS would be: 
```
AppName: Your code is 123456
``` 

## Helper
Need to Add Permission for (android/app/src/main) AndroidManifest.xml file : 
```xml
 <uses-permission android:name="android.permission.RECEIVE_SMS"/> 
 <application>
   <receiver android:name="com.shounakmulay.telephony.sms.IncomingSmsReceiver"
            android:permission="android.permission.BROADCAST_SMS" android:exported="true"> 
            <intent-filter> 
            <action android:name="android.provider.Telephony.SMS_RECEIVED"/> 
            </intent-filter> 
     </receiver>        
 </application>
```
Need to modify (android/app) build.gradle : 
```gradle
  defaultConfig {
     minSdkVersion 23
  }
```
