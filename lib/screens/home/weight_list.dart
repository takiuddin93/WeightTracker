import 'package:weighttracker/models/user_weights.dart';
import 'package:weighttracker/screens/home/weight_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WeightList extends StatefulWidget {
  const WeightList({Key? key}) : super(key: key);

  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<WeightList> {
  @override
  Widget build(BuildContext context) {
    final userWeights = Provider.of<List<UserWeights>>(context);

    return ListView.builder(
      itemCount: userWeights.length,
      itemBuilder: (context, index) {
        return WeightTile(userWeights: userWeights[index]);
      },
    );
  }
}
