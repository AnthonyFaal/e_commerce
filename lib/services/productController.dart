import 'dart:convert';
import 'package:e_commerce_app/models/product/product.dart';
import 'package:http/http.dart' as http;

import '../models/product/category.dart';

Future<List<Product>> fetchProduct() async {
  try {
    final response = await http.get(
        Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);

      return jsonResponse.map<Product>((json) => Product.fromJson(json)).toList();
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception('Failed to load products');
    }
  } catch (e) {
    throw Exception("Error fetching Products: $e");
  }
}



Future<List<Category>> fetchCategories() async {
  try {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products/categories'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map<Category>((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  } catch (e) {
    throw Exception("Error fetching Categories: $e");
  }
}

