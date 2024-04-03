import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie/blocs/login/login_bloc.dart';
import 'package:foodie/values/colors.dart';
import 'package:foodie/widgets/profile_screen_avatar.dart';
import 'package:foodie/widgets/profile_screen_entry.dart';
import 'package:foodie/widgets/profile_screen_location.dart';
import 'package:foodie/widgets/profile_screen_name.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<LoginBloc>(context).add(FetchUserInfo());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          iconSize: 30,
          color: Color(AppColors.primaryColor),
          onPressed: () {
            exit(0);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              "Edit",
              style: TextStyle(fontSize: 16, color: Colors.cyan[500]!),
            ),
          ),
        ],
        toolbarHeight: 48,
      ),
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Avatar(imageUrl: state.photoUrl),
                  const SizedBox(height: 10),
                  Name(name: state.name),
                  const Location(),
                  const SizedBox(height: 20),
                  ProfileEntry(context: context, title: 'Payment methods'),
                  ProfileEntry(context: context, title: 'Invite Friends'),
                  ProfileEntry(context: context, title: 'Settings'),
                  ProfileEntry(context: context, title: 'Log out'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
