import 'package:charge_mod/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.buttonText,
    this.onTap,
    this.textStyle,
    this.isLoading = false,
    this.icon,
  });
  final String buttonText;
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final bool isLoading;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: isLoading
          ? SizedBox(
              height: 10,
              width: 10,
              child: CircularProgressIndicator(
                color: ColorTheme.commonWhite,
              ),
            )
          : icon == null
              ? _buildText(context)
              : _buildIconAndText(context),
    );
  }

  Row _buildIconAndText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 16,
          width: 16,
          child: SvgPicture.asset(icon!),
        ),
        const SizedBox(width: 6),
        _buildText(context),
      ],
    );
  }

  Text _buildText(BuildContext context) {
    return Text(
      buttonText,
      style: textStyle ??
          Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: ColorTheme.commonWhite),
    );
  }
}
