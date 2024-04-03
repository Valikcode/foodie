import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie/blocs/home/home_bloc.dart';
import 'package:foodie/screens/main/category_screen.dart';

class DropdownSearchBox extends StatelessWidget {
  final String location;
  const DropdownSearchBox({
    required this.location,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey),
        ),
        child: DropdownSearch<String>(
          dropdownButtonProps: const DropdownButtonProps(isVisible: false),
          popupProps: const PopupProps.menu(
              showSelectedItems: true,
              searchDelay: Duration(milliseconds: 30),
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              )))),
          filterFn: (item, filter) =>
              item.toLowerCase().contains(filter.toLowerCase()),
          dropdownDecoratorProps: const DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
                border: InputBorder.none, // Remove the default bottom line
                hintText: "Search for restaurants...",
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.only(top: 12, left: 16)
                // prefixIcon: Icon(
                //   Icons.search,
                //   color: Colors.grey,
                // ),
                ),
          ),
          items: BlocProvider.of<HomeBloc>(context)
              .state
              .categoriesMap!
              .keys
              .toList(),
          onChanged: (selectedCategory) {
            if (selectedCategory != "Categories:") {
              final categoryAlias = BlocProvider.of<HomeBloc>(context)
                  .state
                  .categoriesMap![selectedCategory];
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryScreen(
                    categoryName: selectedCategory!,
                    categoryAlias: categoryAlias!,
                    location: location,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
