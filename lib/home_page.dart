import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(('ホーム')),
      ),
      body: Column(
        children: [
          SizedBox(
            width: 500,
            height: 300,
            child: Stack(
              children: [
                Center(
                  child: SizedBox(
                    height: 160,
                    width: 280,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(34),
                      ),
                      child: Column(
                        children: const [Text('Atom'), Text('好きです。付き合ってください。')],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 150,
                  left: 200,
                  child: SizedBox(
                    height: 100,
                    width: 250,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(34),
                      ),
                      elevation: 10,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('いいね👍'),
                              Icon(Icons.account_circle_outlined)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('うんうん'),
                              Icon(Icons.account_circle_outlined)
                            ],
                          ),
                          const Icon(Icons.chat)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
