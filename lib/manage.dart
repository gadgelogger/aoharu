import 'package:convex_bottom_bar/convex_bottom_bar.dart';
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
    List<TabItem> bottomBars = [
      const TabItem(
        icon: Icons.home,
        title: 'ホーム',
      ),
      const TabItem(
        icon: Icons.add,
        title: 'aaa',
      ),
      const TabItem(
        icon: Icons.chat,
        title: '添削',
      )
    ];

    return Scaffold(
        body: IndexedStack(
          index: currentTabIndex,
          children: pages,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => CreatePost()));
            },
            child: const Icon(
              Icons.add,
            )),
        bottomNavigationBar: ConvexAppBar(
          color: Colors.grey,
          activeColor: Colors.black,
          backgroundColor: Colors.white,
          shadowColor: Colors.brown,
          style: TabStyle.fixedCircle,
          items: bottomBars,
          onTap: (int index) => onTapped(index),
        ));
  }
}
