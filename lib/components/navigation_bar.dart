import 'package:dagather_frontend/screens/account/screens/account_screen.dart';
import 'package:dagather_frontend/screens/chat/screens/chats_screen.dart';
import 'package:dagather_frontend/screens/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utilities/colors.dart';

class BaseScaffold extends StatefulWidget {
  const BaseScaffold({super.key});

  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  int _selectedIdx = 0;

  final List<Widget> _screenList = [
    const HomeScreen(),
    const ChatsScreen(),
    const AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIdx = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _screenList.elementAt(_selectedIdx),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIdx,
        backgroundColor: Colors.white,
        unselectedItemColor: AppColor.g400,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                width: 24.w,
                'assets/icons/navigation/ic_home.svg',
              ),
              activeIcon: SvgPicture.asset(
                width: 24.w,
                'assets/icons/navigation/ic_home_filled.svg',
              ),
              label: 'home'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                width: 24.w,
                'assets/icons/navigation/ic_chat.svg',
              ),
              activeIcon: SvgPicture.asset(
                width: 24.w,
                'assets/icons/navigation/ic_chat_filled.svg',
              ),
              label: 'chat'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                width: 24.w,
                'assets/icons/navigation/ic_person.svg',
              ),
              activeIcon: SvgPicture.asset(
                width: 24.w,
                'assets/icons/navigation/ic_person_filled.svg',
              ),
              label: 'account'),
        ],
      ),
    );
  }
}
