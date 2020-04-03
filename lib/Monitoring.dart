import 'package:flutter/material.dart';
import 'LoginRegisterPage.dart';
import 'TimelinePage.dart';
import 'Authentication.dart';

class MonitoringPage extends StatefulWidget {
  final AuthImplementation auth;
  
  MonitoringPage ({
    this.auth,
  });

  @override
  _MonitoringPageState createState() => _MonitoringPageState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
}

class _MonitoringPageState extends State<MonitoringPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;

//check if user already logedin
  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((firebaseUserId) {
      setState(() {
         authStatus = firebaseUserId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch(authStatus) {

      case AuthStatus.signedIn: 
      return new TimelinePage(
        auth: widget.auth,
        onSignedOut: _signedOut,
      );
      
      case AuthStatus.notSignedIn:
      return new LoginRegisterPage (
        auth: widget.auth,
        onsignedIn: _signedIn,
      );

    }
  }
}
