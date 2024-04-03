import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie/blocs/main/main_bloc.dart';

import '../values/colors.dart';

class BtmNavBar extends StatelessWidget {
  const BtmNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Color(AppColors.primaryColor),
          selectedIconTheme: const IconThemeData(size: 30),
          unselectedIconTheme: const IconThemeData(size: 30),
          type: BottomNavigationBarType.fixed,
          currentIndex: state.pageIndex,
          onTap: (index) {
            BlocProvider.of<MainBloc>(context).add(ChangePage(index));
          },
          items: [
            bottomNavBarItem(const Icon(Icons.home_outlined)),
            bottomNavBarItem(const Icon(Icons.location_on_outlined)),
            bottomNavBarItem(const Icon(Icons.favorite_outline)),
            bottomNavBarItem(const Icon(Icons.person_outlined)),
          ],
        );
      },
    );
  }

  BottomNavigationBarItem bottomNavBarItem(Icon icon) =>
      BottomNavigationBarItem(icon: icon, label: '');
}
