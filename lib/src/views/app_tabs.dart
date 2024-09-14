import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bni_trading/src/utils/index.dart';
import 'package:bni_trading/src/views/dashboard/dashboard_page.dart';
import 'package:bni_trading/src/views/watchlist/watchlist_page.dart';

class AppTabs extends StatefulWidget {
  const AppTabs({super.key});

  @override
  State<AppTabs> createState() => _AppTabsState();
}

class _AppTabsState extends State<AppTabs> {
  int _selectedPage = 0;
  void _onItemTapped(int index) {
    setState(() => _selectedPage = index);
  }

  static const List<Widget> _page = <Widget>[DashboardPage(), WatchlistPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          centerTitle: true,
          title: Text('BNI Trading', style: AppStyles.wRegular(20)),
          systemOverlayStyle: SystemUiOverlayStyle.light
              .copyWith(systemNavigationBarColor: Colors.blueGrey[100]),
        ),
        body: _page.elementAt(_selectedPage),
        bottomNavigationBar: Container(
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(color: Colors.black45, offset: Offset(0, -0.2))
            ]),
            child: NavigationBar(
              height: 65,
              onDestinationSelected: _onItemTapped,
              surfaceTintColor: Colors.white,
              backgroundColor: AppColors.lightgray,
              indicatorColor: AppColors.primary,
              selectedIndex: _selectedPage,
              destinations: <Widget>[
                NavigationDestination(
                    selectedIcon: contIconTabs(
                        const Icon(Icons.dashboard, color: Colors.white)),
                    icon: contIconTabs(const Icon(Icons.dashboard)),
                    label: 'Dashboard',
                    tooltip: 'Dashboard Aplikasi'),
                NavigationDestination(
                    selectedIcon: contIconTabs(
                        const Icon(Icons.list_alt, color: Colors.white)),
                    icon: contIconTabs(const Icon(Icons.list_alt)),
                    label: 'Watchlist',
                    tooltip: 'Watchlist'),
              ],
            )));
  }

  Widget contIconTabs(Widget svg) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 3),
        width: 26,
        height: 26,
        child: svg);
  }
}
