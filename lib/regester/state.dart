import 'package:flutter/material.dart';

abstract class RegisterSocialAppStates {}

class InitialRegisterSocialAppState extends RegisterSocialAppStates {}

class LoadingRegisterSocialAppState extends RegisterSocialAppStates {}

class SuccessfulyRegisterSocialAppState extends RegisterSocialAppStates {}

class ErrorRegisterSocialAppState extends RegisterSocialAppStates {
  final String error;
  ErrorRegisterSocialAppState(this.error);
}

class ChangePasswordRegisterState extends RegisterSocialAppStates {}

class SuccessfulyCreatUserSocialAppState extends RegisterSocialAppStates {}

class ErrorCreatUserSocialAppState extends RegisterSocialAppStates {
  final String error;
  ErrorCreatUserSocialAppState(this.error);
}
