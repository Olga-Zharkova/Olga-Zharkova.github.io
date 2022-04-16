import 'package:flutter/material.dart';
import 'package:untitled1/pages/main_user.dart';

class Plan extends StatefulWidget {
  const Plan({Key? key}) : super(key: key);

  @override
  State<Plan> createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: AppBar(
        title: Text('Планер',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.red[50],
              fontFamily: 'SyneMono',
            )
        ),
        centerTitle: true,
        backgroundColor: Colors.red[200],
      ),
      body: Text("Это сделаю потом"),
    );
  }
}

