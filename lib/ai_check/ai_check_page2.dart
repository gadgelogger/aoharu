import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

// Aiに相談する画面
class AiCheck2 extends StatefulWidget {
  const AiCheck2({Key? key}) : super(key: key);

  @override
  AiCheckPage2 createState() => AiCheckPage2();
}

class AiCheckPage2 extends State<AiCheck2> {
  TextEditingController messageController = TextEditingController(text: '');

  TextEditingController aiTextController =
      TextEditingController(text: 'Aiが回答します！');

  bool isWaiting = false;

  String answerAi = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Expanded(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                        // 入力画面
                        child: Container(
                      height: 100,
                      margin: const EdgeInsets.all(5.0),
                      padding: const EdgeInsets.all(5.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: messageController,
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: '恋愛の言葉を入力してください',
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    )),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), //こちらを適用
                          ),
                          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                        ),
                        onPressed: () async {
                          EasyLoading.show();

                          if (messageController.text.isEmpty) {
                            EasyLoading.dismiss();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('メッセージを入力してください'),
                              ),
                            );
                          } else {
                            // 実行する
                            final sendMessage22 = sendMessage(
                              messageController.text,
                            );

                            isWaiting = true;
                            await sendMessage22;
                            isWaiting = false;

                            EasyLoading.dismiss();
                          }
                        },
                        child: const Text(
                          "Aiに相談する",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
                color: Colors.grey,
                height: 100,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Radio(
                              value: 1,
                              groupValue: 'null',
                              onChanged: (index) {}),
                          const Expanded(child: Text('RB 1'))
                        ],
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          // Radio(
                          //     value: Consult_Choices.both_consult,
                          //     groupValue: consultChoice,
                          //   onChanged: (Consult_Choices? value) {
                          //     setState(() {
                          //       consultChoice = value;
                          //     });
                          //   },
                          //     ),
                          Expanded(child: Text('Btn Radio 2'))
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Radio(
                              value: 1,
                              groupValue: 'null',
                              onChanged: (index) {}),
                          const Expanded(
                            child: Text('Rad 3'),
                          )
                        ],
                      ),
                    ),
                  ],
                )),

            // Aiの回答部分
            Expanded(
                child: Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                enabled: true,
                readOnly: true,
                controller: aiTextController,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Aiが回答します。',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  border: InputBorder.none,
                ),
              ),
            )),
          ],
        ),
      ),
    ));
  }

  // メッセージを送信
  Future<void> sendMessage(String message) async {
    // インデックスモデル
    String indexText = 'あなたは恋愛マスターです。以下の告白の文章を添削してください。';

    // メッセージをuserロールでモデル化
    OpenAIChatCompletionChoiceMessageModel newUserMessage =
        OpenAIChatCompletionChoiceMessageModel(
      content: indexText + message,
      role: OpenAIChatMessageRole.user,
    );

    // ChatGPTに聞く
    final chatCompletion = await OpenAI.instance.chat.create(
      model: 'gpt-3.5-turbo',
      // これまでのやりとりを含めて送信
      messages: [newUserMessage],
    );

    print(chatCompletion.choices.first.message.content);

    // 画面反映
    setState(() {
      aiTextController.text = chatCompletion.choices.first.message.content;
    });
  }
}
