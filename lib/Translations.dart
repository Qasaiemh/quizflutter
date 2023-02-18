import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/I10n/messages_all.dart';

class Translations {
  static Future<Translations> load(Locale locale) {
    final String name =
        (locale.countryCode != null && locale.countryCode!.isEmpty)
            ? locale.languageCode
            : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((dynamic _) {
      Intl.defaultLocale = localeName;
      return new Translations();
    });
  }

  static Translations? of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }



  String get login {
    return Intl.message(
      'Login',
      name: 'login',
    );
  }

  String get language {
    return Intl.message(
      'عربي',
      name: 'language',
    );
  }



  String get title {
    return Intl.message(
      'Title',
      name: 'title',
    );
  }

  String get numberOfRamadanDay {
    return Intl.message(
      'Day',
      name: 'numberOfRamadanDay',
    );
  }

  String get fawaneesDescription {
    return Intl.message(
      'Description',
      name: 'fawaneesDescription',
    );
  }

  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
    );
  }
}