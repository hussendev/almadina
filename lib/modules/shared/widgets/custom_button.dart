import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/theme.dart';
import '../../../core/constants/assets_path.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final double? width;
  final double fontSize;
  final double? height;
  final bool isDisabled;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.fontSize ,
    this.isLoading = false,
    this.width,
    this.height = 48.0,
    this.isDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled || isLoading ? null : onPressed,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Image.asset(AssetsPath.containerBackground),
          isLoading
              ? const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              color: AppTheme.whiteColor,
              strokeWidth: 2,
            ),
          )
              : Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontFamily: GoogleFonts.cairo().fontFamily,
            ),
          )
        ],
      ),
    );
  }
}