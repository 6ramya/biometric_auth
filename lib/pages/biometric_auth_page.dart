import 'package:biometric_auth/local_auth_api.dart';
import 'package:biometric_auth/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class BiometricAuthPage extends StatelessWidget {
  const BiometricAuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Biometric Auth'), centerTitle: true, elevation: 0),
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildAvailability(context),
              SizedBox(height: 24),
              buildAuthenticate(context)
            ],
          )),
        ));
  }

  Widget buildAvailability(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
      onPressed: () async {
        final isAvailable = await LocalAuthApi.hasBiometrics();
        final biometrics = await LocalAuthApi.getBiometrics();

        final hasFingerprint = biometrics.contains(BiometricType.fingerprint);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Availability'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildText('Biometrics', isAvailable),
                    buildText('Fingerprint', hasFingerprint)
                  ],
                ),
              );
            });
      },
      icon: Icon(Icons.event_available, size: 26),
      label: Text('Check Availability', style: TextStyle(fontSize: 20)),
    );
  }

  Widget buildAuthenticate(BuildContext context) => ElevatedButton.icon(
        style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
        onPressed: () async {
          final isAuthenticated = await LocalAuthApi.authenticate();
          if (isAuthenticated) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          }
        },
        icon: Icon(Icons.lock_open, size: 26),
        label: Text('Authenticate', style: TextStyle(fontSize: 20)),
      );

  Widget buildText(String text, bool checked) => Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            checked
                ? Icon(Icons.check, color: Colors.green, size: 24)
                : Icon(Icons.close, color: Colors.red, size: 24),
            const SizedBox(width: 12),
            Text(text, style: TextStyle(fontSize: 24))
          ],
        ),
      );
}
