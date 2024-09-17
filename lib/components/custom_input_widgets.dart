import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TextInputField extends StatefulWidget {
  final bool enableCopyPaste;
  final bool enabled;
  final bool obscureText;
  final int? maxLength;
  final TextEditingController? controller;
  final bool hasLabel;
  final String? label;
  final TextStyle? textStyle;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;
  final String? value;
  final FocusNode? focusNode;
  final TextCapitalization textCapitalization;
  final GestureTapCallback? onTap;
  final List<String>? autofillHints;
  final VoidCallback? onClear;
  final Function(String val)? onChanged;
  final VoidCallback? onEditingComplete;
  final Widget? prefix;
  final Color? fillColor;
  final Color? borderColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsets? contentPadding;
  final double? height;
  final TextInputType textInputType;
  final bool? showCursor;
  final TextInputAction? textInputAction;
  final int? maxLines;

  const TextInputField(
      {super.key,
      this.enableCopyPaste = true,
      this.enabled = true,
      this.autofillHints,
      this.maxLength,
      this.controller,
      this.borderColor,
      this.fillColor,
      this.obscureText = false,
      this.height,
      this.inputFormatters,
      this.hasLabel = true,
      this.label,
      this.textStyle,
      this.errorText,
      this.value,
      this.focusNode,
      this.onTap,
      this.onClear,
      this.contentPadding,
      this.onChanged,
      this.onEditingComplete,
      this.prefix,
      this.prefixIcon,
      this.suffixIcon,
      this.maxLines = 1,
      this.textInputType = TextInputType.text,
      this.textInputAction = TextInputAction.next,
      this.textCapitalization = TextCapitalization.none,
      this.validator,
      this.showCursor});

  @override
  State<TextInputField> createState() => _TextInputState();
}

class _TextInputState extends State<TextInputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Theme(
          data: ThemeData(
              textSelectionTheme:  TextSelectionThemeData(
                cursorColor: Colors.blueAccent.shade700,
                selectionColor: Colors.blue.withOpacity(0.5),
                selectionHandleColor: Colors.blue,
              ),
              colorScheme: const ColorScheme.light(primary: Colors.blue)),
          child: SizedBox(
            height: widget.height,
            child: TextFormField(
              autofillHints: widget.autofillHints,
              obscureText: widget.obscureText,
              inputFormatters: widget.inputFormatters,
              onChanged: widget.onChanged,
              enableInteractiveSelection: widget.enableCopyPaste,
              enabled: widget.enabled,
              initialValue: widget.value,
              showCursor: widget.showCursor,
              onTap: widget.onTap,
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              maxLength: widget.maxLength,
              validator: widget.validator,
              onEditingComplete: widget.onEditingComplete,
              textCapitalization: widget.textCapitalization,
              textInputAction: widget.textInputAction,
              focusNode: widget.focusNode,
              controller: widget.controller,
              maxLines: widget.maxLines,
              keyboardType: widget.textInputType,
              style: widget.textStyle ??
                  Get.textTheme.bodyMedium!.copyWith(color: Colors.black87),
              decoration: InputDecoration(
                filled: true,
                prefix: widget.prefix,
                hintText: widget.label,
                hintStyle:
                    Get.textTheme.titleMedium!.copyWith(color: Colors.grey),
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.onClear == null
                    ? widget.suffixIcon
                    : InkWell(
                        radius: 0,
                        highlightColor: Colors.transparent,
                        child: const Icon(
                          CupertinoIcons.xmark,
                          color:Colors.grey,
                        ),
                        onTap: () {
                          widget.onChanged?.call('');
                          widget.onClear?.call();
                        },
                      ),
                counterText: '',
                contentPadding: widget.contentPadding ??
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: widget.enabled
                    ? widget.fillColor ?? Colors.grey.withOpacity(0.2)
                    : Colors.grey,
                labelText: widget.label,
                labelStyle:
                    Get.textTheme.titleMedium!.copyWith(color: Colors.grey),
                errorBorder: getBorder(borderColor: Colors.red),
                border: getBorder(borderColor: widget.borderColor),
                enabledBorder: getBorder(borderColor: widget.borderColor),
                focusedBorder: getBorder(borderColor: Colors.blueAccent.shade700),
                disabledBorder: getBorder(),
                focusedErrorBorder: getBorder(borderColor: Colors.red),
              ),
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder getBorder({Color? borderColor}) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: borderColor == null
            ? const BorderSide(
                style: BorderStyle.none,
              )
            : BorderSide(color: borderColor, width: 1.5));
  }
}
