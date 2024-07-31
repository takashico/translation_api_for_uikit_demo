import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ios_translation/ios_translation_platform_interface.dart';

/// A button that triggers the translation process.
class TranslationButtonWidget extends StatelessWidget {
  const TranslationButtonWidget({
    super.key,
    required this.onTranslated,
  });

  final Function(String) onTranslated;

  @override
  Widget build(BuildContext context) {
    return UiKitView(
      viewType: 'takashico.translation-api-uikit-sample/translation_button_view',
      creationParams: const <String, dynamic>{},
      creationParamsCodec: const StandardMessageCodec(),
      onPlatformViewCreated: (_) {
        IosTranslationPlatform.instance.onTranslated(handler: (translatedText) {
          onTranslated(translatedText);
        });
      },
    );
  }
}
