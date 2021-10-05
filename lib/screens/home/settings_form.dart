import 'package:weighttracker/models/app_users.dart';
import 'package:weighttracker/services/database_service.dart';
import 'package:weighttracker/shared/constants.dart';
import 'package:weighttracker/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditForm extends StatefulWidget {
  const EditForm({Key? key}) : super(key: key);

  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  final List<int> strengths = [100, 200, 300, 400, 500, 600, 700, 800, 900];

  // form values
  late String _currentName;
  late double _currentWeight;

  @override
  Widget build(BuildContext context) {
    AppUsers appUsers = Provider.of<AppUsers>(context);

    return StreamBuilder<AppUsersData>(
      stream: DatabaseService(uid: appUsers.uid).appUsersData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
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
                  decoration: textInputDecoration,
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter your name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  initialValue: appUsersData.weight.toString(),
                  decoration: textInputDecoration,
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter new weight' : null,
                  onChanged: (val) =>
                      setState(() => _currentWeight = double.parse(val)),
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await DatabaseService(uid: appUsers.uid)
                          .updateappUsersData(_currentName, _currentWeight);
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
