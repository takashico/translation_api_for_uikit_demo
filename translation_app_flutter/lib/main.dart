import 'package:flutter/material.dart';
import 'package:ios_translation/ios_translation.dart';
import 'package:ios_translation/translation_button_widget.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const InitialSceneRouteHandler(),
    );
  }
}

/// 初期画面のハンドリングと常にリフレッシュした画面を表示するための役割
class InitialSceneRouteHandler extends StatelessWidget {
  const InitialSceneRouteHandler({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()),
        (route) => route.isFirst,
      );
    });

    return const SizedBox.shrink();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController textEditingController;
  String translatedText = '';

  @override
  void initState() {
    super.initState();

    const initialText = 'こんにちは';
    IosTranslation.setTranslationTargetText(initialText);
    textEditingController = TextEditingController(text: initialText);
  }

  @override
  void dispose() {
    textEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Translation (Add to App)'),
        leading: const SizedBox.shrink(),
        leadingWidth: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: 24,
              height: 24,
              child: TranslationButtonWidget(
                onTranslated: (text) {
                  setState(() {
                    translatedText = text;
                  });
                },
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /// input text to translate
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter text to translate',
              ),
              onChanged: (text) {
                IosTranslation.setTranslationTargetText(text);
              },
              controller: textEditingController,
            ),

            /// padding
            const SizedBox(height: 24),

            /// output the translation text
            Text(
              translatedText,
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}
