import 'package:flutter/material.dart';
import 'package:flutter_energy_monitor_app_01/data/notification_provider.dart';
import 'package:flutter_energy_monitor_app_01/view/page1.dart';
import 'package:flutter_energy_monitor_app_01/view/page2.dart';
import 'package:flutter_energy_monitor_app_01/view/page3.dart';
import 'package:flutter_energy_monitor_app_01/view/page4.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final notificationProvider = NotificationProvider();

  var currentIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    const Page1Screen(),
    const Page2Screen(),
    const Page3Screen(),
    const Page4Screen()
  ];

  final List<AppBar> _appBars = [
    AppBar(title: const Text('Energy Management App')),
    AppBar(title: const Text('Installed Device Information')),
    AppBar(title: const Text('Page 3')),
    AppBar(title: const Text('Page 4')),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appBars[currentIndex],
      body: _widgetOptions.elementAt(currentIndex),
      bottomNavigationBar: _CustomNavBar(
        size: size,
        currentIndex: currentIndex,
        onItemTapped: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}

class _CustomNavBar extends StatefulWidget {
  final Size size;
  final int currentIndex;
  final ValueChanged<int> onItemTapped;

  const _CustomNavBar({
    required this.size,
    required this.currentIndex,
    required this.onItemTapped,
  });

  @override
  State<_CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<_CustomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      height: widget.size.width * .155,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.15),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
        borderRadius: BorderRadius.circular(50),
      ),
      child: ListView.builder(
        itemCount: 4,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: widget.size.width * .024),
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            widget.onItemTapped(index);
          },
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 1500),
                curve: Curves.fastLinearToSlowEaseIn,
                margin: EdgeInsets.only(
                  bottom: index == widget.currentIndex
                      ? 0
                      : widget.size.width * .029,
                  right: widget.size.width * .0422,
                  left: widget.size.width * .0422,
                ),
                width: widget.size.width * .128,
                height:
                    index == widget.currentIndex ? widget.size.width * .014 : 0,
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(10),
                  ),
                ),
              ),
              Icon(
                listOfIcons[index],
                size: widget.size.width * .076,
                color: index == widget.currentIndex
                    ? Colors.blueAccent
                    : Colors.black38,
              ),
              SizedBox(height: widget.size.width * .03),
            ],
          ),
        ),
      ),
    );
  }

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.favorite_rounded,
    Icons.settings_rounded,
    Icons.person_rounded,
  ];
}
