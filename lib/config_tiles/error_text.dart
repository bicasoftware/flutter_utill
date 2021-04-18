import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  const ErrorText(
    this.errorText, {
    this.textAlign,
    Key? key,
  }) : super(key: key);
  final String errorText;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      errorText,
      style: Theme.of(context).textTheme.caption?.copyWith(color: Colors.red),
      textAlign: textAlign,
    );
  }
}
