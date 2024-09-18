import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
  final bool isReadOnly;

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
      this.showCursor,
      this.isReadOnly = false});

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
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: Colors.blueAccent.shade700,
                selectionColor: Colors.blue.withOpacity(0.5),
                selectionHandleColor: Colors.blue,
              ),
              colorScheme: const ColorScheme.light(primary: Colors.blue)),
          child: SizedBox(
            height: widget.height,
            child: TextFormField(
              readOnly: widget.isReadOnly,
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
                  Get.textTheme.bodyMedium,
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
                          color: Colors.grey,
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
                focusedBorder:
                    getBorder(borderColor: Colors.blueAccent.shade700),
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

class TimePickerWidget extends StatefulWidget {
  final bool enabled;
  final Color? fillColor;
  final double height;
  final String label;
  final FormFieldValidator<String>? validator;
  final String? errorText;
  final String? value;
  final Function(String val)? onChanged;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String timeFormat;

  const TimePickerWidget({
    super.key,
    this.enabled = true,
    this.fillColor,
    this.label = 'Time',
    this.errorText,
    this.height = 64,
    this.value,
    this.onChanged,
    this.prefix,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.timeFormat = 'HH:mm', // Default time format
  });

  @override
  State<TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  bool showError = false;
  String? validatorString;
  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: widget.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          height: widget.height,
          margin: EdgeInsets.only(bottom: validatorString == null ? 16 : 0),
          padding: const EdgeInsets.fromLTRB(16, 0, 12, 0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(18),
            ),
            color: widget.enabled
                ? widget.fillColor
                : Colors.grey.withOpacity(0.5),
            border: Border.all(
                color: widget.errorText != null || showError
                    ? Colors.red
                    : widget.value == null
                        ? Colors.grey.withOpacity(0.6)
                        : Colors.blue,
                width: 1.5),
          ),
          child: TextFormField(
            onTapOutside: (event) {
              Focus.of(context).unfocus();
            },cursorColor: Colors.transparent,
            controller: controller,
            enableInteractiveSelection: false,
            enabled: widget.enabled,
            onTap: widget.enabled ? onTap : null,
            keyboardType: TextInputType.none,
            showCursor: true,
            readOnly: true,
            validator: validatorLocal,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.grey),
            decoration: InputDecoration(
              prefix: widget.prefix,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: widget.prefixIcon ??
                    const Icon(
                      CupertinoIcons.time_solid,
                      color: Colors.blue,
                    ),
              ),
              suffixIcon: widget.suffixIcon,
              errorText: '',
              errorStyle: const TextStyle(fontSize: 0),
              floatingLabelStyle: TextStyle(color: Colors.grey.shade500),
              counterText: '',
              fillColor: widget.fillColor,
              label: Text(
                widget.label,
              ),
              labelStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  height: 1.3,
                  color: widget.errorText != null || showError
                      ? Colors.red
                      : Colors.grey.shade700),
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
            ),
          ),
        ),
        if (widget.errorText != null || showError)
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 12),
            child: Text(
              validatorString ?? '',
              style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 1.5),
            ),
          )
      ],
    );
  }

  // Method to handle tapping and showing time picker
  void onTap() async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: Theme(
            data: Theme.of(context).copyWith(
              timePickerTheme: const TimePickerThemeData(),
            ),
            child: child!,
          ),
        );
      },
    );

    if (time != null) {
      final selectedTime = DateFormat(widget.timeFormat).format(
        DateTime(0, 0, 0, time.hour, time.minute),
      );
      controller.text = selectedTime; // Update the text field
      widget.onChanged?.call(selectedTime); // Notify parent of change
    }
  }

  String? validatorLocal(String? value) {
    validatorString = widget.validator?.call(value);
    if (validatorString != null) {
      setState(() {
        showError = true;
      });
      return '';
    } else {
      setState(() {
        showError = false;
      });
    }
    return null;
  }
}
