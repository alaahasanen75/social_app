import 'package:flutter/material.dart';

abstract class LoginSocialAppStates {}

class InitialLoginSocialAppState extends LoginSocialAppStates {}

class LoadingLoginSocialAppState extends LoginSocialAppStates {}

class SuccessfulyLoginSocialAppState extends LoginSocialAppStates {
  final String uid;
  SuccessfulyLoginSocialAppState(this.uid);
}

class ErrorLoginSocialAppState extends LoginSocialAppStates {
  final String error;
  ErrorLoginSocialAppState(this.error);
}

class ChangePasswordSocialAppState extends LoginSocialAppStates {}
