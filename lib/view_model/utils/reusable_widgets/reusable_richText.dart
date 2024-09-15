import 'package:flutter/material.dart';

class ReusableRichText extends StatelessWidget {
  const ReusableRichText({
    super.key,
    required this.text,
    this.style1,
     this.style2,
  });

  final String text;
  final TextStyle? style1;
  final TextStyle? style2;


  @override
  Widget build(BuildContext context) {

    return RichText(
      text: TextSpan(
        text: ("\$"),
        style: style1,
        children: [
          TextSpan(
            text: text,
            style: style2,
          )
        ],
      ),
    );
  }
}
