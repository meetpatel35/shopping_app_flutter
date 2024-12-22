import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final double price;
  final Color bgcolor;
  final String image;
  const ProductCard(
      {super.key,
      required this.title,
      required this.price,
      required this.image,
      required this.bgcolor});
  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      color: bgcolor
      ),

      margin: const EdgeInsets.all(14),
      padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 12),
      child: Column(
        
        
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '\$$price',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(
            height: 5,
          ),
          Center(
            child: Image.asset(
              image,
              height: 175,
            ),
          )
        ],
      ),
    );
  }
}
