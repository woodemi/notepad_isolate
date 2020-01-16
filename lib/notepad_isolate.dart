import 'package:flutter/services.dart';

final _method = MethodChannel('notepad_isolate/method');

class NotepadIsolatePlugin {
  static void promoteToForeground() {
    _method.invokeListMethod('promoteToForeground');
  }

  static void demoteToBackground() {
    _method.invokeListMethod('demoteToBackground');
  }
}
