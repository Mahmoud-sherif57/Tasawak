import 'package:flutter/material.dart';
import 'package:tasawak/view_model/utils/reusable_widgets/reusable_rich_text.dart';

import '../app_colors.dart';

class ReusableRowForCart extends StatelessWidget {
  const ReusableRowForCart(
      {super.key, required this.price, required this.text});
  final num price;
  final String text;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: theme.titleLarge?.copyWith(color: AppColors.olive),
          ),
          ReusableRichText(
            text: price.toString(),
            style1: theme.headlineMedium?.copyWith(
              color: AppColors.olive2,
            ),
            style2: theme.headlineMedium?.copyWith(
                color: AppColors.orange, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
