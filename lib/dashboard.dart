import 'package:flutter/material.dart';

class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Dashboard',
            style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontFamily: 'Product',
                fontSize: 40.0)),
      ),
    );
  }
}
