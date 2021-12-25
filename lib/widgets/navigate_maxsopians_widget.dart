import 'package:flutter/material.dart';

class NavigateMaxsopiansWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClickedPrevious;
  final VoidCallback onClickedNext;

  const NavigateMaxsopiansWidget({
    Key? key,
    required this.text,
    required this.onClickedPrevious,
    required this.onClickedNext
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: onClickedPrevious,
            iconSize: 48,
            icon: Icon(Icons.navigate_before),
        ),
        Text(text, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
        IconButton(
          onPressed: onClickedNext,
          iconSize: 48,
          icon: Icon(Icons.navigate_next),
        ),
      ],
    );
  }
}
