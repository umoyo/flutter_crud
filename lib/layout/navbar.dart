import 'package:flutter/material.dart';
import 'package:flutter_crud/berita/berita.dart';
import 'package:flutter_crud/tugas/tugas.dart';
import 'package:flutter_crud/unduh/unduh.dart';
import 'package:flutter_crud/layout/carousel_slider.dart';

class NavigationBarPage extends StatefulWidget {
  const NavigationBarPage({Key? key}) : super(key: key);

  @override
  State<NavigationBarPage> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<NavigationBarPage> {
  int _selectedIndex = 0;
  final screens = [
    const BeritaPage(),
    const TugasPage(),
    const UnduhPage(),
    const CarouselDemo(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      //  title: const Text('Aplication'),
      //),
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // This is all you need!
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'berita',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'tugas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.download),
            label: 'unduh',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.download),
            label: 'summary',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
