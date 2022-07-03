import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry margin;
  const LoadingWidget({
    Key? key,
    required this.context,
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.margin,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return  Container(
        margin: margin,
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Colors.grey,
        ),
      );
   
  }
}
