import 'package:diploy_task/screens/tab.screens/carttab.screen/cart_screen.dart';
import 'package:diploy_task/screens/tab.screens/carttab.screen/cart_view_model.dart';
import 'package:diploy_task/screens/tab.screens/hometab.screen/home_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class TabScreen extends HookWidget {
  const TabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentIndex = useState(0);
    List<Widget> tabs = [
      const HomeTabScreen(),
      const CartTabScreen(),
    ];

    Future<bool> _onWillPop() async {
      if (currentIndex.value != 0) {
        currentIndex.value = 0;
        return false; // Prevents the default back button behavior
      }
      return true; // Allows the default back button behavior (exit app)
    }

    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: tabs[currentIndex.value],
          bottomNavigationBar: Consumer<TabViewModel>(builder: (context, provider, child) {
            return PersistentTabView(
              context,
              controller: provider.persistentTabController,
              screens: const [HomeTabScreen(), CartTabScreen()],
              items: [
                PersistentBottomNavBarItem(
                  icon: const Icon(Icons.home),
                  title: "Home",
                ),
                PersistentBottomNavBarItem(
                  icon: Consumer<CartViewModel>(builder: (context, provider, child) {
                    int totalQuantity = provider.getTotalCount();
                    return 10 > 0
                        ? badges.Badge(
                            badgeContent: Text(
                              totalQuantity.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11.0,
                              ),
                            ),
                            badgeStyle: badges.BadgeStyle(
                              shape: badges.BadgeShape.circle,
                              badgeColor: Colors.blue,
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(color: Colors.white, width: 2),
                              elevation: 0,
                            ),
                            child: const Icon(Icons.shopping_cart),
                          )
                        : const Icon(Icons.shopping_cart);
                  }),
                  title: "Cart",
                ),
              ],
              confineToSafeArea: true,
              backgroundColor: Colors.white,
              handleAndroidBackButtonPress: true,
              resizeToAvoidBottomInset: true,
              stateManagement: true,
              hideNavigationBarWhenKeyboardAppears: true,
              decoration: const NavBarDecoration(
                border: Border(
                    top: BorderSide(
                  color: Colors.grey,
                )),
                // borderRadius: BorderRadius.circular(10.0),
                colorBehindNavBar: Colors.white,
              ),
              popBehaviorOnSelectedNavBarItemPress: PopBehavior.none,
              animationSettings: const NavBarAnimationSettings(
                  navBarItemAnimation: ItemAnimationSettings(
                      duration: Duration(milliseconds: 200), curve: Curves.ease)),
              navBarStyle: NavBarStyle.style3,
            );
          }),
        ));
  }
}

class TabViewModel with ChangeNotifier {
  var screenIndex = 0;
  PersistentTabController persistentTabController = PersistentTabController(initialIndex: 0);
  void onTap(int index) {
    screenIndex = index;
    notifyListeners();
  }

  void disposeValues() {
    persistentTabController = PersistentTabController(initialIndex: 0);
    screenIndex = 0;
  }

  void moveToPage(int index) {
    screenIndex = index;
    persistentTabController.jumpToTab(index);
    notifyListeners();
  }
}
