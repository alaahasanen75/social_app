import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/cubit/cubit.dart';
import 'package:flutter_application_1/cubit/stateSocial.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPost extends StatelessWidget {
  NewPost({super.key});
  var controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitSocial, SocialAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = CubitSocial.get(context).model;
          return Scaffold(
            appBar: AppBar(
              title: Text('Create Post'),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: (() {
                  Navigator.pop(context);
                }),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      var now = DateTime.now();
                      if (CubitSocial.get(context).postimage == null) {
                        CubitSocial.get(context).CreatPost(
                            text: controller.text, datatime: now.toString());
                      } else {
                        // CubitSocial.get(context).UploadPost(
                        //     text: controller.text, datatime: now.toString());
                      }
                    },
                    child: Text(
                      'post',
                      style: TextStyle(
                          color: defaulltColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if (state is LoadingcreatePostState)
                    LinearProgressIndicator(),
                  if (state is LoadingcreatePostState)
                    SizedBox(
                      height: 10,
                    ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            CubitSocial.get(context).Profileimage == null
                                ? NetworkImage(
                                    '${CubitSocial.get(context).model!.image}')
                                : FileImage(
                                        CubitSocial.get(context).Profileimage!)
                                    as ImageProvider,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('${model!.name}',
                                    style: TextStyle(
                                        height: 1.3,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900)),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: controller,
                      decoration: InputDecoration(
                          hintText: 'what is on your mind,',
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (CubitSocial.get(context).postimage != null)
                    Stack(
                      children: [
                        Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              image: DecorationImage(
                                  image: FileImage(
                                          CubitSocial.get(context).postimage!)
                                      as ImageProvider,
                                  fit: BoxFit.cover)),
                        ),
                        Align(
                          alignment: AlignmentDirectional.topEnd,
                          child: IconButton(
                            onPressed: (() {
                              CubitSocial.get(context).RemovePostimage();
                            }),
                            icon: CircleAvatar(
                                child: Icon(
                              Icons.close_rounded,
                              size: 20,
                            )),
                          ),
                        )
                      ],
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.photo_outlined,
                                color: defaulltColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'add photo',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          onPressed: () {
                            CubitSocial.get(context).GetpostImage();
                          },
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextButton(
                          child: Row(
                            children: [
                              Text(
                                '       # tages',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
