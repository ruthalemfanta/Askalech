import 'package:askalech/feature_box.dart';
import 'package:askalech/openai_services.dart';
import 'package:askalech/pallete.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final speechToText = SpeechToText();
  String lastWords = '';
  final openAIService = OpenAIService();

  @override
  void initState() {
    super.initState();
    initSpeechToText();
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Askalech'),
        centerTitle: true,
        leading: const Icon(Icons.menu),
      ),
      body: Column(
        children: [
          Center(
            child: Stack(
              children: [
                Container(
                  height: 110,
                  width: 110,
                  margin: const EdgeInsets.only(top: 4),
                  decoration: const BoxDecoration(
                      color: Pallete.whiteColor, shape: BoxShape.circle),
                ),
                Container(
                  height: 113,
                  width: 110,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('assets/images/askalech.webp'))),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin:
                const EdgeInsets.symmetric(horizontal: 40).copyWith(top: 30),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Pallete.borderColor,
                ),
                borderRadius:
                    BorderRadius.circular(20).copyWith(topLeft: Radius.zero)),
            child: const Text(
              'How can I help?',
              style: TextStyle(
                  fontFamily: 'Cera Pro',
                  fontSize: 25,
                  color: Pallete.mainFontColor),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(top: 9, left: 20),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Here are a few commands.',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Cera Pro',
                fontWeight: FontWeight.bold,
                color: Pallete.mainFontColor,
              ),
            ),
          ),
          const Column(
            children: [
              FeatureBox(
                  color: Pallete.firstSuggestionBoxColor,
                  headerText: 'Chatgpt',
                  descriptionText:
                      'A smarter way to stay organized and informed with chatgpt.'),
              FeatureBox(
                  color: Pallete.secondSuggestionBoxColor,
                  headerText: 'Dell-E',
                  descriptionText:
                      'Get inspired and stay creative with your personal assistant powered by DellE.'),
              FeatureBox(
                  color: Pallete.thirdSuggestionBoxColor,
                  headerText: 'Smart Voice Assistant',
                  descriptionText:
                      'Get the best of both worlds with a voice assistant powered by Dall-E and chatgpt')
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (await speechToText.hasPermission && speechToText.isNotListening) {
            await startListening();
          } else if (speechToText.isListening) {
            openAIService.isArtPrompt(lastWords);
            await stopListening();
          } else {
            initSpeechToText();
          }
        },
        child: const Icon(Icons.mic),
      ),
    );
  }
}
