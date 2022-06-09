import 'package:finance_tracker/colors.dart';
import 'package:finance_tracker/models/user_model.dart';
import 'package:finance_tracker/screens/dashboard_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/user_provider.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late PageController pageController;
  int _page = 0;

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  void initState() {
    addData();
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      body: user == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : PageView(
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: onPageChanged,
              controller: pageController,
              children: const [
                DashboardScreen(),
                Text('favoriter'),
                Text('settings'),
                Text('rererer'),
              ],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: primaryColor,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: 75,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                iconSize: 30.0,
                padding: const EdgeInsets.only(left: 28.0),
                icon: Icon(
                  _page == 0 ? CupertinoIcons.house_fill : CupertinoIcons.house,
                  size: 25,
                  color: _page == 0 ? primaryColor : Colors.grey[400],
                ),
                onPressed: () {
                  setState(() {
                    pageController.jumpToPage(0);
                    _page = 0;
                  });
                },
              ),
              IconButton(
                iconSize: 30.0,
                padding: const EdgeInsets.only(right: 28.0),
                icon: Icon(
                  size: 25,
                  _page == 1
                      ? CupertinoIcons.chart_bar_fill
                      : CupertinoIcons.chart_bar,
                  color: _page == 1 ? primaryColor : Colors.grey[400],
                ),
                onPressed: () {
                  setState(() {
                    pageController.jumpToPage(1);
                    _page = 1;
                  });
                },
              ),
              IconButton(
                iconSize: 30.0,
                padding: const EdgeInsets.only(left: 28.0),
                icon: Icon(
                  Icons.notifications,
                  color: _page == 2 ? primaryColor : Colors.grey[400],
                ),
                onPressed: () {
                  setState(() {
                    pageController.jumpToPage(2);
                    _page = 2;
                  });
                },
              ),
              IconButton(
                iconSize: 30.0,
                padding: const EdgeInsets.only(right: 28.0),
                icon: Icon(
                  _page == 3
                      ? CupertinoIcons.gear_alt_fill
                      : CupertinoIcons.gear_alt,
                  size: 25,
                  color: _page == 3 ? primaryColor : Colors.grey[400],
                ),
                onPressed: () {
                  setState(() {
                    pageController.jumpToPage(3);
                    _page = 3;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
