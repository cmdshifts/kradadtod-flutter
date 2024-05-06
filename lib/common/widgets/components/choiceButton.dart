import 'package:flutter/material.dart';

class ChoiceButton extends StatelessWidget {
  const ChoiceButton(
      {super.key, required this.text, required this.selected, this.onSelected});

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: SizedBox(
        width: 200.0,
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
      selected: selected,
      onSelected: onSelected,
      labelStyle: TextStyle(color: selected ? Colors.white : null),
      showCheckmark: false,
    );
  }
}
