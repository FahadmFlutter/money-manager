import 'package:flutter/material.dart';
import 'package:money_manager/Screens/Home/screen_home.dart';

class MoneyManagerBottomNavigation extends StatelessWidget {
  const MoneyManagerBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.selectedIndexNotifier,
      builder: (context, int updatedIndex, Widget? _) {
        return NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          selectedIndex: updatedIndex,
          onDestinationSelected: (newIndex) {
            ScreenHome.selectedIndexNotifier.value = newIndex;
          },

          // showSelectedLabels: false,
          //  showUnselectedLabels: false,
          //  unselectedItemColor: Colors.grey,
          //  currentIndex: updatedIndex,
          //  onTap: (newIndex){
          //    ScreenHome.selectedIndexNotifier.value = newIndex;
          //  },
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(Icons.receipt_long),
              icon: Icon(Icons.receipt_long_outlined),
              label: 'Transactions',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.difference),
              icon: Badge(
                  backgroundColor: Colors.red,
                  isLabelVisible: false,
                  child: Icon(Icons.difference_outlined)),
              label: 'category',
            ),
            // BottomNavigationBarItem(
            //   activeIcon: Icon(Icons.home),
            //   icon: Icon(Icons.home_outlined),
            //   label: 'Transactions',
            // ),
            // BottomNavigationBarItem(
            //   activeIcon: Icon(Icons.difference),
            //   icon: Icon(Icons.difference_outlined),
            //   label: 'category',
            // ),
            // BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          ],
        );
      },
    );
  }
}
