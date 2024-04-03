import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie/blocs/login/login_bloc.dart';
import 'package:foodie/values/colors.dart';
import 'package:foodie/values/strings.dart';

class LoginScreenGoogleSignInButton extends StatelessWidget {
  const LoginScreenGoogleSignInButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16),
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
              context.read<LoginBloc>().add(LoginWithGoogle());
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Color(AppColors.primaryColor)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            child: Text(
              AppStrings.loginWithGoogleButton,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
