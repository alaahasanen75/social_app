import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/cubit/stateSocial.dart';
import 'package:flutter_application_1/login/login_cubit/states.dart';
import 'package:flutter_application_1/login/login_cubit/user_model.dart';
import 'package:flutter_application_1/screens/chatmodel.dart';
import 'package:flutter_application_1/screens/chats.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:flutter_application_1/screens/newPost.dart';
import 'package:flutter_application_1/screens/postmodel.dart';
import 'package:flutter_application_1/screens/settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class CubitSocial extends Cubit<SocialAppStates> {
  CubitSocial() : super(InitialSocialAppState());

  static CubitSocial get(context) => BlocProvider.of(context);

  UserModel? model;

  void getUserData() {
    emit(LoadingSocialAppState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());

      model = UserModel.fromJson(value.data());

      emit(SuccessfulySocialAppState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorSocialAppState(onError.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> bottomScreen = [
    Home(),
    Chats(),
    NewPost(),
    Setting(),
  ];
  List<String> tittle = [
    'Home',
    'Chats',
    'Post',
    'Setting',
  ];

  void ChangeBottomNav(int index) {
    if (index == 1) {
      GetAllUsers();
    }
    if (index == 0) {
      GetPosts();
    }

    if (index == 2) {
      emit(PostState());
    } else {
      currentIndex = index;

      emit(ChangeBottomNavState());
    }
  }

  File? Profileimage;
  final picker = ImagePicker();

  Future<void> GetImage() async {
    final packidFile = await picker.pickImage(source: ImageSource.gallery);
    if (packidFile != null) {
      Profileimage = File(packidFile.path);
      emit(SuccessfulyImageProfileState());
    } else {
      print('no image selected');
      emit(ErrorImageProfileState());
    }
  }

  File? coverimage;

  Future<void> GetCoverImage() async {
    final packidFile = await picker.pickImage(source: ImageSource.gallery);
    if (packidFile != null) {
      coverimage = File(packidFile.path);
      emit(SuccessfulyImageCoverState());
    } else {
      print('no image selected');
      emit(ErrorImageCoverState());
    }
  }

  void UploadProfileImage({
    required String bio,
    required String name,
    required String phone,
  }) {
    emit(UpdateLodingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(Profileimage!.path).pathSegments.last}')
        .putFile(Profileimage!)
        .then((p0) => p0.ref.getDownloadURL().then((value) {
              print(value);
              // emit(SuccessfulyUploadImageProfileState());
              UpdateUser(bio: bio, name: name, phone: phone, image: value);
            }).catchError((error) {
              emit(ErrorUploadImageCoverState());
            }))
        .catchError((error) {
      ErrorUploadImageCoverState();
    });
  }

  void UploadcoverImage({
    required String bio,
    required String name,
    required String phone,
  }) {
    emit(UpdateLodingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(Profileimage!.path).pathSegments.last}')
        .putFile(Profileimage!)
        .then((p0) => p0.ref.getDownloadURL().then((value) {
              print(value);
              UpdateUser(bio: bio, name: name, phone: phone, cover: value);
            }).catchError((error) {
              emit(ErrorUploadImageCoverState());
            }))
        .catchError((error) {
      ErrorUploadImageCoverState();
    });
  }

  void UpdateUser({
    required String bio,
    required String name,
    required String phone,
    String? cover,
    String? image,
  }) {
    emit(UpdateLodingState());

    // UploadcoverImage();

    // UploadProfileImage();

    UserModel? model1 = UserModel(
      email: model!.email,
      name: name,
      phone: phone,
      uid: model!.uid,
      emailVerified: false,
      image: image ?? model!.image,
      bio: bio,
      cover: cover ?? model!.cover,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(model1.uid)
        .update(model1.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(ErrorUpdateState());
    });
  }

  void UploadPost({
    required String text,
    required String datatime,
  }) {
    emit(LoadingcreatePostState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postimage!.path).pathSegments.last}')
        .putFile(postimage!)
        .then((p0) => p0.ref.getDownloadURL().then((value) {
              print(value);
              CreatPost(
                datatime: datatime,
                postimage: value,
                text: text,
              );
            }).catchError((error) {
              emit(ErorrcreatePostState());
            }))
        .catchError((error) {
      emit(ErorrcreatePostState());
    });
  }

  void RemovePostimage() {
    postimage = null;

    emit(RemovepostimageState());
  }

  void CreatPost({
    required String text,
    required String datatime,
    String? postimage,
  }) {
    emit(LoadingcreatePostState());

    PostModel? model3 = PostModel(
      dateTime: datatime,
      name: model!.name,
      postImage: postimage ?? '',
      text: text,
      uid: model!.uid,
      image: model!.image,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model3.toMap())
        .then((value) {
      emit(SuccessfulycreatePostState());
    }).catchError((error) {
      emit(ErorrcreatePostState());
    });
  }

  File? postimage;

  Future<void> GetpostImage() async {
    final packidFile = await picker.pickImage(source: ImageSource.gallery);
    if (packidFile != null) {
      postimage = File(packidFile.path);
      emit(SuccessfulyImagePostState());
    } else {
      print('no image selected');
      emit((ErorrImagePostState()));
    }
  }

  List<PostModel> posts = [];
  List<String> postId = [];

  List<int> like = [];
  List<int>? comment = [];

  void GetPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          like.add(value.docs.length);
          postId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError(() {});
      });

      value.docs.forEach((element) {
        element.reference.collection('comment').get().then((value) {
          comment!.add(value.docs.length);
        }).catchError(() {});
      });

      emit(GetPostsSuccessfulySocialAppState());
    }).catchError((onError) {
      emit(GetPostsErrorSocialAppState());
    });
  }

  void LikePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.uid)
        .set({
      'like': true,
    }).then((value) {
      emit(GetPostsLikesSuccessfulySocialAppState());
    }).catchError(() {
      emit(GetPostsLikesErrorSocialAppState());
    });
  }

  void commentPost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comment')
        .doc(model!.uid)
        .set({
      'comment': true,
    }).then((value) {
      emit(GetPostsLikesSuccessfulySocialAppState());
    }).catchError(() {
      emit(GetPostsLikesErrorSocialAppState());
    });
  }

  List<UserModel> users = [];

  void GetAllUsers() {
    if (users.length == 0) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uid'] != model!.uid)
            users.add(UserModel.fromJson(element.data()));
        });

        emit(SuccessfulyGetAllUsersSocialAppState());
      }).catchError((onError) {
        emit(ErrorGetAllUsersSocialAppState());
      });
    }
  }

  void SendMassage({
    @required String? text,
    @required String? textTime,
    @required String? reseverId,
  }) {
    ChatModel model4 = ChatModel(
      reseverId: reseverId,
      text: text,
      textTime: textTime,
      senderId: model!.uid,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uid)
        .collection('chats')
        .doc(reseverId)
        .collection('messages')
        .add(model4.toMap())
        .then((value) {
      emit(SuccessfulySendMassageSocialAppState());
    }).catchError(() {
      emit(ErrorSendMassageSocialAppState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(reseverId)
        .collection('chats')
        .doc(model!.uid)
        .collection('messages')
        .add(model4.toMap())
        .then((value) {
      emit(SuccessfulySendMassageSocialAppState());
    }).catchError(() {
      emit(ErrorSendMassageSocialAppState());
    });
  }

  List<ChatModel> messages = [];

  void GetMessages({
    @required String? reseverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uid)
        .collection('chats')
        .doc(reseverId)
        .collection('messages')
        .orderBy('textTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(ChatModel.fromJson(element.data()));
      });
    });
    emit(SuccessfulyGetMassageSocialAppState());
  }
}
