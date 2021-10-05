import 'package:flutter/material.dart';
import 'package:weighttracker/screens/home/home.dart';
import 'package:weighttracker/services/auth_service.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: SafeArea(
        child: SizedBox(
          width: media.width,
          height: media.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  dynamic result = await _authService.signInAnonymously();
                  if (result == null) {
                    print('error signing in');
                  } else {
                    print('signed in');
                    print(result.uid);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(
                          title: 'Weight Tracker',
                        ),
                      ),
                    );
                  }
                },
                child: Text('Sign In Anonymously'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
