import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/login/login_cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubitApp extends Cubit<LoginSocialAppStates> {
  CubitApp() : super(InitialLoginSocialAppState());

  static CubitApp get(context) => BlocProvider.of(context);

  void UseLogin({required String email, required String password}) {
    emit(LoadingLoginSocialAppState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);

      emit(SuccessfulyLoginSocialAppState(value.user!.uid));
    }).catchError((error) {
      emit(ErrorLoginSocialAppState(error.toString()));
    });
  }

  var ispassword = true;
  IconData suffix = Icons.visibility_outlined;
  void changePsswordVisibility() {
    ispassword = !ispassword;

    suffix =
        ispassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordSocialAppState());
  }
}

//  