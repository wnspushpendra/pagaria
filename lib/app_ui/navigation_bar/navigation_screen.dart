import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:webnsoft_solution/app_common_widges/normal_text.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/home/ui/home.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/order/order_detail.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/product/product.dart';
import 'package:webnsoft_solution/app_ui/navigation_pages/profile/profile.dart';
import 'package:webnsoft_solution/utils/app_colors.dart';
import 'package:webnsoft_solution/utils/app_strings.dart';
import 'package:webnsoft_solution/utils/dialogs.dart';




class NavigationPageScreen extends StatefulWidget {
  const NavigationPageScreen({ Key? key}) : super(key: key);

  @override
  State<NavigationPageScreen> createState() => _NavigationPageScreenState();
}

class _NavigationPageScreenState extends State<NavigationPageScreen> {
  int _currentIndex = 0;

  get getBottomNavigationBar => SalomonBottomBar(
        backgroundColor: Colors.red.withOpacity(0.2),
        currentIndex: _currentIndex,
        onTap: (i) => setState(() {
          _currentIndex = i;
        }),
        items: [
          ///home
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title:  const NormalText(
             // text: AppLocalizations.of(context).home,
             text: home,
              color: primaryColor,
              textSize: 13,
            ),
            unselectedColor: bodyLightBlack,
            selectedColor: primaryColor,
          ),

          ///product
          SalomonBottomBarItem(
            icon: const Icon(Icons.production_quantity_limits),
            title:  const NormalText(
             // text: AppLocalizations.of(context).review,
              text: product,
              color: primaryColor,
              textSize: 13,
            ),
            selectedColor: primaryColor,
          ),
          ///order
          SalomonBottomBarItem(
            icon: const Icon(Icons.edit_note_sharp),
            title:  const NormalText(
             // text: AppLocalizations.of(context).review,
              text: order,
              color: primaryColor,
              textSize: 13,
            ),
            selectedColor: primaryColor,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: const Icon(Icons.person_outline_rounded),
            title:  const NormalText(
              //text: AppLocalizations.of(context).profile,
              text: profile,
              color: primaryColor,
              textSize: 13,
            ),
            selectedColor: primaryColor,
          ),
        ],
      );

  final List<Widget> _pages = [
    const HomeScreen(),
    const ProductScreen(),
    const OrderScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onBackNavigationScreen(context),
      child: Scaffold(
        bottomNavigationBar: getBottomNavigationBar,
        body: _pages[_currentIndex],
      ),
    );
  }
}
