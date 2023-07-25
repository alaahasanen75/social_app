import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/cubit/cubit.dart';
import 'package:flutter_application_1/cubit/stateSocial.dart';
import 'package:flutter_application_1/screens/newPost.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayOutScreen extends StatelessWidget {
  const LayOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitSocial, SocialAppStates>(
        listener: (context, state) {
      if (state is PostState) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => NewPost()));
      }
    }, builder: (context, state) {
      var cubit = CubitSocial.get(context);
      GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

      return Scaffold(
        appBar: AppBar(
          title: Text(cubit.tittle[cubit.currentIndex]),
          actions: [
            IconButton(
              onPressed: (() {}),
              icon: const Icon(Icons.notification_add_outlined),
              color: defaulltColor,
            ),
            IconButton(
              onPressed: (() {}),
              icon: const Icon(Icons.search),
              color: defaulltColor,
            )
          ],
        ),
        body: cubit.bottomScreen[cubit.currentIndex],
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: cubit.currentIndex,
          height: 60.0,
          items: [
            const Icon(
              Icons.home,
              size: 30,
              color: Colors.black87,
            ),
            const Icon(
              Icons.chat_outlined,
              size: 30,
              color: Colors.black87,
            ),
            const Icon(
              Icons.upload_file_rounded,
              size: 25,
              color: Colors.black87,
            ),
            const Icon(
              Icons.settings,
              size: 30,
              color: Colors.black87,
            ),
          ],
          animationCurve: Curves.easeInOutCirc,
          color: defaulltColor,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.white,
          animationDuration: const Duration(milliseconds: 300),
          onTap: (index) {
            cubit.ChangeBottomNav(index);
            print(index);
            print(cubit.currentIndex);
          },
          letIndexChange: (index) => true,
        ),
      );
    });
  }
}
