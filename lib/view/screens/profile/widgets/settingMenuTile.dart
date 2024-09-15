import 'package:flutter/material.dart';

import '../../../../view_model/utils/app_colors.dart';

class SettingMenuTileWidget extends StatelessWidget {
  const SettingMenuTileWidget(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.leadingIcon,
      this.trailing,
      this.onTap});

  final String title;
  final String  subtitle;
  final IconData? leadingIcon;
  final Widget? trailing;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context).textTheme;
    return ListTile(
      title: Text(
        title,
        style: theme.titleMedium?.copyWith(color: AppColors.offwhite),
      ),
      subtitle: Text(
        subtitle,
        style: theme.titleSmall?.copyWith(color: AppColors.offwhite),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          leadingIcon,
          color: AppColors.primaryColor,
          size: 35,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
