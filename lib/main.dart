import 'package:flutter/material.dart';
import 'package:forecanvass/userLogin.dart';
import 'text.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'translate.dart';



void main() async {
  // Initializes the translation module
  await allTranslations.init('en');

  // then start the application
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final AllText allText = AllText();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      // Tells the system which are the supported languages
      supportedLocales: allTranslations.supportedLocales(),
      key: Key('counter'),

      title: allText.foreCanvass,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/',
      routes: {
        /*
            '/'         - Naming Label, this will be used for Navigator.popUntil(context, ModalRoute.withName('') so the app knows where to return to
            (context)   - ??
            CodeInput() - The class that you will be accessing after Navigator.popUntil
        */
        '/': (context) => UserLogin(),
      },
    );
  }
}
