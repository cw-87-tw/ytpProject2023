import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:summarease/pages/history_page.dart';
import 'account_page.dart';
import 'new_file_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int curInd = 1;
  final List<Widget> pages = [
    HistoryPage(),
    const NewFilePage(),
    AccountPage(),
  ];

  void navigateBottomBar(int ind) {
    setState(() {
      curInd = ind;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,

      body: pages[curInd],

      bottomNavigationBar: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: GNav(
            gap: 8,
            padding: const EdgeInsets.all(18.0),
            backgroundColor: Theme.of(context).colorScheme.secondary,
            color: Theme.of(context).colorScheme.background,
            activeColor: Theme.of(context).colorScheme.primary,
            tabBackgroundColor: Theme.of(context).colorScheme.background,
            mainAxisAlignment: MainAxisAlignment.center,
            tabMargin: const EdgeInsets.symmetric(horizontal: 15.0),
            iconSize: 30,

            selectedIndex: curInd,
            onTabChange: navigateBottomBar,
            tabs: const [
              GButton(
                icon: Icons.list_alt,
                text: '檔案紀錄',
              ),
              GButton(
                icon: Icons.add,
                text: '新增檔案',
              ),
              GButton(
                icon: Icons.person,
                text: '個人帳號',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
