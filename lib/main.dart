import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:questions_app/home_page_category_list/ui/home_page_list.dart';
import 'package:questions_app/log_in/ui/sign_up_page.dart';
import 'package:questions_app/questions_list/ui/question_list_page.dart';
import 'package:questions_app/log_in/provider/auth_service.dart';
import 'package:questions_app/auth_wrapper.dart';
import 'package:questions_app/log_in/ui/sign_in_page.dart';
import 'publish_question/ui/publish_question.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthService>().authStateChanges,
        )
      ],
      child: MaterialApp(
        title: 'Questions?!',
        debugShowCheckedModeBanner: false,
        initialRoute: "auth_wrapper",
        routes: {
          "auth_wrapper"    : (BuildContext context) => AuthWrapper(),
          "log_in"          : (BuildContext context) => SignInPage(),
          "sign_up"         : (BuildContext context) => SignUpPage(),

          "home_page_list"  : (BuildContext context) => HomePage(),

          "questions_list"  : (BuildContext context) => QuestionsList(),
          "create_question" : (BuildContext context) => PublishQuestion()
        },
      )
    );
  }
}


//TEST
//ANOTHER TEST
