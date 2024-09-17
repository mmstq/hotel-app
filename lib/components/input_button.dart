import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Color labelColor;
  final bool isLoading;
  final Color? backgroundColor;
  final double elevation;
  final double height;
  final Widget? icon;
  final FontWeight fontWeight;

  const InputButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.height = 50,
    this.icon,
    this.fontWeight = FontWeight.w500,
    this.elevation = 2,
    this.labelColor = Colors.white,
    this.isLoading = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(elevation),
          backgroundColor:
          WidgetStateProperty.all(backgroundColor ?? Colors.blue),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          splashFactory: NoSplash.splashFactory,
          overlayColor: const WidgetStatePropertyAll(
            Colors.transparent,
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeCap: StrokeCap.round,
            strokeWidth: 2,
          ),
        )
            : Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null) ...[icon!, const SizedBox(width: 8)],
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: labelColor,
                fontWeight: fontWeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class CustomIconButton extends StatelessWidget {
  final String title;
  final Widget icon;
  final Function onTap;

  const CustomIconButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
      decoration:  BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade500)),
      ),
      child: ElevatedButton(
        onPressed: () => onTap(),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(327, 48),
          elevation: 0,
          shadowColor: Colors.transparent,
          overlayColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: Colors.blue,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 6),
            Text(
              title,
              style: Get.theme.textTheme.bodyLarge!.copyWith(
                color: Colors.white,
                height: 3.0,
                letterSpacing: 0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

