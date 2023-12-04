import 'package:cc206_clinic_management_website_patients/theme/color_theme.dart';
import 'package:flutter/material.dart';

class SignUpFormInputWidget extends StatefulWidget {
  final String label;
  final String? hintText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final AutovalidateMode? autovalidateMode;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final void Function()? onTap;
  final bool readOnly;
  bool obscureText;
  SignUpFormInputWidget({
    this.obscureText = false,
    this.label = '',
    this.hintText,
    this.validator,
    this.onChanged,
    this.autovalidateMode,
    this.prefixIcon,
    this.controller,
    this.onTap,
    this.readOnly = false,
    super.key,
  });

  @override
  State<SignUpFormInputWidget> createState() => _SignUpFormInputWidgetState();
}

class _SignUpFormInputWidgetState extends State<SignUpFormInputWidget> {
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          textAlign: TextAlign.start,
          style: TextStyle(
            color:
                !_hasFocus ? colorScheme1.onBackground : colorScheme1.primary,
            fontSize: 14.0,
            fontWeight: !_hasFocus ? FontWeight.w500 : FontWeight.w600,
          ),
          overflow: TextOverflow.fade,
        ),
        Material(
          color: Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          elevation: 10.0,
          child: TextFormField(
            obscureText: widget.obscureText,
            readOnly: widget.readOnly,
            onTap: widget.onTap,
            focusNode: _focusNode,
            controller: widget.controller,
            validator: widget.validator,
            autovalidateMode: widget.autovalidateMode,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withOpacity(0.95),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: colorScheme1.primary),
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              prefixIcon: widget.prefixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 10.0),
                      child:
                          Icon(widget.prefixIcon, color: colorScheme1.primary),
                    )
                  : null,
              hintText: widget.hintText,
            ),
          ),
        ),
      ],
    );
  }
}
