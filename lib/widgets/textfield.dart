import 'package:charge_mod/utils/colors.dart';
import 'package:flutter/material.dart';

typedef OnChangeCallBack = void Function(String)?;

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    this.onChanged,
    this.error,
  });

  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final OnChangeCallBack onChanged;
  final String? error;

  // final

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            labelText,
            style:
                Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 12),
          ),
        ),
        const SizedBox(height: 7),
        Container(
          height: 41,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.secondary.withOpacity(.5),
                blurRadius: 4,
              ),
            ],
          ),
          child: TextFormField(
            // controller: controller,
            onChanged: onChanged,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.black,
                  fontSize: 12,
                ),
            decoration: InputDecoration(
              fillColor: ColorTheme.commonWhite,
              filled: true,
              hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: const Color(0xff666766).withOpacity(.5),
                    fontSize: 12,
                  ),
              hintText: hintText,
              border: _borderTextfield(),
              enabledBorder: _borderTextfield(),
              focusedBorder: _borderTextfield(),
              contentPadding: const EdgeInsets.only(bottom: 8, left: 18),
            ),
          ),
        ),
        if (error != null) ...[
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              error ?? '',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 12, color: ColorTheme.color().errorColor),
            ),
          ),
        ]
      ],
    );
  }

  OutlineInputBorder _borderTextfield() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.transparent));
  }
}
