import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Home Drawer"),
    ),
    body: const Text("Home Drawer Navigation"),
    drawer: Drawer(
        child: ListView(
      children: <Widget>[Text("About us"), Text("Hinosa Information")],
    )),
  );
}
