import 'package:assignment/presentation/Login/Loginform.dart';
import 'package:assignment/presentation/Login/Signupform.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';

class Tabcontrollerwidget extends StatelessWidget {
  const Tabcontrollerwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: <Widget>[
          ButtonsTabBar(
              // Customize the appearance and behavior of the tab bar
              backgroundColor: Colors.red,
              borderWidth: 2,
              borderColor: Colors.black,
              labelStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              // Add your tabs here
              tabs: const [
                Tab(
                  text: "hello",
                ),
                Tab(
                  text: "haii",
                )
              ]),
          const Expanded(
            child: TabBarView(children: [Loginform(), Signupform()]),
          ),
        ],
      ),
    );
  }
}
