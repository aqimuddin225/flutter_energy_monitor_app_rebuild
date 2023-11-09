import 'package:flutter/material.dart';

class LampStatus {
  final String name;
  final int power;
  bool isOn;

  LampStatus(this.name, this.power, this.isOn);
}

class LampCard extends StatefulWidget {
  final LampStatus lampStatus;

  LampCard(this.lampStatus);

  @override
  _LampCardState createState() => _LampCardState();
}

class _LampCardState extends State<LampCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          widget.lampStatus.isOn ? Icons.lightbulb : Icons.lightbulb_outline,
          color: widget.lampStatus.isOn ? Colors.yellow : Colors.grey,
        ),
        title: Text(widget.lampStatus.name),
        subtitle: Text('Power: ${widget.lampStatus.power}W'),
        trailing: Switch(
          value: widget.lampStatus.isOn,
          onChanged: (newValue) {
            setState(() {
              widget.lampStatus.isOn = newValue;
            });
          },
        ),
      ),
    );
  }
}
