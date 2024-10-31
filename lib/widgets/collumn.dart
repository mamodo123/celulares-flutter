import 'package:flutter/material.dart';

class MyAppColumn extends StatelessWidget {
  final List<Widget> children;
  final double space;
  final MainAxisAlignment mainAxisAlignment;

  const MyAppColumn(
      {super.key,
      required this.children,
      this.space = 10,
      this.mainAxisAlignment = MainAxisAlignment.start});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      children: List<Widget>.generate(
          (children.length * 2) - 1,
          (index) => index % 2 == 0
              ? children[index ~/ 2]
              : SizedBox(
                  height: space,
                )),
    );
  }
}
