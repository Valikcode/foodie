import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie/blocs/info/info_screen_bloc.dart';
import 'package:foodie/widgets/info_screen_cards_pageview.dart';
import 'package:foodie/values/colors.dart';
import 'package:foodie/widgets/info_screen_card_description.dart';
import 'package:foodie/widgets/info_screen_pageview_status.dart';
import 'package:foodie/widgets/info_screen_login_button.dart';

class InfoScreen extends StatelessWidget {
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<InfoScreenBloc, InfoScreenState>(
      listener: (context, state) {
        _pageController.animateToPage(state.selectedIndex,
            duration: const Duration(milliseconds: 500), curve: Curves.linear);
      },
      child: Scaffold(
        backgroundColor: Color(AppColors.primaryColor),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: SizedBox(
                height: 300,
                child: InfoScreenCardsPageview(pageController: _pageController),
              ),
            ),
            const InfoCardDescription(),
            const SizedBox(
              height: 50,
            ),
            const InfoLoginButton(),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: BlocBuilder<InfoScreenBloc, InfoScreenState>(
                    builder: (context, state) {
                      return InfoPageviewStatus(
                          itemCount: 3, selectedIndex: state.selectedIndex);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
