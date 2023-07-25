// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/cubit/cubit.dart';
import 'package:flutter_application_1/cubit/stateSocial.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var namecontroller = TextEditingController();
    var biocontroller = TextEditingController();
    var formkey = GlobalKey<FormState>();
    var phonecontroller = TextEditingController();

    return BlocConsumer<CubitSocial, SocialAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = CubitSocial.get(context).model;
          var profileImage = CubitSocial.get(context).Profileimage;
          namecontroller.text = CubitSocial.get(context).model!.name!;
          biocontroller.text = CubitSocial.get(context).model!.bio!;
          var coverImage = CubitSocial.get(context).coverimage;
          phonecontroller.text = CubitSocial.get(context).model!.phone!;

          return Scaffold(
              appBar: AppBar(
                title: Text('Edit Profile'),
                titleSpacing: 5,
                actions: [
                  TextButton(
                      onPressed: (() {
                        CubitSocial.get(context).UpdateUser(
                          bio: biocontroller.text,
                          name: namecontroller.text,
                          phone: phonecontroller.text,
                        );
                      }),
                      child: Text(
                        'UPDATE',
                        style: TextStyle(
                            color: defaulltColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      )),
                  SizedBox(
                    width: 15,
                  )
                ],
              ),
              body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formkey,
                    child: SingleChildScrollView(
                      child: Column(children: [
                        if (state is UpdateLodingState)
                          LinearProgressIndicator(),
                        if (state is UpdateLodingState)
                          SizedBox(
                            height: 10,
                          ),
                        Container(
                          height: 200,
                          child: Stack(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 150,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(4),
                                            topRight: Radius.circular(4)),
                                        image: DecorationImage(
                                            image: coverImage == null
                                                ? NetworkImage(
                                                    '${model!.cover}')
                                                : FileImage(coverImage)
                                                    as ImageProvider,
                                            fit: BoxFit.cover)),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional.topEnd,
                                    child: IconButton(
                                      onPressed: (() {
                                        CubitSocial.get(context)
                                            .GetCoverImage();
                                      }),
                                      icon: CircleAvatar(
                                          child: Icon(
                                        Icons.camera_enhance_outlined,
                                        size: 20,
                                      )),
                                    ),
                                  )
                                ],
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Stack(
                                  alignment: AlignmentDirectional.bottomEnd,
                                  children: [
                                    CircleAvatar(
                                      radius: 64,
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      child: CircleAvatar(
                                        radius: 60,
                                        backgroundImage: profileImage == null
                                            ? NetworkImage('${model!.image}')
                                            : FileImage(profileImage)
                                                as ImageProvider,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: (() {
                                        CubitSocial.get(context).GetImage();
                                      }),
                                      icon: CircleAvatar(
                                          child: Icon(
                                        Icons.camera_enhance_outlined,
                                        size: 20,
                                      )),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        if (CubitSocial.get(context).Profileimage != null ||
                            CubitSocial.get(context).coverimage != null)
                          Row(
                            children: [
                              if (CubitSocial.get(context).Profileimage != null)
                                Expanded(
                                  child: Column(
                                    children: [
                                      MaterialButton(
                                          color: defaulltColor,
                                          child: Text(
                                            'upload profile',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          onPressed: () {
                                            CubitSocial.get(context)
                                                .UploadProfileImage(
                                                    bio: biocontroller.text,
                                                    name: namecontroller.text,
                                                    phone:
                                                        phonecontroller.text);
                                          }),
                                      if (state is UpdateLodingState)
                                        SizedBox(
                                          height: 5,
                                        ),
                                      if (state is UpdateLodingState)
                                        LinearProgressIndicator(),
                                    ],
                                  ),
                                ),
                              SizedBox(
                                width: 5,
                              ),
                              if (CubitSocial.get(context).coverimage != null)
                                Expanded(
                                  child: Column(
                                    children: [
                                      MaterialButton(
                                          color: defaulltColor,
                                          child: Text(
                                            'upload cover',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          onPressed: () {
                                            CubitSocial.get(context)
                                                .UploadcoverImage(
                                                    bio: biocontroller.text,
                                                    name: namecontroller.text,
                                                    phone:
                                                        phonecontroller.text);
                                          }),
                                      if (state is UpdateLodingState)
                                        SizedBox(
                                          height: 5,
                                        ),
                                      if (state is UpdateLodingState)
                                        LinearProgressIndicator(),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        if (CubitSocial.get(context).Profileimage != null ||
                            CubitSocial.get(context).coverimage != null)
                          SizedBox(
                            height: 20,
                          ),
                        TextFormField(
                            controller: namecontroller,
                            decoration: const InputDecoration(
                              labelText: 'Name',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.person),
                            ),
                            keyboardType: TextInputType.name,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Name must not be empty ';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                            controller: biocontroller,
                            decoration: const InputDecoration(
                              labelText: 'Bio',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.info_outline),
                            ),
                            keyboardType: TextInputType.name,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Bio must not be empty ';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                            controller: phonecontroller,
                            decoration: const InputDecoration(
                              labelText: 'phone',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.phone),
                            ),
                            keyboardType: TextInputType.phone,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'phone must not be empty ';
                              }
                              return null;
                            }),
                      ]),
                    ),
                  )));
        });
  }
}
