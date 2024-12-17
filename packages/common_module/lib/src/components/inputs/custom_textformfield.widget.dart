import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormFieldComponent extends StatelessWidget {
  final String label;
  final bool enabled;
  final bool readOnly;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextFormFieldComponent({
    super.key,
    this.onTap,
    this.validator,
    this.onChanged,
    this.suffixIcon,
    this.controller,
    this.keyboardType,
    this.enabled = true,
    required this.label,
    this.inputFormatters,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        enabled: enabled,
        label: Text(label),
        suffixIcon: suffixIcon,
      ),
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onTap: onTap,
      readOnly: readOnly,
      validator: validator,
    );
  }
}
