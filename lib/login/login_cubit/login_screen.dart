import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/cach.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/layout_screen.dart';
import 'package:flutter_application_1/login/login_cubit/cubit.dart';
import 'package:flutter_application_1/login/login_cubit/states.dart';
import 'package:flutter_application_1/regester/register_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    var emailcontroller = TextEditingController();
    var passwordcontroller = TextEditingController();

    return BlocProvider(
        create: (context) => CubitApp(),
        child: BlocConsumer<CubitApp, LoginSocialAppStates>(
            listener: (context, state) {
          if (state is ErrorLoginSocialAppState) {
            ShowToast(msg: state.error, states: ToastStates.ERROR);
          }
          if (state is SuccessfulyLoginSocialAppState) {
            CachHelper.SaveData(value: state.uid, key: 'uid').then((value) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: ((context) => LayOutScreen())),
                  (route) => false);
            });
          }
        }, builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        SizedBox(height: 15),
                        Text('login now to comunicate with friendes',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.grey)),
                        SizedBox(height: 40),
                        TextFormField(
                            controller: emailcontroller,
                            decoration: const InputDecoration(
                              labelText: 'Email Address',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email must not be empty ';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                            controller: passwordcontroller,
                            decoration: InputDecoration(
                                labelText: 'password',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.lock_clock_outlined),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      CubitApp.get(context)
                                          .changePsswordVisibility();
                                    },
                                    icon: Icon(
                                      CubitApp.get(context).suffix,
                                    ))
                                //  Icon(Icons.visibility_outlined),
                                ),
                            obscureText: CubitApp.get(context).ispassword,
                            onFieldSubmitted: (value) {
                              if (formkey.currentState!.validate()) {
                                CubitApp.get(context).UseLogin(
                                    email: emailcontroller.text,
                                    password: passwordcontroller.text);
                              }
                            },
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'password is to short ';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 35,
                        ),
                        ConditionalBuilder(
                            condition: state is! LoadingLoginSocialAppState,
                            builder: ((context) => Container(
                                  decoration: BoxDecoration(
                                      color: defaulltColor,
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  height: 60,
                                  width: double.infinity,
                                  child: MaterialButton(
                                    child: Text(
                                      'LOGIN',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    onPressed: () {
                                      if (formkey.currentState!.validate()) {
                                        CubitApp.get(context).UseLogin(
                                            email: emailcontroller.text,
                                            password: passwordcontroller.text);
                                      }
                                    },
                                  ),
                                )),
                            fallback: ((context) =>
                                Center(child: CircularProgressIndicator()))),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('don\'t have an account?',
                                style: TextStyle(color: Colors.grey)),
                            SizedBox(
                              width: 15,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => Register())),
                                  );
                                },
                                child: Text(
                                  'REGISTER',
                                  style: TextStyle(color: defaulltColor),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
