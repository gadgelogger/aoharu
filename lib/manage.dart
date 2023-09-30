import 'package:flutter/material.dart';
import 'package:teamc/home_page.dart';
import 'package:teamc/page1.dart';

import 'create_post.dart';

class Manege extends StatefulWidget {
  const Manege({Key? key}) : super(key: key);

  @override
  State<Manege> createState() => _ManegeState();
}

class _ManegeState extends State<Manege> {
  int currentTabIndex = 0;

  // タップした際の挙動
  onTapped(int index) {
    setState(() => currentTabIndex = index);
  }

  // 表示するページ一覧
  List<Widget> pages = [
    const HomePage(),
    CreatePost(),
    Page1(),
  ];

  @override
  Widget build(BuildContext context) {
    // ボトムバー
    List<BottomNavigationBarItem> bottomBars = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'ホーム',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.add),
        label: '',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.chat),
        label: '添削',
      )
    ];

    return Scaffold(
        body: IndexedStack(
          index: currentTabIndex,
          children: pages,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => CreatePost()));
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
