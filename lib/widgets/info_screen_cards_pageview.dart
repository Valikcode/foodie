import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie/blocs/info/info_screen_bloc.dart';
import 'package:foodie/values/images.dart';
import 'package:foodie/values/strings.dart';
import 'package:foodie/widgets/info_screen_card.dart';

class InfoScreenCardsPageview extends StatelessWidget {
  const InfoScreenCardsPageview({
    super.key,
    required PageController pageController,
  }) : _pageController = pageController;

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) =>
          context.read<InfoScreenBloc>().add(PageChanged(index)),
      children: [
        InfoScreenCard(
          imagePath: AppImages.cardImage1,
          title: AppStrings.cardTitle1,
        ),
        InfoScreenCard(
          imagePath: AppImages.cardImage2,
          title: AppStrings.cardTitle2,
        ),
        InfoScreenCard(
          imagePath: AppImages.cardImage3,
          title: AppStrings.cardTitle3,
        ),
      ],
    );
  }
}
