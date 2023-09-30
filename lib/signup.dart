import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teamc/show_snack_bar.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  //フィールドコントローラー
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isChecked = false;

  // 入力されたメールアドレス
  String newUserEmail = "";
  // 入力されたパスワード
  String newUserPassword = "";
  // 登録・ログインに関する情報を表示
  String infoText = "";

  // チェックボックスの状態を更新する
  void _onCheck(bool? value) {
    setState(() {
      _isChecked = value ?? false;
    });
  }

// ボタンを押したときの処理
  void _onPressed() async {
    if (!_isChecked) {
      return null;
    }

    try {
      // メール/パスワードでユーザー登録
      final FirebaseAuth auth = FirebaseAuth.instance;
      final UserCredential result = await auth.createUserWithEmailAndPassword(
        email: newUserEmail,
        password: newUserPassword,
      );

      // 登録したユーザー情報
      final User user = result.user!;
      setState(() {
        infoText = "登録OK：${user.email}";
      });

      // サインインが成功したらログイン画面に画面遷移する
      Navigator.pop(context);
      showSnackBar(context, "アカウントを新規作成しました！");

    } catch (e) {
      // 登録に失敗した場合
      setState(() {
        infoText = "登録NG：${e.toString()}";
      });
    }
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
            const SizedBox(height: 200),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'メールアドレス',
                ),
                onChanged: (String value) {
                  setState(() {
                    newUserEmail = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'パスワード',
                ),
                onChanged: (String value) {
                  setState(() {
                    newUserPassword = value;
                  });
                },
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
                  ),
                  const Text('利用規約とプライバシーポリシーに同意します'),
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
