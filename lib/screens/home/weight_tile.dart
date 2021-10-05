import 'package:flutter/material.dart';
import 'package:weighttracker/models/user_weights.dart';

class WeightTile extends StatelessWidget {
  final UserWeights userWeights;
  const WeightTile({required this.userWeights});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[userWeights.weight.toInt()],
          ),
          title: Text(userWeights.name),
          subtitle: Text('Weighs ${userWeights.weight} KG(s)'),
        ),
      ),
    );
  }
}
