import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieLoader extends StatelessWidget {
  final String image;
  const LottieLoader({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      image,
      width: 1500.0,
      height: 1200.0,
    );
  }
}
