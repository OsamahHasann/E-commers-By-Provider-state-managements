import 'package:e_commers_by_provider/core/constants/app_constans.dart';
import 'package:e_commers_by_provider/features/cart/cart_provider/cart_provider.dart';
import 'package:e_commers_by_provider/features/products/product_data/product_model.dart';
import 'package:e_commers_by_provider/features/products/product_presention/product_details_screen.dart';
import 'package:e_commers_by_provider/features/products/product_provider/favorit_provider.dart';
import 'package:e_commers_by_provider/features/products/product_provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;
  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        return InkWell(
          onTap: () {
            productProvider.selectedProduct = widget.product;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (contaxt) => ProductDetailsScreen()),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(AppConstants.cardRadius),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    child: Image.network(
                      widget.product.image,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${widget.product.price} \$",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${widget.product.category} ",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // داخل ProductCard
                      Consumer<FavoriteProvider>(
                        builder: (context, favProvider, child) {
                          // التحقق هل هذا المنتج موجود في قائمة المفضلة السحابية
                          bool isFav = favProvider.favoriteProductIds.contains(
                            widget.product.id,
                          );

                          return IconButton(
                            icon: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              color: isFav ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {
                              favProvider.toggleFavorite(widget.product);
                            },
                          );
                        },
                      ),

                      Consumer<CartProvider>(
                        builder: (context, cartProvider, child) {
                          return IconButton(
                            icon: Icon(
                              widget.product.isAddedToCart
                                  ? Icons.remove_circle
                                  : Icons.add_circle,

                              color: Theme.of(context).primaryColor,
                              size: 30,
                            ),
                            onPressed: () {
                              if (widget.product.isAddedToCart) {
                                cartProvider.removeItem(widget.product);
                              } else {
                                cartProvider.addItem(widget.product);
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
