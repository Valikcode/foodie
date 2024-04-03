import 'package:flutter/material.dart';

class DetailedRestaurantScreenDetails extends StatelessWidget {
  final String phoneNumber;
  final String categoriesName;
  final String averageCost;

  const DetailedRestaurantScreenDetails({
    Key? key,
    required this.phoneNumber,
    required this.categoriesName,
    required this.averageCost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Call",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w600)),
              Text(phoneNumber, style: const TextStyle(color: Colors.cyan)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Cuisines",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: _buildCuisineTextWidgets(categoriesName),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Average Cost",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w600)),
              Text(averageCost, style: const TextStyle(color: Colors.cyan)),
            ],
          ),
        ],
      ),
    );
  }
}

List<Widget> _buildCuisineTextWidgets(String categoriesName) {
  List<String> cuisines = categoriesName.split(', ');
  List<Widget> widgets = [];

  if (cuisines.length == 1) {
    widgets.add(
      Text(cuisines[0], style: const TextStyle(color: Colors.cyan)),
    );
  } else if (cuisines.length == 2) {
    widgets.add(
      Text("${cuisines[0]}, ${cuisines[1]}",
          style: const TextStyle(color: Colors.cyan)),
    );
  } else {
    widgets.add(
      Text("${cuisines[0]}, ${cuisines[1]},",
          style: const TextStyle(color: Colors.cyan)),
    );

    for (int i = 2; i < cuisines.length; i++) {
      widgets.add(
        Text(cuisines[i], style: const TextStyle(color: Colors.cyan)),
      );
    }
  }

  return widgets;
}
