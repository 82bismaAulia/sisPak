import 'package:flutter/material.dart';
import 'package:tanampedia/masterdata.dart';
import 'package:tanampedia/menumasterdata.dart';
import 'package:tanampedia/tambahtanah.dart';
//import './login.dart';

class DashboardAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AdminPage(),
      routes: <String, WidgetBuilder>{
        '/prosestanahtambah': (BuildContext context) => new ProsesTambahTanah(),
      },
    );
  }
}

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _selectedTabIndex = 0;

  void _onNavBarTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _listPage = <Widget>[
      Text('Halama Home'),
      MenuMasterData(),
      Text('Halama Profile')
    ];

    final _bottomNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Master Data'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
    ];

    final _bottomNavBar = BottomNavigationBar(
      items: _bottomNavBarItems,
      currentIndex: _selectedTabIndex,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.black,
      onTap: _onNavBarTapped,
    );

    return Scaffold(
        //appBar: AppBar(),
        body: Center(
          child: _listPage[_selectedTabIndex],
        ),
        bottomNavigationBar: _bottomNavBar);
  }
}
