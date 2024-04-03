import 'package:flutter/material.dart';
import 'package:foodie/values/routes.dart';
import 'package:foodie/values/strings.dart';

class InfoLoginButton extends StatelessWidget {
  const InfoLoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ], borderRadius: BorderRadius.circular(8)),
          child: ElevatedButton(
            onPressed: () {
              _navigateToLoginScreen(context);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            child: Text(
              AppStrings.loginButton,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, Routes.login);
  }
}
