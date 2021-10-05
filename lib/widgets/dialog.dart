import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weighttracker/models/app_users.dart';
import 'package:weighttracker/services/database_service.dart';

class Dialog extends StatefulWidget {
  const Dialog({Key? key}) : super(key: key);

  @override
  _DialogState createState() => _DialogState();
}

class _DialogState extends State<Dialog> {
  final _formKey = GlobalKey<FormState>();

  // form values
  late String _currentName;
  late double _currentWeight;
  @override
  Widget build(BuildContext context) {
    AppUsers appUsers = Provider.of<AppUsers>(context);

    return StreamBuilder<AppUsersData?>(
      stream: DatabaseService(uid: appUsers.uid).appUsersData,
      builder: (context, snapshot) {
        AppUsersData? appUsersData = snapshot.data;
        return Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                'Update your brew settings.',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                initialValue: appUsersData!.name,
                validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
                onChanged: (val) => setState(() => _currentName = val),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                initialValue: appUsersData!.weight,
                validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
                onChanged: (val) => setState(() => _currentName = val),
              ),
              SizedBox(height: 10.0),
              Slider(
                value: (_currentStrength ?? userData.strength).toDouble(),
                activeColor:
                    Colors.brown[_currentStrength ?? userData.strength],
                inactiveColor:
                    Colors.brown[_currentStrength ?? userData.strength],
                min: 100.0,
                max: 900.0,
                divisions: 8,
                onChanged: (val) =>
                    setState(() => _currentStrength = val.round()),
              ),
              RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await DatabaseService(uid: user.uid).updateUserData(
                          _currentSugars ?? snapshot.data.sugars,
                          _currentName ?? snapshot.data.name,
                          _currentStrength ?? snapshot.data.strength);
                      Navigator.pop(context);
                    }
                  }),
            ],
          ),
        );
      },
    );
  }
}
