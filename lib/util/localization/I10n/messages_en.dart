
import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

// ignore: unused_element
final _keepAnalysisHappy = Intl.defaultLocale;

// ignore: non_constant_identifier_names
typedef MessageIfAbsent(String message_str, List args);

class MessageLookup extends MessageLookupByLibrary {
  get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "title" : MessageLookupByLibrary.simpleMessage("Fawanees Challenge"),
    "numberOfRamadanDay" : MessageLookupByLibrary.simpleMessage("Day"),
    "language" : MessageLookupByLibrary.simpleMessage("عربي"),
    "confirm" : MessageLookupByLibrary.simpleMessage("CONFIRM"),
    "fawaneesDescription" : MessageLookupByLibrary.simpleMessage("is simply dummy text of the \nprinting and typesetting industry ssssssss?"),

  };
}