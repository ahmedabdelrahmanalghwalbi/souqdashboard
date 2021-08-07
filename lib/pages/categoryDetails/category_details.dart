import 'package:flutter/material.dart';

class CategoryDetails extends StatefulWidget {
  @override
  _CategoryDetailsState createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("وصف الفئة"),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
