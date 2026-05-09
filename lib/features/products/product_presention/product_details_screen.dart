import 'package:e_commers_by_provider/core/constants/app_constans.dart';
import 'package:e_commers_by_provider/core/widgets/product_card.dart';
import 'package:e_commers_by_provider/features/cart/cart_presention/cart_screen.dart';
import 'package:e_commers_by_provider/features/cart/cart_provider/cart_provider.dart';
import 'package:e_commers_by_provider/features/products/product_presention/favorit_prodacts.dart';
import 'package:e_commers_by_provider/features/products/product_provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        actions: [
        IconButton(
            icon: Icon(Icons.favorite_border_rounded, color: Colors.red),
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritesScreen(),
                ),
              ),
            },
          ),
        Stack(
          alignment: Alignment.topRight,
          children: [
              IconButton(
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
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
          ],)
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
         
              return ProductCard(product: provider.selectedProduct);
            },
          ));
        }
        
      
    
  }

