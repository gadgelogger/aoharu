import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teamc/manage.dart';

enum Consult_Choices { both_consult, girl_consult, boy_consult }

enum Subject_Choices { both_subject, girl_subject, boy_subject }

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  Consult_Choices? _consultChoice = Consult_Choices.both_consult;
  Subject_Choices? _subjectChoice = Subject_Choices.both_subject;
  final TextEditingController confessionSentence = TextEditingController();

  // コントローラーの破棄
  // @override
  // void dispose() {
  //   confessionSentence.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference confession = firestore.collection('confessions');

    Future<void> confessionAdd(String confessionSentence) {
      return confession
          .doc()
          .set({
            'confession': confessionSentence,
            'gender': _consultChoice.toString(),
            'advise_gender': _subjectChoice.toString(),
            'id': FirebaseAuth.instance.currentUser!.uid
          })
          .then((value) => print('告白追加 '))
          .catchError((error) => print('告白追加失敗: $error'));
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                width: 60,
                height: 60,
              ),
              const Text(
                '告白の言葉',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                height: 100,
                child: TextField(
                  controller: confessionSentence,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    label: const Text('告白の言葉を入力してください'),
                  ),
                ),
              ),
              const Text(
                '恋愛相談対象を選択してください',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                child: Column(
                  children: [
                    RadioListTile(
                      controlAffinity: ListTileControlAffinity.trailing,
                      title: const Text('両方'),
                      value: Consult_Choices.both_consult,
                      groupValue: _consultChoice,
                      onChanged: (Consult_Choices? value) {
                        setState(() {
                          _consultChoice = value;
                        });
                      },
                    ),
                    RadioListTile(
                      controlAffinity: ListTileControlAffinity.trailing,
                      title: const Text('女性'),
                      value: Consult_Choices.girl_consult,
                      groupValue: _consultChoice,
                      onChanged: (Consult_Choices? value) {
                        setState(() {
                          _consultChoice = value;
                        });
                      },
                    ),
                    RadioListTile(
                      controlAffinity: ListTileControlAffinity.trailing,
                      title: const Text('男性'),
                      value: Consult_Choices.boy_consult,
                      groupValue: _consultChoice,
                      onChanged: (Consult_Choices? value) {
                        setState(() {
                          _consultChoice = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      '恋愛対象を選択してください',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    RadioListTile(
                      controlAffinity: ListTileControlAffinity.trailing,
                      title: const Text('両方'),
                      value: Subject_Choices.both_subject,
                      groupValue: _subjectChoice,
                      onChanged: (Subject_Choices? value) {
                        setState(() {
                          _subjectChoice = value;
                        });
                      },
                    ),
                    RadioListTile(
                      controlAffinity: ListTileControlAffinity.trailing,
                      title: const Text('女性'),
                      value: Subject_Choices.girl_subject,
                      groupValue: _subjectChoice,
                      onChanged: (Subject_Choices? value) {
                        setState(() {
                          _subjectChoice = value;
                        });
                      },
                    ),
                    RadioListTile(
                      controlAffinity: ListTileControlAffinity.trailing,
                      title: const Text('両方'),
                      value: Subject_Choices.boy_subject,
                      groupValue: _subjectChoice,
                      onChanged: (Subject_Choices? value) {
                        setState(() {
                          _subjectChoice = value;
                        });
                      },
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
                        onPressed: () {
                          confessionAdd(confessionSentence.text);
                          print(confessionSentence);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => const Manege()),
                              (route) => false);
                        },
                        child: const Text(
                          '投稿する',
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
                    // SizedBox(
                    //   width: 250,
                    //   height: 50,
                    //   child: ElevatedButton(
                    //     style: ElevatedButton.styleFrom(
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(20), //こちらを適用
                    //       ),
                    //       backgroundColor: Color.fromARGB(255, 255, 255, 255),
                    //     ),
                    //     onPressed: () {},
                    //     child: Text(
                    //       'AIに相談する',
                    //       style: TextStyle(
                    //         color: Color.fromARGB(255, 0, 0, 0),
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
