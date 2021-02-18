import 'package:flutter/material.dart';
import 'package:coffeedic/screens/home/home_page.dart';
import 'package:coffeedic/screens/home/favorite_page.dart';
import 'package:coffeedic/screens/home/experience_page.dart';
import 'package:coffeedic/screens/home/auth_page.dart';
import 'package:coffeedic/widgets/icon_badge.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController;
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics:
            NeverScrollableScrollPhysics(), //화면 전체가 스와이핑 되는 옵션 지정, 현재는 불가설정됨
        //AlwaysScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: <Widget>[
          Home(),
          FavouritePage(),
          ExperiencePage(),
          AuthPage(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(width: 7.0),
            barIcon(icon: Icons.home_filled, page: 0),
            barIcon(icon: Icons.sentiment_satisfied_alt, page: 1),
            barIcon(icon: Icons.storefront, page: 2),
            barIcon(
              icon: Icons.person,
              page: 3,
            ),
            SizedBox(width: 7.0),
          ],
        ),
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  Widget barIcon(
      {IconData icon = Icons.home_filled, int page = 0, bool badge = false}) {
    return IconButton(
      icon: badge ? IconBadge(icon: icon, size: 24.0) : Icon(icon, size: 24.0),
      color:
          //  _page == page ? Theme.of(context).accentColor : Colors.blueGrey[300],
          _page == page ? Colors.amber : Colors.blueGrey[300],
      onPressed: () {
        //print("page" + page);
        return _pageController.jumpToPage(page);
      },
    );
  }
}
