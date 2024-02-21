import 'package:telephony/telephony.dart';

/// Checks if you are awesome. Spoiler: you are.
class OtpAutofill {
  Telephony telephony = Telephony.instance;

  get listenForOtp async {
    String otpcode = "";
    telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) {
        print(message.address);
        print(message.body);

        String sms = message.body.toString();
        String appName = "SMS_Autofill"; //Replace your App Name

        if (message.body!.contains(appName)) {
          otpcode = sms.replaceAll(RegExp(r'[^0-9]'), '');
        } else {
          otpcode = "";
        }
      },
      listenInBackground: false,
    );

    return otpcode;
  }
}
