import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/cart_provider.dart';

class ProductDetails extends StatefulWidget {
  final Map<String, Object> product;
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int selectSize = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Details"),
      ),
      body: Column(
        children: [
          Text(
            widget.product['title'] as String,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.asset(widget.product['imageUrl'] as String),
          ),
          const Spacer(
            flex: 2,
          ),
          Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(46, 193, 193, 193),
                  borderRadius: BorderRadius.circular(40)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '\$${widget.product['price']}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 62,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: (widget.product['sizes'] as List<int>).length,
                      itemBuilder: (context, index) {
                        final size =
                            (widget.product['sizes'] as List<int>)[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectSize = size;
                              });
                            },
                            child: Chip(
                              label: Text(
                                size.toString(),
                              ),
                              backgroundColor: selectSize == size
                                  ? Theme.of(context).colorScheme.primary
                                  : Color.fromRGBO(245, 247, 249, 1),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: ElevatedButton(
                      onPressed: () {
                        if (selectSize != 0) {
                          Provider.of<CartProvider>(context, listen: false)
                              .addProduct({
                            'id': widget.product['id'],
                            'title': widget.product['title'],
                            'price': widget.product['price'],
                            'imageUrl': widget.product['imageUrl'],
                            'company': widget.product['company'],
                            'size': selectSize,
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${widget.product['title']} added to cart')));
                        } else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select a size first')));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary),
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
