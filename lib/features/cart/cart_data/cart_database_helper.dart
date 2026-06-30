import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CartDatabaseHelper {
  static final CartDatabaseHelper instance = CartDatabaseHelper._init();
  static Database? _database;

  CartDatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('cart.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    // إنشاء جدول السلة
    await db.execute('''
    CREATE TABLE cartItems (
      id TEXT PRIMARY KEY,
      title TEXT,
      price REAL,
      image TEXT,
      quantity INTEGER
    )
    ''');
  }

  // 1. إضافة أو تحديث منتج (Insert / Update)
  Future<void> insertOrUpdateCartItem(Map<String, dynamic> item) async {
    final db = await instance.database;
    await db.insert(
      'cartItems',
      item,
      conflictAlgorithm: ConflictAlgorithm.replace, // تحديث الكمية إذا كان موجوداً
    );
  }

  // 2. عرض المنتجات (Read)
  Future<List<Map<String, dynamic>>> getCartItems() async {
    final db = await instance.database;
    return await db.query('cartItems');
  }

  // 3. تحديث الكمية (Update)
  Future<void> updateQuantity(String id, int quantity) async {
    final db = await instance.database;
    await db.update(
      'cartItems',
      {'quantity': quantity},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // 4. حذف منتج (Delete)
  Future<void> deleteCartItem(String id) async {
    final db = await instance.database;
    await db.delete(
      'cartItems',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}