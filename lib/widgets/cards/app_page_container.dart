import 'package:flutter/material.dart';

class AppPageContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final double marginTop;
  final double borderRadius;

  const AppPageContainer({
    Key? key,
    required this.child,
    this.height,
    this.marginTop = 20.0,
    this.borderRadius = 30.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? MediaQuery.of(context).size.height,
      margin: EdgeInsets.only(top: marginTop),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(borderRadius)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: child,
    );
  }
}
