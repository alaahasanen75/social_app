import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/cubit/cubit.dart';
import 'package:flutter_application_1/cubit/stateSocial.dart';
import 'package:flutter_application_1/login/login_cubit/user_model.dart';
import 'package:flutter_application_1/screens/chatmodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetails extends StatelessWidget {
  ChatDetails({super.key, required this.model});
  var controller = TextEditingController();
  UserModel model;
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      CubitSocial.get(context).GetMessages(reseverId: model.uid);

      return BlocConsumer<CubitSocial, SocialAppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  titleSpacing: 0,
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage('${model.image}'),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text('${model.name}')
                    ],
                  ),
                ),
                body: ConditionalBuilder(
                  condition: CubitSocial.get(context).messages.length > 0,
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: ((context, index) {
                              var messages =
                                  CubitSocial.get(context).messages[index];

                              if (CubitSocial.get(context).model!.uid ==
                                  messages.senderId) return Sender(messages);
                              return Resever(messages);
                            }),
                            separatorBuilder: (context, index) => SizedBox(
                              height: 15,
                            ),
                            itemCount: CubitSocial.get(context).messages.length,
                          ),
                        ),
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              )),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: controller,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '  type you massage here....'),
                                ),
                              ),
                              Container(
                                color: defaulltColor.shade400,
                                height: 50,
                                child: MaterialButton(
                                  onPressed: () {
                                    CubitSocial.get(context).SendMassage(
                                        text: controller.text,
                                        textTime: DateTime.now().toString(),
                                        reseverId: model.uid);
                                  },
                                  minWidth: 1,
                                  child: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  fallback: (context) =>
                      Center(child: CircularProgressIndicator()),
                ));
          });
    });
  }

  Widget Sender(ChatModel model) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10),
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            '${model.text}',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  Widget Resever(ChatModel model) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        decoration: BoxDecoration(
            color: defaulltColor.withOpacity(.2),
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10),
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            '${model.text}',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
