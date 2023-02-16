	import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nearchat/screens/home/chat_screen.dart';
import 'package:nearchat/screens/home/profile_screen.dart';
import 'package:nearchat/ui/theme/appcolors.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 1;
  List<IconData> iconList = [
    Icons.map,
    Icons.chat,
    Icons.account_circle,
  ];
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        activeColor: AppColor.primaryColorD1,
        borderColor: Colors.green,
        inactiveColor: AppColor.primaryColorL0,
        activeIndex: _index,
        splashColor: AppColor.primaryColor,
        gapLocation: GapLocation.none,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => setState(() => _index = index),
        //other params
      ),
      body: IndexedStack(
        index: _index,
        children: const [ConnectScreen(), ChatScreen(), ProfileScreen()],
      ),
    );
  }
}

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({super.key});

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("connect screen")),
    );
  }
}
