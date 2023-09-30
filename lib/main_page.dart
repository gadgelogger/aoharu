import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teamc/page1.dart';
import 'package:teamc/page2.dart';
import 'package:teamc/page3.dart';

import 'EmptyAppBar.dart';
import 'ai_check/ai_check_page.dart';

// メイン画面
class Main extends StatefulWidget {
  Main() : super();

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {

  // 選択中のボトムバーの値
  int currentTabIndex = 0;

  // タップした際の挙動
  onTapped(int index) {
    setState(() => currentTabIndex = index);
  }

  // 表示するページ一覧
  List<Widget> pages = [
    page1(),
    page2(),
    const ProviderScope(
      child: AiCheckPage(),
    ),

  ];

  @override
  Widget build(BuildContext context) {
    // ボトムバー
    List<BottomNavigationBarItem> bottomBars = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: '111',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: '222',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: '333',
      )
    ];

    return Scaffold(
        appBar: EmptyAppBar(),
        body: IndexedStack(
          index: currentTabIndex,
          children: pages,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: () {
              // TODO 投稿画面に画面遷移させる
            },
            child: const Icon(Icons.send)
            // Icon(Icons.add),
            ),
        bottomNavigationBar: BottomNavigationBar(
            onTap: (int index) {
              if (index != 1) {
                onTapped(index);
              }
            },
            currentIndex: currentTabIndex,
            items: bottomBars));
  }
}
