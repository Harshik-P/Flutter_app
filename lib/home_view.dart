import 'package:flutter/material.dart';
import 'jobs.dart';
import 'package:flutter/rendering.dart';

class HomeView extends StatelessWidget {
  final List<Job> jobsList = [
    Job("Carpenter"),
    Job("Electrician"),
    Job("Gardener"),
    Job("AC Service"),
    Job("Pest Control"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new ListView.builder(
          itemCount: jobsList.length,
          itemBuilder: (BuildContext context, int index) =>
              buildTripCard(context, index)),
    );
  }

  Widget buildTripCard(BuildContext context, int index) {
    final trip = jobsList[index];
    return new Container(
      child: Card(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 25.0, bottom: 40.0),
                child: Row(children: <Widget>[
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(trip.title, style: new TextStyle(fontSize: 30.0),),
                  Spacer(),
                  Icon(Icons.chat)
                      ],
                    ),
                  )
                ]),
              ),
          );
  }
}