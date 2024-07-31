import 'package:ios_translation/ios_translation_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

final class MockIosTranslationPlatform with MockPlatformInterfaceMixin implements IosTranslationPlatform {
  String? translationTargetText;
  Function(String)? onTranslatedHandler;

  @override
  Future<void> setTranslationTargetText(String text) {
    translationTargetText = text;
    return Future.value();
  }

  @override
  Future<void> onTranslated({
    required Function(String) handler,
  }) {
    onTranslatedHandler = handler;
    return Future.value();
  }
}
