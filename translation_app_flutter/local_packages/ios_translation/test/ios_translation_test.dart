import 'package:flutter_test/flutter_test.dart';
import 'package:ios_translation/ios_translation.dart';
import 'package:ios_translation/ios_translation_method_channel.dart';
import 'package:ios_translation/ios_translation_platform_interface.dart';

import 'mock_ios_translation_platform.dart';

void main() {
  final IosTranslationPlatform initialPlatform = IosTranslationPlatform.instance;
  late MockIosTranslationPlatform mockPlatform;

  setUp(() {
    mockPlatform = MockIosTranslationPlatform();
    IosTranslationPlatform.instance = mockPlatform;
  });

  test('$MethodChannelIosTranslation is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelIosTranslation>());
  });

  test('setTranslationTargetText calls platform method', () async {
    // Arrange
    const expectedText = 'Hello, world!';

    // Act
    await IosTranslation.setTranslationTargetText(expectedText);

    // Assert
    expect(mockPlatform.translationTargetText, expectedText);
  });
}
