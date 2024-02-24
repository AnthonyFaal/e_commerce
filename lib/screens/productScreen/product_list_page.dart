import 'package:e_commerce_app/screens/productScreen/product_details_page.dart';
import 'package:e_commerce_app/models/product/product.dart';
import 'package:flutter/material.dart';
import '../../services/productController.dart';
import '../../models/product/category.dart';



class ProductListPage extends StatefulWidget {

   
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late Future<List<Product>> products;
  late Future<List<Category>> categories;
  String selectedCategory = ''; // Track the selected category

  @override
  void initState() {
    super.initState();
    products = fetchProduct();
    categories = fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      drawer: Drawer(
        child: FutureBuilder<List<Category>>(
          future: categories,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<Category> categoryList = snapshot.data!;

              return ListView.builder(
                itemCount: categoryList.length,
                itemBuilder: (context, index) {
                  Category category = categoryList[index];

                  return ListTile(
                    title: Text(category.name),
                    onTap: () {
                      setState(() {
                        selectedCategory = category.name;
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              );
            }
          },
        ),
      ),
      body: FutureBuilder<List<Product>>(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Product> productList = snapshot.data!;

            // Filter products based on the selected category
            List<Product> filteredProducts = selectedCategory.isNotEmpty
                ? productList.where((product) => product.category == selectedCategory).toList()
                : productList;

            return ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                Product product = filteredProducts[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(product: product),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                    child: Column(
                      children: [
                        Image.network(
                          product.image,
                          width: MediaQuery.of(context).size.width * 7 / 8,
                          height: MediaQuery.of(context).size.width * 7 / 8,
                          fit: BoxFit.fill,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(product.title),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                              child: Text(
                                '\$${product.price.toStringAsFixed(2)} | Rating: ${product.rate}',
                                style: TextStyle(
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}


/*import 'package:e_commerce_app/screens/productScreen/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/models/product/product.dart';
import '../../models/product/category.dart';
import '../../services/auth.dart';
import '../../services/productController.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late Future<List<Product>> products;
  late Future<List<Category>> categories;
  String selectedCategory = ''; // Track the selected category
  AuthService auth = AuthService();

  @override
  void initState() {
    super.initState();
    loadApiData();
  }

  Future<void> loadApiData() async {
    products = fetchProduct();
    categories = fetchCategories();
    await Future.wait([products, categories]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListTile(
          title: const Text('Logout'),
          onTap: () {
            auth.logout();
            Navigator.pop(context); // Close the drawer
          },
        ),
      ),
      body: FutureBuilder(
        future: Future.wait([categories, products]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Category> categoryList = snapshot.data![0];
            List<Product> productList = snapshot.data![1];

            // Your existing code for building the UI
            return Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: categoryList.map((category) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = category.name;
                            });
                          },
                          child: Card(
                            elevation: 2,
                             shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0), // Adjust the value for more or less rounding
                                  ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(category.name,
                              style: TextStyle(
                                fontSize: 17
                              ),),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                      Product product = productList[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailPage(product: product),
                            ),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                          child: Column(
                            children: [
                              Image.network(
                                product.image,
                                width: MediaQuery.of(context).size.width * 7 / 8,
                                height: MediaQuery.of(context).size.width * 7 / 8,
                                fit: BoxFit.fill,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(product.title),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                                    child: Text(
                                      '\$${product.price.toStringAsFixed(2)} | Rating: ${product.rate}',
                                      style: const TextStyle(
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}*/