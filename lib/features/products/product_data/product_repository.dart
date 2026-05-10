import 'package:e_commers_by_provider/core/constants/app_assets.dart';

import './product_model.dart';
class ProductRepository {
  
  List<ProductModel> products() {
    return [
      ProductModel(
        id: '1',
        name: 'checken burger ',
        description: 'meat burger with chider cheec',
        price: 5.5,
        image: AppAssets.burger,
        category: "food",
      ),
      ProductModel(
        id: '2',
        name: 'meat burger',
        description: 'meat burger with chider cheec',
        price: 5.5,
        image: AppAssets.burger2,
        category: "food",
      ),
      ProductModel(
        id: '3',
        name: 'italic pizza',
        description: 'vegitarain pizza with margrit',
        price: 8.0,
        image:AppAssets.pizza,
        category: "food",
      ),
      ProductModel(
        id: '4',
        name: 'shawerma',
        description: 'arabic shawerma with meet and vegitables',
        price: 8.0,
        image:AppAssets.shawerma,
        category: "food",
      ),
      ProductModel(
        id: '5',
        name: 'men perfume',
        description: 'arabic shawerma with meet and vegitables',
        price: 20.0,
        image:AppAssets.per1,
        category: "perf",
      ),
      ProductModel(
        id: '6',
        name: 'women perfume',
        description: 'arabic shawerma with meet and vegitables',
        price: 20.0,
        image:AppAssets.perf2,
        category: "perf",
      ),
    ];
  }
}