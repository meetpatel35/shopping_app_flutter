import 'package:flutter/material.dart';
import 'package:shopping_app/global_variables.dart';
import 'package:shopping_app/product_card.dart';
import 'package:shopping_app/product_details.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {

  final List<String> filter = const ["All", "Adidas", "Nike", "Bata"];
  late String selectedfilter;
  late List<Map<String,dynamic>> toShow;
  void updateToShow() {
  if (selectedfilter == "All") {
    // Show all products when "All" is selected
    toShow = products;
  } else {
    // Filter products where the 'title' includes the selected filter word
    toShow = products
        .where((product) =>
            product['title'].toString().toLowerCase().contains(selectedfilter.toLowerCase()))
        .toList();
  }
}
  int currentPage = 0;

  @override
  void initState() {
    selectedfilter = filter[0];
    toShow = products;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
        borderSide: BorderSide(color: const Color.fromARGB(162, 177, 176, 176)),
        borderRadius: BorderRadius.horizontal(left: Radius.circular(50)));
    return SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: const Text(
                    "Shoe\nCollection",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 35),
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        border: border,
                        enabledBorder: border,
                        focusedBorder: border),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 80,
              child: ListView.builder(
                itemCount: filter.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedfilter = filter[index];
                          updateToShow();
                        });
                      },
                      child: Chip(
                        side: const BorderSide(
                          color: Color.fromARGB(82, 228, 227, 227),
                        ),
                        backgroundColor: selectedfilter == filter[index]
                            ? Theme.of(context).colorScheme.primary
                            : const Color.fromRGBO(245, 247, 249, 1),
                        label: Text(filter[index]),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                        labelStyle: TextStyle(fontSize: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              50), // Makes the chip rounded
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: toShow.length,
                itemBuilder: (context, index) {
                  final product = toShow[index];

                  return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return ProductDetails(product: product.cast<String, Object>());
                        }));
                      },
                  
                      child: ProductCard(
                        title: product['title'] as String,
                        price: product['price'] as double,
                        image: product['imageUrl'] as String,
                        bgcolor: index.isEven
                            ? const Color.fromRGBO(216, 240, 253, 1)
                            : const Color.fromRGBO(245, 247, 249, 1),
                      ));
                },
              ),
              // child: ListView.builder(
              //   itemCount: products.length,
              //   itemBuilder: (context, index) {
              //     final product = products[index];

              //     return GestureDetector(
              //         onTap: () {
              //           Navigator.of(context).push(MaterialPageRoute(builder: (context){
              //             return ProductDetails(product: product);
              //           }));
              //         },
                  
              //         child: ProductCard(
              //           title: product['title'] as String,
              //           price: product['price'] as double,
              //           image: product['imageUrl'] as String,
              //           bgcolor: index.isEven
              //               ? const Color.fromRGBO(216, 240, 253, 1)
              //               : const Color.fromRGBO(245, 247, 249, 1),
              //         ));
              //   },
              // ),
            ),
          ],
        ),
      );
  }
}