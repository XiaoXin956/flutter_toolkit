import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

// 打字机效果
class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<dynamic> chatDate = [];
  String message = "";
  TextEditingController _message = TextEditingController();
  bool loading = false;
  bool typewriter = false;
  ScrollController scrollController = ScrollController();

  TextStyle textStyle = TextStyle(fontSize: 18, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: ListView.builder(
              controller: scrollController,
              itemCount: (loading) ? chatDate.length + 1 : chatDate.length,
              itemBuilder: (BuildContext context, int index) {
                if (loading && index == chatDate.length) {
                  return aiLoading();
                }
                dynamic chatMessage = chatDate[index];
                if (chatMessage["type"] == 1) {
                  return me(chatMessage);
                } else {
                  if (typewriter && index == chatDate.length - 1) {
                    return aiTypewriter(chatMessage);
                  } else {
                    return ai(index: index, chatMessage: chatMessage);
                  }
                }
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: _message,
                )),
                ElevatedButton(
                    onPressed: () {
                      send(message: _message.text);
                      _message.text = "";
                    },
                    child: Text("发送")),
              ],
            ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.red, width: 1)),
          ),
        ],
      ),
    );
  }

  Widget ai({required int index, dynamic chatMessage}) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.ac_unit_outlined,
            size: 20,
            color: Colors.red,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
              color: Colors.red,
              child: Column(
                children: [
                  Text(
                    chatMessage["message"],
                    textAlign: TextAlign.start,
                    style: textStyle,
                  ),
                  if (!typewriter && index == chatDate.length - 1)
                    Row(
                      children: [
                        Icon(
                          Icons.ac_unit_outlined,
                          size: 20,
                          color: Colors.blue,
                        ),
                        Icon(
                          Icons.ac_unit_outlined,
                          size: 20,
                          color: Colors.white60,
                        ),
                        Icon(
                          Icons.ac_unit_outlined,
                          size: 20,
                          color: Colors.deepOrangeAccent,
                        ),
                        Icon(
                          Icons.ac_unit_outlined,
                          size: 20,
                          color: Colors.blue,
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget me(dynamic chatMessage) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        children: [
          Expanded(
              child: Container(
            padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
            color: Colors.red,
            child: Text(
              chatMessage["message"],
              textAlign: TextAlign.end,
              style: textStyle,
            ),
          )),
          Icon(
            Icons.account_circle,
            size: 20,
            color: Colors.red,
          )
        ],
      ),
    );
  }

  Widget aiLoading() {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        children: [
          Icon(
            Icons.account_circle,
            size: 20,
            color: Colors.red,
          ),
          Expanded(
              child: Container(
                  margin: EdgeInsets.only(right: 10, left: 10),
                  padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 5),
                  color: Colors.red,
                  child: Row(
                    children: [
                      Text(
                        "正在加载",
                        style: textStyle,
                      ),
                      AnimatedTextKit(
                        animatedTexts: [
                          TyperAnimatedText(
                            "...",
                            textStyle: textStyle,
                          ),
                        ],
                      ),
                    ],
                  )))
        ],
      ),
    );
  }

  Widget aiTypewriter(dynamic chatMessage) {
    String dataMessage = chatMessage["message"].toString();
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.account_circle,
                size: 20,
                color: Colors.red,
              ),
              Expanded(
                  child: SizedBox(
                      child: Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(right: 10, left: 10),
                color: Colors.red,
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'Agne',
                  ),
                  child: AnimatedTextKit(
                    isRepeatingAnimation: false,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        '$dataMessage',
                        textStyle: textStyle,
                      ),
                    ],
                    onTap: () {},
                    onFinished: () {
                      print("完成");

                      scrollController.animateTo(
                        scrollController.position.maxScrollExtent,
                        duration: Duration(seconds: 3),
                        curve: Curves.easeOut,
                      );
                      setState(() {
                        typewriter = false;
                      });
                    },
                  ),
                ),
              ))),
            ],
          ),
        ],
      ),
    );
  }

  send({required String message}) async {
    if (typewriter) {
      print("请稍后");
      return;
    }

    setState(() {
      loading = true;
      chatDate.add({"type": 1, "message": message});
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 2),
        curve: Curves.easeOut,
      );
    });
    typewriter = true;
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      loading = false;
      chatDate.add({"type": 2, "message": "当前是ai 回复的内容当前是ai回复的内容当前是ai回复的内容当前是ai回复的内容当前是ai 回复的内容当前是ai 回复的内容"});
    });
  }
}
