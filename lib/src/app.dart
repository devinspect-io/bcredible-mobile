import 'package:bcredible/src/screens/home_screen.dart';
import 'package:bcredible/src/screens/layout/bottom_navigation.dart';
import 'package:bcredible/src/screens/profile_screen.dart';
import 'package:bcredible/src/screens/setting_screen.dart';
import 'package:bcredible/src/screens/shared/tab_item.dart';
import 'package:bcredible/src/screens/business/add_business.dart';

import 'package:flutter/material.dart';

class App extends StatefulWidget {
  // this is static property so other widget throughout the app
  // can access it simply by AppState.currentTab
  static int currentTab = 0;
  // list tabs here
  final List<TabItem> tabs = [
    TabItem(
      tabName: "Home",
      icon: Icons.home,
      page: ProfileScreen(),
    ),
    TabItem(
      tabName: "Settings",
      icon: Icons.settings,
      page: SettingsScreen(),
    ),
  ];
  State<StatefulWidget> createState() => AppState();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text('bCredible'),
            backgroundColor: Color.fromRGBO(0, 209, 189, 100),
          ),
          body: HomeScreen(),
        ));
  }
}

class AppState extends State<App> {
  // this is static property so other widget throughout the app
  // can access it simply by AppState.currentTab
  static int currentTab = 0;

  // list tabs here
  final List<TabItem> tabs = [
    TabItem(
      tabName: "Home",
      icon: Icons.home,
      page: HomeScreen(),
    ),
    TabItem(
      tabName: "Add",
      icon: Icons.add_business_outlined,
      page: AddBusinessWidget(),
    ),
    TabItem(
      tabName: "Settings",
      icon: Icons.settings,
      page: SettingsScreen(),
    ),
  ];

  AppState() {
    // indexing is necessary for proper funcationality
    // of determining which tab is active
    tabs.asMap().forEach((index, details) {
      details.setIndex(index);
    });
  }

  // sets current tab index
  // and update state
  void _selectTab(int index) {
    if (index == currentTab) {
      // pop to first route
      // if the user taps on the active tab
      tabs[index].key.currentState.popUntil((route) => route.isFirst);
    } else {
      // update the state
      // in order to repaint
      setState(() => currentTab = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    // WillPopScope handle android back btn
    return MaterialApp(
        home: WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await tabs[currentTab].key.currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (currentTab != 0) {
            // select 'main' tab
            _selectTab(0);
            // back button handled by app
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      // this is the base scaffold
      // don't put appbar in here otherwise you might end up
      // with multiple appbars on one screen
      // eventually breaking the app
      child: Scaffold(
        // indexed stack shows only one child
        body: IndexedStack(
          index: currentTab,
          children: tabs.map((e) => e.page).toList(),
        ),
        // Bottom navigation
        bottomNavigationBar: BottomNavigation(
          onSelectTab: _selectTab,
          tabs: tabs,
        ),
      ),
    ));
  }
}

// for login
// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Provider(
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Log Me In',
//         home: Scaffold(
//             appBar: AppBar(
//                 title: Text('bCredible'),
//                 backgroundColor: Color.fromRGBO(0, 209, 189, 100)),
//             body: LoginScreen()),
//       ),
//     );
//   }
// }
