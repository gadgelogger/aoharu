import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teamc/manage.dart';
import 'package:teamc/show_snack_bar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  //フィールドコントローラー
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isChecked = false;

  // 選択された性別
  String selectedGender = "";
  // 登録・ログインに関する情報を表示
  String infoText = "";

  // チェックボックスの状態を更新する
  void _onCheck(bool? value) {
    setState(() {
      _isChecked = value ?? false;
    });
  }

  // 性別選択の状態を更新する
  void _onGenderSelected(String value) {
    setState(() {
      selectedGender = value;
    });
  }

  // ボタンを押したときの処理
  void _onPressed() async {
    EasyLoading.show();
    if (!_isChecked) {
      return null;
    }

    try {
      // メール/パスワードでユーザー登録
      final FirebaseAuth auth = FirebaseAuth.instance;
      final UserCredential result = await auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // 登録したユーザー情報
      final User user = result.user!;
      setState(() {
        infoText = "登録OK：${user.email}";
      });

      // Firestoreにユーザー情報を追加する
      await FirebaseFirestore.instance.collection('users').doc().set({
        'name': _nameController.text,
        'gender': selectedGender,
        'email': user.email,
        'id': user.uid,
      });

      // サインインが成功したらログイン画面に画面遷移する
      showSnackBar(context, "アカウントを新規作成しました！");
      Navigator.pop(context);
    } catch (e) {
      // 登録に失敗した場合
      setState(() {
        infoText = "登録NG：${e.toString()}";
      });
      if (_emailController.text.isEmpty ||
          _nameController.text.isEmpty ||
          _passwordController.text.isEmpty) {
        showSnackBar(context, '値を全て入力してください。');
      }
    }
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.opaque,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              child: const Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      top: 110,
                      left: 20,
                    ),
                    child: Text('Signup',
                        style: TextStyle(
                            fontSize: 60.0, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  labelText: 'ニックネーム',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  labelText: 'メールアドレス',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  labelText: 'パスワード',
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Row(
                children: <Widget>[
                  Checkbox(
                    value: _isChecked,
                    onChanged: _onCheck,
                    activeColor: Colors.black,
                  ),
                  const Text('利用規約とプライバシーポリシーに同意します'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('性別：'),
                  Radio<String>(
                    activeColor: Colors.black,
                    value: '男性',
                    groupValue: selectedGender,
                    onChanged: (String? value) {
                      _onGenderSelected(value!);
                    },
                  ),
                  const Text('男性'),
                  Radio<String>(
                    activeColor: Colors.black,
                    value: '女性',
                    groupValue: selectedGender,
                    onChanged: (String? value) {
                      _onGenderSelected(value!);
                    },
                  ),
                  const Text('女性'),
                  Radio<String>(
                    activeColor: Colors.black,
                    value: '無回答',
                    groupValue: selectedGender,
                    onChanged: (String? value) {
                      _onGenderSelected(value!);
                    },
                  ),
                  const Text('無回答'),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              width: 300,
              child: ElevatedButton(
                onPressed: _isChecked ? _onPressed : null,
                child: const Text('新規会員登録'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.black,
                  elevation: 0,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  '戻る',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.grey[300],
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
