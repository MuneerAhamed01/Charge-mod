import 'package:charge_mod/repositories/auth_repostiory.dart';
import 'package:charge_mod/utils/assets.dart';
import 'package:charge_mod/utils/colors.dart';
import 'package:charge_mod/utils/snackbar.dart';
import 'package:charge_mod/views/authentication/bloc/auth_bloc/auth_bloc.dart';
import 'package:charge_mod/views/authentication/bloc/mobile_number_bloc/mobile_number_bloc.dart';
import 'package:charge_mod/views/authentication/bloc/recent_otp_bloc/resend_otp_bloc.dart';
import 'package:charge_mod/views/authentication/pages/otp_entry_page.dart';
import 'package:charge_mod/widgets/primary_button.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginEntry extends StatelessWidget {
  const LoginEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthBlocState>(
        listener: _authListener,
        builder: (context, authState) {
          return BlocBuilder<MobileNumberBloc, MobileNumberState>(
            builder: (context, numberState) {
              return Column(
                children: [
                  const SizedBox(height: 83),
                  Center(
                    child: Text(
                      'ChargeMOD',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.w400, height: 1),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Let’s Start',
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(fontSize: 40),
                  ),
                  Text(
                    'From Login',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontSize: 40,
                        color: ColorTheme.color().primaryColor,
                        height: 1),
                  ),
                  const SizedBox(height: 41),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 33),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildCountryPicker(context),
                        const SizedBox(width: 7),
                        //Width is based on the [country picker] [padding] [spacer]
                        SizedBox(
                          height: 40,
                          width: MediaQuery.sizeOf(context).width - 66 - 63 - 7,
                          child: TextFormField(
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.black),
                            readOnly: authState is AuthLoadingState,
                            onChanged: (value) {
                              context
                                  .read<MobileNumberBloc>()
                                  .add(ChangeMobileNumberEvent(value));
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: const Color(0xff534B4A),
                                  ),
                              hintText: 'Enter phone number',
                              filled: true,
                              fillColor: ColorTheme.commonWhite,
                              border: _borderTextfield(),
                              enabledBorder: _borderTextfield(),
                              focusedBorder: _borderTextfield(),
                              contentPadding:
                                  const EdgeInsets.only(bottom: 8, left: 10),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(
                                    top: 7, bottom: 7, right: 12, left: 10),
                                child: SvgPicture.asset(SvgAssets.telePhone),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (numberState.validationError != null) ...[
                    const SizedBox(height: 6),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 33),
                        child: Text(
                          numberState.validationError!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: ColorTheme.color().errorColor),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 11),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 33),
                    child: SizedBox(
                      width: double.infinity,
                      height: 38,
                      child: PrimaryButton(
                        isLoading: authState is AuthLoadingState,
                        buttonText: 'Sent OTP',
                        onTap: () {
                          if (authState is AuthLoadingState) return;
                          if (numberState.mobileNumber == null) {
                            return;
                          }
                          context
                              .read<AuthBloc>()
                              .add(OnSendOtpEvent(numberState.mobileNumber!));
                        },
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  )
                ],
              );
            },
          );
        },
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'By Continuing you agree to our\n',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(height: 1.4),
                    children: [
                      TextSpan(
                          text: 'Terms & Condition',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  color: ColorTheme.color().primaryColor),
                          recognizer: TapGestureRecognizer()..onTap = () {}),
                      TextSpan(
                          text: ' and ',
                          style: Theme.of(context).textTheme.bodyLarge),
                      TextSpan(
                        text: 'Privacy and Policy',
                        recognizer: TapGestureRecognizer()..onTap = () {},
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: ColorTheme.color().primaryColor),
                      )
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder _borderTextfield() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: ColorTheme.textfieldBorder,
        ));
  }

  CountryCodePicker _buildCountryPicker(BuildContext context) {
    return CountryCodePicker(
      onChanged: (country) {},
      dialogTextStyle: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(color: ColorTheme.color(true).primaryColorLight),
      initialSelection: 'IN',
      favorite: const ['+91', 'IN'],
      showCountryOnly: false,
      builder: (country) {
        return Container(
          height: 40,
          width: 63,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ColorTheme.commonWhite,
            border: Border.all(
              color: ColorTheme.textfieldBorder,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 22,
                width: 32,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset(
                    country!.flagUri!,
                    package: 'country_code_picker',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 7),
              SvgPicture.asset(SvgAssets.downArrow)
            ],
          ),
        );
      },
      showOnlyCountryWhenClosed: false,
      alignLeft: false,
    );
  }

  void _authListener(BuildContext context, AuthBlocState authState) {
    if (authState is AuthErrorState) {
      if (authState.isValidationError) {
        context
            .read<MobileNumberBloc>()
            .add(CustomValidationErrorEvent(authState.errorMessage));
      } else {
        showCustomSnackbar(context, authState.errorMessage.toString());
      }
    }

    if (authState is AuthSuccessState) {
      final authRepo = context.read<AuthRepository>();

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) {
            return BlocProvider(
              create: (_) => ResendOtpBloc(authRepo),
              child: BlocProvider<AuthBloc>.value(
                value: BlocProvider.of<AuthBloc>(context),
                child: const OtpEntryScreen(),
              ),
            );
          },
        ),
      );
    }
  }
}
