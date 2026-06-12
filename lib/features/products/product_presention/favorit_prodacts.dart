import 'package:e_commers_by_provider/core/constants/app_constans.dart';
import 'package:e_commers_by_provider/core/widgets/custom_bott_nav.dart';
import 'package:e_commers_by_provider/core/widgets/product_card.dart';
import 'package:e_commers_by_provider/features/products/product_provider/favorit_provider.dart';
import 'package:e_commers_by_provider/features/products/product_provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Products')),
      body: Consumer2<ProductProvider, FavoriteProvider>(
        builder: (context, productProvider, favProvider, child) {
          
          final favoriteProducts = productProvider.getProducts.where((product) {
            return favProvider.favoriteProductIds.contains(product.id);
          }).toList();

          if (favoriteProducts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text('لا توجد منتجات في المفضلة!', style: TextStyle(color: Colors.grey[600], fontSize: 18)),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: EdgeInsets.all(AppConstants.horizontalPadding),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.72,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: favoriteProducts.length,
            itemBuilder: (context, index) {
              return ProductCard(product: favoriteProducts[index]);
            },
          );
        },
      ),
      bottomNavigationBar: CustomBottNav(),
    );
  }
}