import 'package:flutter/material.dart';
import 'package:movie/pages/SearchMovie/searchMovie.dart';
import 'package:movie/pages/account/account.dart';
import 'package:movie/pages/bookingHistory/bookingHistory.dart';
import 'package:movie/pages/homePage/homePage.dart';
import 'package:movie/pages/news/new.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

//import 'page/account/accountwidget.dart';

class Mainpage extends StatefulWidget {
  final int initialIndex;

  const Mainpage({super.key, this.initialIndex = 0});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  static const List<Widget> _widgetOptions = <Widget>[
    Homepage(),
    SearchMoviePage(),
    BookHistoryPage(),
    NewPage(),
    AccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: ConvexAppBar(
            style: TabStyle.reactCircle,
            items: const <TabItem>[
              TabItem(icon: Icons.home, title: 'Trang Chủ'),
              TabItem(icon: Icons.search, title: 'Tìm Kiếm'),
              TabItem(icon: Icons.category_outlined, title: 'Lịch Sử'),
              TabItem(icon: Icons.person, title: 'Tin Tức'),
              TabItem(icon: Icons.info, title: 'Thông Tin'),
            ],
            initialActiveIndex: _selectedIndex,
            onTap: _onItemTapped,
            gradient: const LinearGradient(
              colors: [
                Color.fromRGBO(32, 40, 141, 1),
                Color.fromRGBO(73, 84, 199, 1),
                Color.fromRGBO(98, 65, 170, 1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.05, 0.65, 1],
            ),
          ),
        ));
  }
}
