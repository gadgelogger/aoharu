import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:teamc/home_page.dart';

import 'ai_check/ai_check_page2.dart';
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
    const AiCheck2(),
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
        title: 'AIに相談する',
      )
    ];

    return Scaffold(
        body: IndexedStack(
          index: currentTabIndex,
          children: pages,
        ),
        bottomNavigationBar: ConvexAppBar(
          color: Colors.grey,
          activeColor: Colors.black,
          backgroundColor: Colors.white,
          shadowColor: Colors.grey,
          style: TabStyle.fixedCircle,
          items: bottomBars,
          onTap: (int index) => onTapped(index),
        ));
  }
}
