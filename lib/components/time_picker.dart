import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
