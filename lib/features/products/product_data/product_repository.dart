import 'dart:convert';
import 'package:http/http.dart' as http;
import './product_model.dart';

class ProductRepository {

  final String _baseUrl = "https://fakestoreapi.com/products";
 Future<List<ProductModel>> products() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        
        List<ProductModel> productsList = body
            .map((dynamic item) => ProductModel.fromJson(item))
            .toList();
            
        return productsList;
      } else {
        throw Exception("فشل جلب البيانات من الخادم: ${response.statusCode}");
      }
    } catch (e) {
      
      throw Exception("حدث خطأ أثناء الاتصال بالـ API: $e");
    }
  }
}