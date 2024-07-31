import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ios_translation_method_channel.dart';

abstract class IosTranslationPlatform extends PlatformInterface {
  /// Constructs a IosTranslationPlatform.
  IosTranslationPlatform() : super(token: _token);

  static final Object _token = Object();

  static IosTranslationPlatform _instance = MethodChannelIosTranslation();

  /// The default instance of [IosTranslationPlatform] to use.
  ///
  /// Defaults to [MethodChannelIosTranslation].
  static IosTranslationPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [IosTranslationPlatform] when
  /// they register themselves.
  static set instance(IosTranslationPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> setTranslationTargetText(String text) {
    throw UnimplementedError('setTranslationTargetText() has not been implemented.');
  }

  Future<void> onTranslated({
    required Function(String) handler,
  }) {
    throw UnimplementedError('setTranslationResultHandler() has not been implemented.');
  }
}
