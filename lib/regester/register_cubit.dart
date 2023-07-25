import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/login/login_cubit/user_model.dart';
import 'package:flutter_application_1/regester/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterCubitApp extends Cubit<RegisterSocialAppStates> {
  RegisterCubitApp() : super(InitialRegisterSocialAppState());

  static RegisterCubitApp get(context) => BlocProvider.of(context);
  void Register({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(LoadingRegisterSocialAppState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);

      CreatUser(email: email, uid: value.user!.uid, name: name, phone: phone);

      // emit(SuccessfulyRegisterSocialAppState());
    }).catchError((erorr) {
      emit(ErrorRegisterSocialAppState(erorr.toString()));
    });
  }

  void CreatUser({
    required String email,
    required String uid,
    required String name,
    required String phone,
  }) {
    UserModel? model = UserModel(
      email: email,
      name: name,
      phone: phone,
      uid: uid,
      emailVerified: false,
      image:
          'https://img.freepik.com/free-photo/no-problem-concept-bearded-man-makes-okay-gesture-has-everything-control-all-fine-gesture-wears-spectacles-jumper-poses-against-pink-wall-says-i-got-this-guarantees-something_273609-42817.jpg?w=740&t=st=1675047763~exp=1675048363~hmac=f30fe72cab33abe0895de59e061338d6cabaaf81ba28295e77db22588a5395de',
      bio: 'Write your bio',
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(model.toMap())
        .then((value) {
      emit(SuccessfulyCreatUserSocialAppState());
    }).catchError((error) {
      emit(ErrorCreatUserSocialAppState(error.toString()));
    });
  }

  var ispassword = true;
  IconData suffix = Icons.visibility_outlined;
  void changePsswordRegisterVisibility() {
    ispassword = !ispassword;

    suffix =
        ispassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordRegisterState());
  }
}
