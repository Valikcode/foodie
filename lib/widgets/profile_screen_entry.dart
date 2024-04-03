import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie/blocs/login/login_bloc.dart';
import 'package:foodie/values/routes.dart';

class ProfileEntry extends StatelessWidget {
  const ProfileEntry({
    super.key,
    required this.context,
    required this.title,
  });

  final BuildContext context;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (title == 'Log out') {
          BlocProvider.of<LoginBloc>(context).add(LogoutEvent());
          Navigator.of(context)
              .pushNamedAndRemoveUntil(Routes.login, (route) => false);
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Column(
          children: [
            Container(
              height: 50,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                ],
              ),
            ),
            Divider(
              indent: 16,
              endIndent: 16,
              height: 1,
              color: Colors.grey.withOpacity(0.3),
            ),
          ],
        ),
      ),
    );
  }
}
