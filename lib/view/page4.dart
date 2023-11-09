import 'package:flutter/material.dart';

class Page4Screen extends StatefulWidget {
  const Page4Screen({super.key});

  @override
  State<Page4Screen> createState() => _Page4ScreenState();
}

class _Page4ScreenState extends State<Page4Screen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
              flex: 3,
              child: Container(
                color: Colors.amber,
              )),
          Expanded(
              flex: 2,
              child: Container(
                color: Colors.red,
              )),
          Expanded(
              flex: 1,
              child: Container(
                color: Colors.green,
              ))
        ],
      ),
    );
  }
}
