import 'package:flutter/material.dart';

abstract class SocialAppStates {}

class InitialSocialAppState extends SocialAppStates {}

class LoadingSocialAppState extends SocialAppStates {}

class SuccessfulySocialAppState extends SocialAppStates {}

class ErrorSocialAppState extends SocialAppStates {
  final String error;
  ErrorSocialAppState(this.error);
}

class ChangeBottomNavState extends SocialAppStates {}

class PostState extends SocialAppStates {}

class SuccessfulyImageProfileState extends SocialAppStates {}

class ErrorImageProfileState extends SocialAppStates {}

class SuccessfulyImageCoverState extends SocialAppStates {}

class ErrorImageCoverState extends SocialAppStates {
  ErrorImageCoverState();
}

class SuccessfulyUploadImageProfileState extends SocialAppStates {}

class ErrorfulyUploadImageProfileState extends SocialAppStates {
  ErrorfulyUploadImageProfileState();
}

class SuccessfulyUploadImageCoverState extends SocialAppStates {}

class ErrorUploadImageCoverState extends SocialAppStates {
  ErrorUploadImageCoverState();
}

class UpdateLodingState extends SocialAppStates {}

class ErrorUpdateState extends SocialAppStates {}

class LoadingcreatePostState extends SocialAppStates {}

class SuccessfulycreatePostState extends SocialAppStates {}

class ErorrcreatePostState extends SocialAppStates {}

class SuccessfulyImagePostState extends SocialAppStates {}

class ErorrImagePostState extends SocialAppStates {}

class ErorrCreatePosttState extends SocialAppStates {}

class RemovepostimageState extends SocialAppStates {}

class GetPostsLoadingSocialAppState extends SocialAppStates {}

class GetPostsSuccessfulySocialAppState extends SocialAppStates {}

class GetPostsErrorSocialAppState extends SocialAppStates {}

class GetPostsLikesSuccessfulySocialAppState extends SocialAppStates {}

class GetPostsLikesErrorSocialAppState extends SocialAppStates {}

class LoadingGetAllUsersSocialAppState extends SocialAppStates {}

class SuccessfulyGetAllUsersSocialAppState extends SocialAppStates {}

class ErrorGetAllUsersSocialAppState extends SocialAppStates {}

class SuccessfulySendMassageSocialAppState extends SocialAppStates {}

class ErrorSendMassageSocialAppState extends SocialAppStates {}

class SuccessfulyGetMassageSocialAppState extends SocialAppStates {}

class ErrorGetMassageSocialAppState extends SocialAppStates {}
