import 'package:e_commers_by_provider/features/cart/cart_provider/cart_provider.dart';
import 'package:e_commers_by_provider/features/products/product_presention/products_screen.dart';
import 'package:e_commers_by_provider/features/products/product_provider/favorit_provider.dart';
import 'package:e_commers_by_provider/features/products/product_provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './core/theme/app_theme.dart';
import 'core/constants/app_constans.dart';
// import 'features/products/product_presention/products_screen.dart';


void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (contaxt) => ProductProvider()),
        ChangeNotifierProvider(create: (contaxt) => FavoriteProvider()),
        ChangeNotifierProvider(create: (contaxt) => CartProvider()),
      ],
      child: const MyApp(),
    ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: AppTheme.darkTheme,
      home:  ProductsScreen(),
    );
  }
}
