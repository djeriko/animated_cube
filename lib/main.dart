import 'package:flutter/material.dart';

import 'cubic_app.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: CubicApp(),
      ),
    );
  }
}
