import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? width;
  final double? height;
  final double fontSize;
  final FontWeight fontWeight;
  final bool isOutlined;
  final IconData? icon;
  final EdgeInsetsGeometry? padding;

  const AppButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.width,
    this.height,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w500,
    this.isOutlined = false,
    this.icon,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultTextColor = textColor ?? AppColors.getTextPrimaryColor(isDark);
    final defaultBorderColor = borderColor ?? AppColors.primary;
    final defaultBackgroundColor = backgroundColor ?? AppColors.primary;

    return Container(
      width: width,
      height: height ?? 40,
      child: isOutlined
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: defaultBorderColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: padding ?? EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: _buildButtonContent(defaultTextColor),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: defaultBackgroundColor,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: padding ?? EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: _buildButtonContent(Colors.white),
            ),
    );
  }

  Widget _buildButtonContent(Color contentColor) {
    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: contentColor),
          SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: contentColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
          ),
        ],
      );
    }

    return Text(
      text,
      style: TextStyle(
        color: contentColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }

  // Factory constructors for common button types
  factory AppButton.primary({
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    double? width,
    double? height,
  }) {
    return AppButton(
      text: text,
      onPressed: onPressed,
      backgroundColor: AppColors.primary,
      icon: icon,
      width: width,
      height: height,
    );
  }

  factory AppButton.secondary({
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    double? width,
    double? height,
  }) {
    return AppButton(
      text: text,
      onPressed: onPressed,
      isOutlined: true,
      icon: icon,
      width: width,
      height: height,
    );
  }

  factory AppButton.danger({
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    double? width,
    double? height,
  }) {
    return AppButton(
      text: text,
      onPressed: onPressed,
      backgroundColor: AppColors.error,
      icon: icon,
      width: width,
      height: height,
    );
  }

  factory AppButton.success({
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    double? width,
    double? height,
  }) {
    return AppButton(
      text: text,
      onPressed: onPressed,
      backgroundColor: AppColors.success,
      icon: icon,
      width: width,
      height: height,
    );
  }

  factory AppButton.warning({
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    double? width,
    double? height,
  }) {
    return AppButton(
      text: text,
      onPressed: onPressed,
      backgroundColor: AppColors.warning,
      icon: icon,
      width: width,
      height: height,
    );
  }
}
