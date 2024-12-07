import 'package:flutter/material.dart';

class MImageContainer extends StatelessWidget {
  MImageContainer({super.key, required this.image, required this.onTap});
  final ImageProvider<Object> image;
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(image: image)),
          height: 80,
          width: 80,
        ),
      ),
    );
  }
}
