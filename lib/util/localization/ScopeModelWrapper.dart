import 'package:flutter/material.dart';
import 'package:untitled/MyApp.dart';
import 'package:scoped_model/scoped_model.dart';

class ScopeModelWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(model: AppModel(), child: MyApp());
  }
}

class AppModel extends Model {
  Locale _appLocale = Locale('en');
  Locale get appLocal => _appLocale ?? Locale("ar");

  void changeDirection() {
    if (_appLocale == Locale("ar")) {
      _appLocale = Locale("en");
    } else {
      _appLocale = Locale("ar");
    }
    notifyListeners();
  }
}