import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/cubit/cubit.dart';
import 'package:flutter_application_1/cubit/stateSocial.dart';
import 'package:flutter_application_1/login/login_cubit/user_model.dart';
import 'package:flutter_application_1/screens/chatDetails.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Chats extends StatelessWidget {
  const Chats({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitSocial, SocialAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
              condition: CubitSocial.get(context).users.length > 0,
              builder: ((context) => ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      Item(CubitSocial.get(context).users[index], context),
                  separatorBuilder: (context, index) => MyProvider(),
                  itemCount: CubitSocial.get(context).users.length)),
              fallback: ((context) =>
                  Center(child: CircularProgressIndicator())));
        });
  }

  Widget Item(UserModel model, context) {
    return InkWell(
      onTap: (() {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => ChatDetails(
                    model: model,
                  ))),
        );
      }),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
                radius: 30, backgroundImage: NetworkImage('${model.image}')),
            SizedBox(
              width: 10,
            ),
            Text('${model.name}',
                style: TextStyle(
                    fontSize: 18, height: 1.3, fontWeight: FontWeight.w900)),
          ],
        ),
      ),
    );
  }
}
