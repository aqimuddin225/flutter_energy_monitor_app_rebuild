import 'package:flutter/material.dart';

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
                  bottom: index == widget.currentIndex ? 0 : widget.size.width * .029,
                  right: widget.size.width * .0422,
                  left: widget.size.width * .0422,
                ),
                width: widget.size.width * .128,
                height: index == widget.currentIndex ? widget.size.width * .014 : 0,
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
                color:
                    index == widget.currentIndex ? Colors.blueAccent : Colors.black38,
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
