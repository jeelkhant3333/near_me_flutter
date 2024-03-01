import 'package:flutter/cupertino.dart';

class CityBanner extends StatelessWidget {
  const CityBanner({super.key, required this.image, required this.borderRadius});
  final Image image;
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: image
      ),
    );}
}