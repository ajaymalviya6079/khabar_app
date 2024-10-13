
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khabar/views/top-article/top-article.dart';
import 'dart:math' as math;
import '../../Utils/colors.dart';
import '../../views/bookmark/bookmark.dart';
import '../../views/ePapar/ePapar_view.dart';
import '../../views/home/home_view.dart';
import 'controller/bottomNavController.dart';


class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      HomeView(),
      const TopArticle(),
      const Bookmark(),
      const ePaparView(),
    ];

    return GetBuilder<BottomNavBarController>(
      init: BottomNavBarController(),
      builder: (controller) {
        return Scaffold(
          body: _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 2),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Transform.rotate(
                      angle: -math.pi / 1,
                      child: Image.asset(
                        'assets/images/book.png',
                        height: 20,
                        width: 20,
                        color: _selectedIndex == 1
                            ? AppColors.primary
                            : AppColors.whit,
                      ),
                    ),
                    label: 'Mags&Papers',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.bookmark),
                    label: 'Bookmark',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.pageview),
                    label: 'ePaper',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: AppColors.primary,
                unselectedItemColor: AppColors.lightWhit,
                onTap: _onItemTapped,
                backgroundColor: AppColors.red,
                type: BottomNavigationBarType.fixed,
                elevation: 0,
              ),
            ),
          ),
        );
      },
    );
  }
}


