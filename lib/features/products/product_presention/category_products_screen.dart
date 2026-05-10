import 'package:e_commers_by_provider/core/widgets/custom_bott_nav.dart';
import 'package:e_commers_by_provider/core/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../product_provider/product_provider.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String categoryName;
  final String categoryTitle;

  const CategoryProductsScreen({super.key, required this.categoryName, required this.categoryTitle});

  @override
  Widget build(BuildContext context) {
    // جلب المنتجات المفلترة باستخدام الدالة التي أنشأناها
    final categoryProducts = Provider.of<ProductProvider>(context, listen: false)
        .getProductsByCategory(categoryName);

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: categoryProducts.isEmpty 
        ? const Center(child: Text('لا توجد منتجات في هذا القسم حالياً'))
        : GridView.builder(
            padding: const EdgeInsets.all(16.0), // تعديل المسافة لتطابق باقي التطبيق
            itemCount: categoryProducts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7, // تعديل النسبة لتطابق ProductsScreen
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (ctx, i) {
              // التعديل هنا: تمرير المنتج مباشرة للبطاقة كما تفعل في باقي التطبيق
              return ProductCard(product: categoryProducts[i]); 
            },
          ),
        bottomNavigationBar: CustomBottNav(),
    );
  }
}