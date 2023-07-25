import 'package:conditional_builder_null_safety/example/example.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/cach.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/cubit/cubit.dart';
import 'package:flutter_application_1/cubit/stateSocial.dart';
import 'package:flutter_application_1/layout_screen.dart';
import 'package:flutter_application_1/login/login_cubit/login_screen.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> MessagingBackground(RemoteMessage message) async {
  print(message.data.toString());
  ShowToast(msg: 'on Background message', states: ToastStates.SUCCESS);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var token = await FirebaseMessaging.instance.getToken();
  print('${token}  ahooooo');
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    ShowToast(msg: 'on message', states: ToastStates.SUCCESS);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    ShowToast(msg: 'open app', states: ToastStates.SUCCESS);
  });
  FirebaseMessaging.onBackgroundMessage(MessagingBackground);

  await CachHelper.init();

  Widget widget;
  uId = CachHelper.getData(
    key: 'uid',
  );
  if (uId != null) {
    //   if (token != null) {
    widget = const LayOutScreen();
  } else {
    widget = LoginScreen();
  }
  // } else {
  //   widget = onboardingScreen();
  // }

  runApp(MyApp(
    startewidget: widget,
  ));
}

// compileSdkVersion flutter.compileSdkVersion
class MyApp extends StatelessWidget {
  final Widget startewidget;
  MyApp({required this.startewidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CubitSocial()
          ..getUserData()
          ..GetPosts()
          ..GetAllUsers(),
        child: BlocConsumer<CubitSocial, SocialAppStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: Colors.deepOrange,
                  scaffoldBackgroundColor: Colors.white,
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    selectedItemColor: Colors.deepOrange,
                    unselectedItemColor: Colors.grey,
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: defaulltColor,
                  ),
                  appBarTheme: const AppBarTheme(
                    titleSpacing: 20,

                    iconTheme: IconThemeData(color: Colors.black),
                    backgroundColor: Colors.white,
                    // ignore: deprecated_member_use
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarIconBrightness: Brightness.dark,
                        statusBarColor: Colors.white),
                    // ignore: deprecated_member_use
                    titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    elevation: 0,
                  ),
                  textTheme: TextTheme(
                      bodyText1: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black)),
                ),
                home: startewidget,
              );
            }));
  }
}
