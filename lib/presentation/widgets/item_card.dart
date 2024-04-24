import 'package:flutter/material.dart';

import 'package:apna_bill_book/core/theme/app_pallete.dart';
import 'package:apna_bill_book/domain/entities/item.dart';

@immutable
class ItemCard extends StatelessWidget {
  final Item item;
  final Color color;
  final VoidCallback onPressed;
  const ItemCard({
    super.key,
    required this.item,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      margin: const EdgeInsets.all(16).copyWith(bottom: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                item.name,
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Chip(
                    label: Text(
                      "\$ ${item.price}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    backgroundColor: AppPallete.backgroundColor,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Chip(
                    label: Text(
                      item.category,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    backgroundColor: AppPallete.backgroundColor,
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.star,
              color: Colors.yellow,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}
