import 'package:apna_bill_book/domain/entities/item.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final Color color;
  const ItemCard({
    super.key,
    required this.item,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.all(16).copyWith(bottom: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            item.name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
