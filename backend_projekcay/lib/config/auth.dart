import 'package:backend_projekcay/app/models/user.dart';

Map<String, dynamic> authConfig = {
  'guards': {
    'default': {
      'provider': User(),
    }
  }
};