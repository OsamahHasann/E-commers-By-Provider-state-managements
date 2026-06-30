import 'package:e_commers_by_provider/core/theme/app_colors.dart';
import 'package:e_commers_by_provider/core/theme/theme_provider.dart';
import 'package:e_commers_by_provider/features/cart/cart_presention/cart_screen.dart';
import 'package:e_commers_by_provider/features/cart/cart_provider/cart_provider.dart';
import 'package:e_commers_by_provider/features/products/product_presention/category_screen.dart';
import 'package:e_commers_by_provider/features/products/product_presention/favorit_prodacts.dart';
import 'package:e_commers_by_provider/features/products/product_presention/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomBottNav extends StatefulWidget {
  const CustomBottNav({super.key});

  @override
  State<CustomBottNav> createState() => _CustomBottNavState();
}

class _CustomBottNavState extends State<CustomBottNav> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor:AppColors.primary,
          unselectedLabelStyle: TextStyle(color: AppColors.primary),
          selectedIconTheme: IconThemeData(color: AppColors.primary),
          unselectedItemColor: AppColors.primary,
          items: [
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.home),
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProductsScreen(),
                    ),
                  ),
                },
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.category_rounded),
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CategoriesScreen()),
                  ),
                },
              ),
              label: "Categories",
            ),

            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.favorite_border_rounded),
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavoritesScreen(),
                    ),
                  ),
                },
              ),
              label: "Favorites",
            ),

            BottomNavigationBarItem(
              icon: Stack(
                alignment: Alignment.topRight,
                children: [
                  IconButton(
                    icon: Icon(Icons.shopping_cart_outlined),
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartScreen(),
                        ),
                      ),
                    },
                  ),
                  Consumer<CartProvider>(
                    builder: (context, provider, child) {
                      if (provider.itemCount > 0) {
                        return Text("${provider.itemCount}");
                      }
                      return Text("");
                    },
                  ),
                ],
              ),
              label: "Cart",
            ),
          ],
        );
      },
    );
  }
}
