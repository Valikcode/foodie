import 'package:flutter/material.dart';

class InfoPageviewStatus extends StatelessWidget {
  final int itemCount;
  final int selectedIndex;

  const InfoPageviewStatus({
    Key? key,
    required this.itemCount,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          width: 12.0,
          height: 12.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == selectedIndex ? Colors.white : Colors.grey,
          ),
        );
      }),
    );
  }
}
