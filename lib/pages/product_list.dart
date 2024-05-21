import 'package:flutter/material.dart';
import 'package:shoes_shop/utils/mocks_data.dart';
import 'package:shoes_shop/widgets/product_card.dart';
import 'package:shoes_shop/pages/product_details_page.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
    final List<String> filters = [
    "All",
    "Addidas",
    "Nike",
    "Bata",
  ];

  late String selectedFilter;
 

    @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }


  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(235, 238, 238, 1),
      ),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(50),
      ),
    );
    return Scaffold(body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text("Shoes\nCollection",
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: border,
                      enabledBorder: border,
                      focusedBorder: border,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 130,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  itemBuilder: (context, index) {
                    final filter = filters[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFilter = filter;
                          });
                        },
                        child: Chip(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          side: const BorderSide(
                            color: Color.fromARGB(255, 241, 243, 245),
                          ),
                          label: Text(
                            filter,
                            style: const TextStyle(fontSize: 16),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 13,
                          ),
                          backgroundColor: selectedFilter == filter
                              ? Theme.of(context).colorScheme.primary
                              : const Color.fromARGB(255, 241, 243, 245),
                        ),
                      ),
                    );
                  }),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return ProductDetailPage(product: product);
                          },
                        ),
                      );
                    },
                    child: ProductCard(
                      index: index,
                      title: product["title"],
                      price: product["price"],
                      image: product["imageUrl"],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),);
  }
}