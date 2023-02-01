import 'package:flutter/material.dart';

const contentMaxWidth = BoxConstraints(maxWidth: 400);
const contentPadding = EdgeInsets.symmetric(horizontal: 10);

class ColoredSquare extends StatelessWidget {
  const ColoredSquare(this.color, this.description, {super.key});

  final Color? color;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            color: color,
          ),
          const SizedBox(width: 10),
          Flexible(child: Text(description)),
        ],
      ),
    );
  }
}
