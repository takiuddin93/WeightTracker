import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weighttracker/models/app_users.dart';
import 'package:weighttracker/screens/home/home.dart';
import 'package:weighttracker/screens/authentication/sign_in.dart';

class Authenticate extends StatelessWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appUser = Provider.of<AppUsers?>(context);
    print(appUser);
    if (appUser == null) {
      return SignIn();
    } else {
      return Home(
        title: 'Weight Tracker',
      );
    }
  }
}
