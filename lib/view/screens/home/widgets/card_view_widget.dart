// here we customized the card that have the category data ...

import 'package:flutter/material.dart';
import 'package:tasawak/model/categories/base_model.dart';
import 'package:tasawak/view_model/utils/app_colors.dart';

class CardViewWidget extends StatelessWidget {
  const CardViewWidget({
    super.key,
    required this.size,
    required this.data,
    required this.theme,
  });

  final Size size;
  final BaseModel data;
  final TextTheme theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Hero(
            tag: data.id,
            child: Container(
              width: size.width * 0.6, //0.6
              height: size.height * 0.24, //27
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(image: AssetImage(data.imageUrl), fit: BoxFit.cover),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(-4, 4),
                    color: AppColors.black,
                    blurRadius: 5,
                  ),
                  BoxShadow(
                    offset: Offset(4, -4),
                    color: AppColors.gray,
                    blurRadius: 5,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10), //20
            child: Text(
              data.name,
              style: theme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          RichText(
            text: TextSpan(
              text: ("\$"),
              style: theme.titleLarge,
              children: [
                TextSpan(
                  text: data.price.toString(),
                  style:
                      theme.titleLarge?.copyWith(color: AppColors.primaryColor, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
