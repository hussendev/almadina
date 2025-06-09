import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app/theme.dart';

class AuthTextField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool readOnly;
  final VoidCallback? onTap;
  final int? maxLength;
  final int maxLines;
  final bool enabled;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final String? backgroundImage; // Path to background image asset

  const AuthTextField({
    Key? key,
    required this.label,
    required this.hint,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    this.onTap,
    this.maxLength,
    this.maxLines = 1,
    this.enabled = true,
    this.focusNode,
    this.onChanged,
    this.backgroundImage, // Path to background image
  }) : super(key: key);

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(12),
            // Use background image if provided
            image: widget.backgroundImage != null
                ? DecorationImage(
              image: AssetImage(widget.backgroundImage!),
              fit: BoxFit.cover,
              // Add overlay for text readability

            )
                : null,
            // Fallback color if no image

            // Subtle shadow for depth

          ),
          child: TextFormField(
            controller: widget.controller,
            obscureText: _obscureText,
            keyboardType: widget.keyboardType,
            validator: widget.validator,
            inputFormatters: widget.inputFormatters,
            readOnly: widget.readOnly,
            onTap: widget.onTap,
            maxLength: widget.maxLength,
            maxLines: widget.maxLines,
            enabled: widget.enabled,
            focusNode: widget.focusNode,
            onChanged: widget.onChanged,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF5D4E37), // Darker brown text
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: TextStyle(
                color: const Color(0xFF8B7355).withOpacity(0.8),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.obscureText
                  ? IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: const Color(0xFF8B7355),
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
                  : widget.suffixIcon,
              // Remove all borders to use container decoration
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              // Transparent background
              fillColor: Colors.transparent,
              filled: true,
              // contentPadding: const EdgeInsets.symmetric(
              //   horizontal: 20,
              //   vertical: 18,
              // ),
            ),
          ),
        ),
      ],
    );
  }
}