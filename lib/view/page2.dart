import 'package:flutter/material.dart';
import 'package:flutter_energy_monitor_app_01/view/widget/lamp_card.dart';

class Page2Screen extends StatefulWidget {
  const Page2Screen({super.key});

  @override
  State<Page2Screen> createState() => _Page2ScreenState();
}

class _Page2ScreenState extends State<Page2Screen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: <Widget>[
          const Text('Header Text'),
          const Divider(), // A divider line
          Container(
            height: 100,
            color: Colors.blue,
            alignment: Alignment.center,
            child: const Text('Custom Widget'),
          ),
          LampCard(LampStatus('name', 70, true)),
          LampCard(LampStatus('name', 70, true)),
          LampCard(LampStatus('name', 70, true)),
          LampCard(LampStatus('name', 70, true)),
          LampCard(LampStatus('name', 70, true)),
          LampCard(LampStatus('name', 70, true)),
          LampCard(LampStatus('name', 70, true)),
          LampCard(LampStatus('name', 70, true)),
          LampCard(LampStatus('name', 70, true)),
          LampCard(LampStatus('name', 70, true)),
          LampCard(LampStatus('name', 70, true)),
          LampCard(LampStatus('name', 70, true))
        ],
      ),
    );
  }
}
