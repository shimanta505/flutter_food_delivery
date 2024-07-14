import 'package:flutter/material.dart';
import 'package:flutter_food_delivary/pages/home/cart/cart_history.dart';
import 'package:flutter_food_delivary/pages/home/cart/cart_page.dart';
import 'package:flutter_food_delivary/pages/home/food_page.dart';
import 'package:flutter_food_delivary/utils/app_colors.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPageIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const FoodPage(),
      const CartPage(),
      const CartHistory(),
      Container(child: const Center(child: Text("profile page"))),
    ];

    void onTapNav(int index) {
      setState(() {
        selectedPageIndex = index;
      });
    }

    return Scaffold(
      body: pages[selectedPageIndex],
      bottomNavigationBar: Theme(
        data: ThemeData(
          // splashColor: Colors.transparent,
          // highlightColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          colorScheme: Get.isDarkMode
              ? const ColorScheme.dark()
              : const ColorScheme.light(),
        ),
        child: BottomNavigationBar(
          selectedItemColor: AppColors.mainColor,
          unselectedItemColor: Colors.amberAccent,
          elevation: 0,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: onTapNav,
          currentIndex: selectedPageIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(selectedPageIndex == 0
                    ? Icons.home_outlined
                    : Icons.home_filled),
                label: "home page"),
            const BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_checkout), label: "checkout"),
            const BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: "cart  page"),
            const BottomNavigationBarItem(
                icon: Icon(Icons.person_2_rounded), label: "profile"),
          ],
        ),
      ),
    );
  }
}
