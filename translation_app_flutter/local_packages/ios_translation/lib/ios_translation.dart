import 'ios_translation_platform_interface.dart';

class IosTranslation {
  static Future<void> setTranslationTargetText(String text) {
    return IosTranslationPlatform.instance.setTranslationTargetText(text);
  }
}
