// ignore_for_file: use_build_context_synchronously

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/shared/components/localization/app_local.dart';
import 'package:graduation_project/shared/network/TextToSpeech.dart';

import 'package:graduation_project/shared/network/api_servcies.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../models/chat_model.dart';
import '../../shared/network/styles/colors.dart';

class SpeechScreen extends StatefulWidget {
  final bool ar;
  const SpeechScreen({
    Key? key,
    required this.ar,
  }) : super(key: key);

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  SpeechToText speechToText = SpeechToText();

  final List<ChatMessage> messages = [];

  String selectedLocaleId = '';

  String text = "";
  bool isListening = false;

  var scrollController = ScrollController();
  scrollMethod() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  @override
  void initState() {
    super.initState();
    selectedLocaleId = (widget.ar == true) ? 'ar_SA' : 'en-US';
    text = widget.ar
        ? "اضغط على الزر ثم ابدأ بالتحدث"
        : "Hold the button and start speaking";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        endRadius: 90.0,
        animate: isListening,
        duration: const Duration(milliseconds: 2000),
        glowColor: lighten(Colors.pink, .2),
        repeat: true,
        repeatPauseDuration: const Duration(milliseconds: 2000),
        showTwoGlows: true,
        child: GestureDetector(
          onTapDown: (details) async {
            if (!isListening) {
              bool av = await speechToText.initialize();
              if (av) {
                setState(() {
                  isListening = true;
                });
                speechToText.listen(
                  localeId: selectedLocaleId,
                  // pauseFor: Duration(
                  //   minutes: 1,
                  // ),
                  // listenFor: Duration(
                  //   minutes: 1,
                  // ),
                  onResult: (result) {
                    setState(() {
                      text = result.recognizedWords;
                    });
                  },
                );
              }
            }
          },
          onTapUp: (details) async {
            setState(() {
              isListening = false;
            });
            await speechToText.stop();

            if (text.isNotEmpty &&
                text !=
                    "${getLang(context, "Hold the button and start speaking")}") {
              messages.add(ChatMessage(text: text, type: ChatMessageType.user));
              var msg = await ApiServices.sendMessage(text);
              msg = msg?.trim();
              // print(msg);
              setState(() {
                messages.add(ChatMessage(text: msg, type: ChatMessageType.bot));
              });

              Future.delayed(
                const Duration(milliseconds: 400),
                () {
                  TextToSpeech.speak(msg!);
                },
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "${getLang(context, "Failed to process. Try again!")}")));
            }
          },
          child: CircleAvatar(
            radius: 35,
            backgroundColor: lighten(Colors.pink, .2),
            child: Icon(isListening ? Icons.mic : Icons.mic_none,
                color: Colors.white),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: lighten(Colors.pink, .2),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_outlined, color: Colors.white)),
        title: Text("${getLang(context, ' ChatGPT Assistant')}"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Column(
          children: [
            Text(text,
                style: TextStyle(
                  color: isListening ? Colors.black87 : Colors.black54,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                )),
            const SizedBox(
              height: 12.0,
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: chatGptColor,
                ),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: scrollController,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var chat = messages[index];
                    return chatBubble(
                      chatText: chat.text,
                      type: chat.type,
                    );
                  },
                  itemCount: messages.length,
                ),
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget chatBubble({
    required chatText,
    required ChatMessageType? type,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: lighten(Colors.pink, .2),
          child: type == ChatMessageType.bot
              ? Image.asset('assets/ChatGPT_logo.svg.png')
              : const Icon(Icons.person, color: Colors.white),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(12.0),
            margin: const EdgeInsets.only(bottom: 8.0),
            decoration: BoxDecoration(
              color: type == ChatMessageType.bot ? bgColor : Colors.white,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12)),
            ),
            child: Text(
              "$chatText",
              style: TextStyle(
                color:
                    type == ChatMessageType.bot ? Colors.white : chatGptColor,
                fontSize: 15.0,
                fontWeight: type == ChatMessageType.bot
                    ? FontWeight.w600
                    : FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
