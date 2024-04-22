import 'package:apna_bill_book/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(
          strokeWidth: 1.5,
          color: AppPallete.whiteColor,
        ),
      ),
    );
  }
}
