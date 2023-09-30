import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreatePost extends StatefulWidget {
  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final _userInputController = TextEditingController();

  bool _boyGirl = false;
  bool _girl = false;
  bool _boy = false;
  bool _both = false;
  bool _girlSubject = false;
  bool _boySubject = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                width: 120,
                height: 120,
              ),
              const Text(
                "告白の言葉",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                height: 100,
                child: TextField(
                  controller: _userInputController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    label: const Text("告白の言葉を入力してください"),
                  ),
                ),
              ),
              const Text(
                "恋愛相談対象を選択してください",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("両方"), // figmaでは男女だったのですが、変えました。
                      const SizedBox(
                        width: 200,
                      ),
                      Checkbox(
                        value: _boyGirl,
                        onChanged: (bool? value) {
                          setState(() {
                            _boyGirl = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("女性"),
                      const SizedBox(
                        width: 200,
                      ),
                      Checkbox(
                        value: _girl,
                        onChanged: (bool? value) {
                          setState(() {
                            _girl = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("男性"),
                      const SizedBox(
                        width: 200,
                      ),
                      Checkbox(
                        value: _boy,
                        onChanged: (bool? value) {
                          setState(() {
                            _boy = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "恋愛対象を選択してください",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("両方"),
                      const SizedBox(
                        width: 200,
                      ),
                      Checkbox(
                        value: _both,
                        onChanged: (bool? value) {
                          setState(() {
                            _both = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("女性"),
                      const SizedBox(
                        width: 200,
                      ),
                      Checkbox(
                        value: _girlSubject,
                        onChanged: (bool? value) {
                          setState(() {
                            _girlSubject = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("男性"),
                      const SizedBox(
                        width: 200,
                      ),
                      Checkbox(
                        value: _boySubject,
                        onChanged: (bool? value) {
                          setState(() {
                            _boySubject = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
                      onPressed: () {},
                      child: const Text(
                        "投稿する",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 250,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), //こちらを適用
                        ),
                        backgroundColor: Color.fromARGB(255, 255, 255, 255),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "AIに相談する",
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
