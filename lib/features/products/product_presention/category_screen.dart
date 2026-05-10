import 'package:e_commers_by_provider/core/widgets/custom_bott_nav.dart';
import 'package:e_commers_by_provider/features/cart/cart_presention/cart_screen.dart';
import 'package:e_commers_by_provider/features/cart/cart_provider/cart_provider.dart';
import 'package:e_commers_by_provider/features/products/product_presention/favorit_prodacts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'category_products_screen.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('sections'),
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
        ],),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildCategoryCard(
              context, 
              title: 'Food section', 
              category: 'food', 
              icon: Icons.fastfood
            ),
            SizedBox(height: 20),
            _buildCategoryCard(
              context, 
              title: 'Perfume section', 
              category: 'perfume', 
              icon: Icons.local_florist
            ),
          ],
        ),
      ),

       bottomNavigationBar: CustomBottNav(),
    );
  }

  Widget _buildCategoryCard(BuildContext context, {required String title, required String category, required IconData icon}) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CategoryProductsScreen(
              categoryName: category,
              categoryTitle: title,
            ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          height: 120,
          width: double.infinity,
          alignment: Alignment.center,
          child: ListTile(
            leading: Icon(icon, size: 50, color: Theme.of(context).primaryColor),
            title: Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ),
      ),
    );
  }
}