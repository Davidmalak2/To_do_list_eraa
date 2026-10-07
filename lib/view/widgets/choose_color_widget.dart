import 'package:flutter/material.dart';

class ChooseColorWidget extends StatefulWidget {
  const ChooseColorWidget({
    super.key,
    required this.clickColor,
  });

  final ValueChanged<int> clickColor;

  @override
  State<ChooseColorWidget> createState() => _ChooseColorWidgetState();
}

class _ChooseColorWidgetState extends State<ChooseColorWidget> {
  final List<int> colorsHex = [0xff2196F3, 0xff4CAF50, 0xffFF9800, 0xff9C27B0];
  int selectedColor = 0xff2196F3;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Choose Color",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: colorsHex.map((colorHex) {
            final isSelected = selectedColor == colorHex;
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedColor = colorHex;
                  });
                  widget.clickColor(selectedColor);
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(colorHex),
                    shape: BoxShape.circle,
                    border: isSelected
                        ? Border.all(color: Colors.black, width: 2)
                        : null,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}