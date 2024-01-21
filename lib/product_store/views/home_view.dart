import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:store_pro/product_store/views/cart_view.dart';
import 'package:store_pro/product_store/views/icecream_view.dart';
import 'package:store_pro/product_store/views/search_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int ind = 0;
  @override
  Widget build(BuildContext context) {
    Widget activeScreen = const IceCreamView();

    if (ind == 1) {
      activeScreen = const SearchView();
    }
    if (ind == 2) {
      activeScreen = const CartView();
    }

    return Scaffold(
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: ind,
        onTap: (index) {
          setState(() {
            ind = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Ionicons.ice_cream_outline),
            label: 'Icecreams',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_checkout),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
