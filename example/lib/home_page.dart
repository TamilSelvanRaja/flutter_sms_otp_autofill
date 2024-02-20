import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

class OtpReceiverView extends StatefulWidget {
  const OtpReceiverView({
    Key? key,
  }) : super(key: key);

  @override
  State<OtpReceiverView> createState() => _OtpReceiverViewState();
}

class _OtpReceiverViewState extends State<OtpReceiverView> with TickerProviderStateMixin {
  String otpcode = '';
  Telephony telephony = Telephony.instance;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('SMS OTP Auto Fill Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              otpcode,
              style: const TextStyle(fontSize: 18, color: Colors.blue, fontWeight: FontWeight.w800),
            )
          ],
        ),
      ),
    );
  }
}
