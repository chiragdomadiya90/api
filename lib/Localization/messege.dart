import 'package:get/get.dart';

class Message extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {'hello': 'hello', 'recent': 'recent'},
        'hi_IN': {'hello': 'नमस्ते', 'recent': 'हाल ही का'},
        'fr_FR': {'hello': 'Bonjour', 'recent': 'récent'}
      };
}
