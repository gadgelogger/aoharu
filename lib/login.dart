import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teamc/manage.dart';
import 'package:teamc/show_snack_bar.dart';
import 'package:teamc/signup.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //フィールドコントローラー
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';
  // 入力されたメールアドレス
  String newUserEmail = "";
  // 入力されたパスワード
  String newUserPassword = "";
  // 入力されたメールアドレス（ログイン）
  String loginUserEmail = "";
  // 入力されたパスワード（ログイン）
  String loginUserPassword = "";
  // 登録・ログインに関する情報を表示
  String infoText = "";

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
                      child: Text(
                        'Welcome To Aoharu',
                        style: TextStyle(
                            fontSize: 60.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    labelText: 'メールアドレス',
                  ),
                  onChanged: (String value) {
                    setState(() {
                      loginUserEmail = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
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
                  onChanged: (String value) {
                    setState(() {
                      loginUserPassword = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                height: 50,
                width: 300,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_emailController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty) {
                      EasyLoading.show();
                      try {
                        // メール/パスワードでログイン
                        final FirebaseAuth auth = FirebaseAuth.instance;
                        final UserCredential result =
                            await auth.signInWithEmailAndPassword(
                          email: loginUserEmail,
                          password: loginUserPassword,
                        );

                        // ログインに成功した場合
                        final User user = result.user!;
                        setState(() {
                          infoText = "ログインOK：${user.email}";
                        });

                        // ログインが成功したら画面遷移する
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute<void>(
                            builder: (builder) => const Manege(),
                          ),
                        );
                      } catch (e) {
                        // ログインに失敗した場合
                        setState(() {
                          infoText = "ログインNG：${e.toString()}";
                        });
                        showSnackBar(context, "メールアドレスまたはパスワードが違います。");
                      }
                    } else {
                      setState(() {
                        _errorMessage = 'メールアドレスとパスワードを入力してください';
                      });
                    }
                    EasyLoading.dismiss();
                  },
                  child: const Text('ログイン'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: 300,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Signup()),
                    );
                  },
                  child: const Text(
                    'サインイン',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.grey[300],
                    elevation: 0,
                  ),
                ),
              ),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
