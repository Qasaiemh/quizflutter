import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:scoped_model/scoped_model.dart';

import 'ScopeModelWrapper.dart';
import 'TranslationsDelegate.dart';
import 'main.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(builder: (context, child, model) {
      return MaterialApp(
        darkTheme: ThemeData.dark(), // standard dark theme
        locale: model.appLocal,
        localizationsDelegates: const [
          TranslationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''), // Englis
          const Locale('ar', ''), // Arabic
        ],
        debugShowCheckedModeBanner: false,
        home: new QuestionWidget(),
      );
    });
  }
}