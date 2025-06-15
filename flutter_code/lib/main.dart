import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LocalAuthScreen(),
    );
  }
}

class LocalAuthScreen extends StatefulWidget {
  @override
  _LocalAuthScreenState createState() => _LocalAuthScreenState();
}

class _LocalAuthScreenState extends State<LocalAuthScreen> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  String _authStatus = 'Not Authorized';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local Authentication Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Authentication Status:',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            Text(
              _authStatus,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: _authenticate,
              child: Text('Authenticate'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _authenticate() async {
    final bool canAuthenticateWithBiometrics = await _localAuth.canCheckBiometrics;
    final bool isDeviceSupported = await _localAuth.isDeviceSupported();

    if (!canAuthenticateWithBiometrics || !isDeviceSupported) {
      _showErrorDialog("Biometric authentication is not available on this device.");
      return;
    }

    final List<BiometricType> availableBiometrics = await _localAuth.getAvailableBiometrics();

    if (availableBiometrics.isEmpty) {
      _showErrorDialog("No biometrics are enrolled on this device.");
      return;
    }

    try {
      final bool didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to access your account',
        useErrorDialogs: true,
        stickyAuth: true,
        androidAuthStrings: const AndroidAuthMessages(
          signInTitle: 'Biometric Authentication Required',
          cancelButton: 'Cancel',
        ),
        iOSAuthStrings: const IOSAuthMessages(
          lockOut: 'Biometric Authentication Required',
          cancelButton: 'Cancel',
        ),
      );

      if (didAuthenticate) {
        setState(() {
          _authStatus = 'Authorized';
        });
      } else {
        setState(() {
          _authStatus = 'Not Authorized';
        });
      }
    } on PlatformException catch (e) {
      if (e.code == auth_error.notEnrolled) {
        _showErrorDialog("No biometrics are enrolled on this device.");
      } else if (e.code == auth_error.lockedOut || e.code == auth_error.permanentlyLockedOut) {
        _showErrorDialog("Biometric authentication is locked out.");
      } else {
        _showErrorDialog("An error occurred: ${e.message}");
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
