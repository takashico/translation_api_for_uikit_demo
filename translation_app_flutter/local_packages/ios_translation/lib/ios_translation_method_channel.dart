import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ios_translation_platform_interface.dart';

/// An implementation of [IosTranslationPlatform] that uses method channels.
class MethodChannelIosTranslation extends IosTranslationPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('takashico.translation-api-uikit-sample/ios_translation_plugin');

  @override
  Future<void> setTranslationTargetText(String text) async {
    if (!Platform.isIOS) return;

    await methodChannel.invokeMethod('setTranslationSourceText', {'text': text});
  }

  @override
  Future<void> onTranslated({
    required Function(String) handler,
  }) async {
    if (!Platform.isIOS) return;

    methodChannel.setMethodCallHandler((MethodCall call) async {
      if (call.method == 'onTranslated') {
        final String? text = call.arguments as String?;
        if (text == null) {
          throw PlatformException(code: 'arguments is null', message: 'No text was returned from the native platform');
        }

        handler(text);
      }
    });
  }
}
