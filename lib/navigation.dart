import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kradadtod/features/financial/screens/accountScreen.dart';
import 'package:kradadtod/features/financial/screens/discoverScreen.dart';
import 'package:kradadtod/features/financial/screens/statisticsScreen.dart';
import 'package:kradadtod/utils/constants/colors.dart';
import 'package:kradadtod/utils/helpers/functions.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<StatefulWidget> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  static const List<Widget> _widgetOptions = <Widget>[
    DiscoverScreen(),
    StatisticsScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(90)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 12,
                      offset: const Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GNav(
                    color: Colors.black,
                    activeColor: KAppColors.azure,
                    tabBackgroundColor: Colors.grey.shade200,
                    gap: 10,
                    padding: const EdgeInsets.all(12.0),
                    tabs: const [
                      GButton(
                        icon: FluentIcons.news_16_regular,
                        text: "Discover",
                      ),
                      GButton(
                        icon: FluentIcons.data_histogram_16_regular,
                        text: "Statistics",
                      ),
                      GButton(
                        icon: FluentIcons.person_16_regular,
                        text: "Account",
                      ),
                    ],
                    iconSize: 24.0,
                    textStyle: Theme.of(context).textTheme.titleMedium,
                    selectedIndex: _selectedIndex,
                    onTabChange: (index) {
                      setState(
                        () {
                          _selectedIndex = index;
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
