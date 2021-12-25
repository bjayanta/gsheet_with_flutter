import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const SubmitButton({
    Key? key,
    required this.text,
    required this.onClicked
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(50),
        shape: StadiumBorder(),
      ),
      child: FittedBox(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white
        ),),
      ),
      onPressed: onClicked,
    );
  }
}
