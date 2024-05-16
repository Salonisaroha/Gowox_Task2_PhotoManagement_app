import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const home());
}

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
     home : _DashboardState(),
     title: 'Photo Management app',
     
    );
  }
}
class _DashboardState extends StatefulWidget {
  const _DashboardState({super.key});

  @override
  State<_DashboardState> createState() => __DashboardStateState();
}

class __DashboardStateState extends State<_DashboardState> {
  int _bottomNavIndex = 0;
  void _onItemTapped (int index){
    setState(() {
      _bottomNavIndex = index;
    });
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      bottomNavigationBar:AnimatedBottomNavigationBar(
        activeIndex: _bottomNavIndex,
        icons: [Icons.home_mini_outlined,Icons.favorite],
      backgroundColor: Colors.black,
      elevation: 10,
      height:80,
      iconSize: 30,
      activeColor: Colors.white,
      inactiveColor: Colors.white24,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      leftCornerRadius: 32,
      rightCornerRadius: 32,
      onTap: (index)=> setState(()=>_bottomNavIndex= index)) ,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(onPressed: () => {},
      backgroundColor: Colors.black,
      child:Icon(Icons.add, color: Colors.white, size:25)
      ),
      

    );
  }
}