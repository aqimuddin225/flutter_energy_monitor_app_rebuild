import 'package:flutter/material.dart';

class Equipment {
  final String name;
  final double power;
  final double consumptionCost;
  bool isOn;

  Equipment(
      {required this.name,
      required this.power,
      required this.consumptionCost,
      required this.isOn});
}

class Page2Screen extends StatefulWidget {
  const Page2Screen({super.key});

  @override
  State<Page2Screen> createState() => _Page2ScreenState();
}

class _Page2ScreenState extends State<Page2Screen> {
  final List<Equipment> equipmentList = [
    Equipment(name: 'Smart TV', power: 100, consumptionCost: 0.12, isOn: true),
    Equipment(
        name: 'Refrigerator', power: 150, consumptionCost: 0.18, isOn: true),
    Equipment(name: 'Laptop', power: 50, consumptionCost: 0.06, isOn: true),
    // Add more equipment as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TotalPowerCostInfo(equipmentList: equipmentList),
          SizedBox(height: 16),
          Text(
            'List of Electronic Equipment',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          EquipmentList(equipmentList: equipmentList),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle the action to add electronic devices
          // You can show a dialog or navigate to another screen for adding devices
          // For example:
          // Navigator.push(context, MaterialPageRoute(builder: (context) => AddDeviceScreen()));
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class TotalPowerCostInfo extends StatelessWidget {
  final List<Equipment> equipmentList;

  TotalPowerCostInfo({required this.equipmentList});

  @override
  Widget build(BuildContext context) {
    double totalPower =
        equipmentList.map((e) => e.power).fold(0, (a, b) => a + b);
    double totalCost = equipmentList
        .map((e) => e.power * e.consumptionCost)
        .fold(0, (a, b) => a + b);

    return Container(
      color: Colors.blueAccent,
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildInfoContainer(
              'Total Power', '${totalPower.toStringAsFixed(2)}W'),
          _buildInfoContainer(
              'Total Cost', '\$${totalCost.toStringAsFixed(2)}'),
        ],
      ),
    );
  }

  Widget _buildInfoContainer(String title, String value) {
    return Container(
      width: 150,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EquipmentList extends StatelessWidget {
  final List<Equipment> equipmentList;

  EquipmentList({required this.equipmentList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: equipmentList.length,
        itemBuilder: (context, index) {
          return EquipmentTile(equipment: equipmentList[index]);
        },
      ),
    );
  }
}

class EquipmentTile extends StatefulWidget {
  final Equipment equipment;

  EquipmentTile({required this.equipment});

  @override
  State<EquipmentTile> createState() => _EquipmentTileState();
}

class _EquipmentTileState extends State<EquipmentTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Icon(
          widget.equipment.isOn ? Icons.lightbulb : Icons.lightbulb_outline,
          color: widget.equipment.isOn ? Colors.yellow : Colors.grey,
        ), // You can replace this with a custom icon
        title: Text(
          widget.equipment.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Power: ${widget.equipment.power}W'),
            Text('Cost: \$${widget.equipment.consumptionCost} per kWh'),
          ],
        ),
        trailing: Switch(
          value: widget.equipment.isOn,
          onChanged: (newValue) {
            setState(() {
              widget.equipment.isOn = newValue;
            });
          },
        ), // You can customize the trailing icon
        onTap: () {
          // Add custom onTap functionality if needed
        },
      ),
    );
  }
}
