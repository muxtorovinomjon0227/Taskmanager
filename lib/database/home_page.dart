import 'package:flutter/material.dart';

class DataBasePage extends StatefulWidget {
  const DataBasePage({Key? key}) : super(key: key);

  @override
  State<DataBasePage> createState() => _DataBasePageState();
}

class _DataBasePageState extends State<DataBasePage> {
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body:  Center(child:  Text("Data Base")),
    );
  }
}
