import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weighttracker/main.dart';
import 'package:weighttracker/models/user_weights.dart';
import 'package:weighttracker/screens/home/settings_form.dart';
import 'package:weighttracker/screens/home/weight_list.dart';
import 'package:weighttracker/services/auth_service.dart';
import 'package:weighttracker/services/database_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;

    void _showEditPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: EditForm(),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.power_settings_new_rounded),
            tooltip: 'Sign Out',
            onPressed: () async {
              await _authService.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Main(),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamProvider<List<UserWeights>?>.value(
        initialData: null,
        value: DatabaseService(uid: '').weights,
        child: WeightList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showEditPanel();
        },
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }
}
