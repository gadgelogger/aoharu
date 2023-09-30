import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teamc/ai_check/build_context_x.dart';

part 'ai_check_page.g.dart';

// ChatGPTとの繋ぎこみ部分
@riverpod
class Messages extends _$Messages {


  @override
  List<OpenAIChatCompletionChoiceMessageModel> build() => [
    // システムメッセージでAIの動作を調整
    OpenAIChatCompletionChoiceMessageModel(
      content: '日本語で技術の相談をされます。あなたはエキスパートです。',
      role: OpenAIChatMessageRole.system,
    ),
  ];

  // メッセージを送信
  Future<void> sendMessage(String message) async {
    // メッセージをuserロールでモデル化
    final newUserMessage = OpenAIChatCompletionChoiceMessageModel(
      content: message,
      role: OpenAIChatMessageRole.user,
    );
    // メッセージを追加
    state = [
      ...state,
      newUserMessage,
    ];
    // ChatGPTに聞く
    final chatCompletion = await OpenAI.instance.chat.create(
      model: 'gpt-3.5-turbo',
      // これまでのやりとりを含めて送信
      messages: state,
    );
    // 結果を追加
    state = [
      ...state,
      chatCompletion.choices.first.message,
    ];
  }
}

//
class AiCheckPage extends HookConsumerWidget {
  const AiCheckPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(messagesProvider);
    final messageController = useTextEditingController(text: 'Flutterとはなんですか？');
    final screenWidth = MediaQuery.of(context).size.width;
    final isWaiting = useState(false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatGPT Sample'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // メッセージ一覧
            Expanded(
              child: ListView.separated(
                keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  // systemロールのメッセージは表示しない
                  if (message.role == OpenAIChatMessageRole.system) {
                    return const SizedBox();
                  }

                  return Align(
                    key: Key(message.hashCode.toString()),
                    alignment: message.role == OpenAIChatMessageRole.user
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: screenWidth * 0.8,
                      ),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: message.role == OpenAIChatMessageRole.user
                              ? context.colorScheme.primary
                              : context.colorScheme.secondary,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          child: Text(
                            message.content,
                            style: TextStyle(
                              color: message.role == OpenAIChatMessageRole.user
                                  ? context.colorScheme.onPrimary
                                  : context.colorScheme.onSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                const SizedBox(height: 16),
              ),
            ),
            // 送信フォーム
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: context.colorScheme.primary,
                    width: 2,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'メッセージを入力',
                          hintStyle: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.6),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // 送信ボタン
                    if (!isWaiting.value)
                      IconButton(
                        onPressed: () async {
                          if (messageController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('メッセージを入力してください'),
                              ),
                            );
                          } else {
                            final sendMessage =
                            ref.read(messagesProvider.notifier).sendMessage(
                              messageController.text,
                            );
                            isWaiting.value = true;
                            messageController.clear();
                            await sendMessage;
                            isWaiting.value = false;
                          }
                        },
                        icon: !isWaiting.value
                            ? const Icon(Icons.send)
                            : const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    // 送信中
                    if (isWaiting.value)
                      const IconButton(
                        onPressed: null,
                        icon: SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
