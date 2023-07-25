// import 'dart:html';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/cubit/cubit.dart';
import 'package:flutter_application_1/cubit/stateSocial.dart';
import 'package:flutter_application_1/screens/postmodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitSocial, SocialAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            builder: (context) => SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 5,
                      margin: EdgeInsets.all(5),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: [
                          Image(
                            image: NetworkImage(
                                'https://img.freepik.com/free-photo/happy-glad-curly-haired-woman-winks-eye-makes-peace-gesture-smiles-broadly-looks-away-has-cheerful-expression-focused-away-isolated-red-background-blank-space-your-advertising-content_273609-61422.jpg?w=900&t=st=1674873228~exp=1674873828~hmac=480fd56d0c77577bf7fa3eeb9e1f3bfe757e5356a5af1e0b560e452966ad7e3b'),
                            fit: BoxFit.cover,
                            height: 200,
                            width: double.infinity,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'comunicate with friends',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: ((context, index) => postItem(
                        CubitSocial.get(context).posts[index],
                        index,
                        context)!),
                    itemCount: CubitSocial.get(context).posts.length,
                    separatorBuilder: (context, index) => SizedBox(
                      height: 8,
                    ),
                  )
                ],
              ),
            ),
            condition: CubitSocial.get(context).posts.length > 0 &&
                CubitSocial.get(context).model != null,
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        });
  }

  Widget? postItem(PostModel? model1, index, context) => Card(
        margin: EdgeInsets.all(5),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        "${CubitSocial.get(context).model!.image}",
                      )

                      //     //     'https://img.freepik.com/free-photo/red-black-brush-stroke-banner-background-perfect-canva_1361-3597.jpg?w=826&t=st=1676479471~exp=1676480071~hmac=3717c12338b1ba6cdbbf009579f51e89a3e457717777ba1b28e2118bdd38c577'),

                      )

                  //
                  // ignore: avoid_print
                  ,
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('${model1!.name}',
                                style: TextStyle(
                                    fontSize: 18,
                                    height: 1.3,
                                    fontWeight: FontWeight.w900)),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: Color.fromARGB(255, 7, 131, 233),
                              size: 17,
                            )
                          ],
                        ),
                        Text(
                          '${model1.dateTime}',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(height: 1.3),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  IconButton(
                      onPressed: (() {}),
                      icon: Icon(
                        Icons.more_horiz_outlined,
                        size: 17,
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                '${model1.text}',
                style: TextStyle(
                    fontSize: 15, height: 1.5, fontWeight: FontWeight.w900),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 15,
                  top: 10,
                ),
                child: Container(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 5),
                        child: Container(
                          height: 20,
                          child: MaterialButton(
                            minWidth: 1,
                            onPressed: (() {}),
                            padding: EdgeInsets.zero,
                            child: Text(
                              '#softwere',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (model1.postImage != '')
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: NetworkImage('${model1.postImage}'),
                            fit: BoxFit.cover)),
                  ),
                ),
              SizedBox(
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: (() {}),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              Icon(
                                Icons.favorite_sharp,
                                size: 20,
                                color: defaulltColor,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text('${CubitSocial.get(context).like[index]}',
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (() {}),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.chat,
                                size: 20,
                                color: Colors.amberAccent,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                  '${CubitSocial.get(context).comment![index]} comment',
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
              ),
              Row(children: [
                InkWell(
                  onTap: () {
                    CubitSocial.get(context)
                        .commentPost(CubitSocial.get(context).postId[index]);
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            CubitSocial.get(context).Profileimage == null
                                ? NetworkImage(
                                    '${CubitSocial.get(context).model!.image}')
                                : FileImage(
                                        CubitSocial.get(context).Profileimage!)
                                    as ImageProvider,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(' write a comment....',
                          style: TextStyle(
                              color: Colors.black54,
                              height: 1.3,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: (() {
                    print('${model1.image}');
                    CubitSocial.get(context)
                        .LikePost(CubitSocial.get(context).postId[index]);
                  }),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite_sharp,
                          size: 20,
                          color: defaulltColor,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Like',
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ),
              ])
            ],
          ),
        ),
      );
}
