import 'package:charge_mod/repositories/auth_repostiory.dart';
import 'package:charge_mod/repositories/user_repostiroy.dart';
import 'package:charge_mod/utils/assets.dart';
import 'package:charge_mod/utils/snackbar.dart';
import 'package:charge_mod/views/authentication/bloc/auth_bloc/auth_bloc.dart';
import 'package:charge_mod/views/authentication/bloc/recent_otp_bloc/resend_otp_bloc.dart';
import 'package:charge_mod/views/edit_pofile/bloc/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:charge_mod/views/edit_pofile/bloc/form_field_bloc/form_field_bloc.dart';
import 'package:charge_mod/views/main_screen/bloc/bottom_nav_bloc/bottom_nav_bloc.dart';
import 'package:charge_mod/views/main_screen/bloc/profile_bloc/profile_bloc_bloc.dart';
import 'package:charge_mod/views/main_screen/main_screeen.dart';
import 'package:charge_mod/widgets/custom_otp_field.dart';
import 'package:charge_mod/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/colors.dart';
import '../../edit_pofile/edit_profil_page.dart';

class OtpEntryScreen extends StatefulWidget {
  const OtpEntryScreen({super.key});

  @override
  State<OtpEntryScreen> createState() => _OtpEntryScreenState();
}

class _OtpEntryScreenState extends State<OtpEntryScreen> {
  String? otp;
  @override
  Widget build(BuildContext context) {
    final mobileNumber = context.read<AuthBloc>().state.mobileNumber;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 52,
        leading: Padding(
          padding: const EdgeInsets.only(left: 32),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SvgPicture.asset(
              SvgAssets.backButton,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.secondary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        title: Text(
          'Verification',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 25),
          Center(
            child: Text(
              'We’ve send you the verification\ncode on +91 $mobileNumber',
              style:
                  Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 55,
            child: OtpTextField(
              numberOfFields: 4,
              fieldWidth: 55,
              contentPadding: const EdgeInsets.fromLTRB(12, 15, 12, 15),
              borderWidth: 1,
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              filled: true,
              borderColor: ColorTheme.textfieldBorder,
              focusedBorderColor: ColorTheme.textfieldBorderFocused,
              borderRadius: BorderRadius.circular(12),
              showFieldAsBox: true,
              onCodeChanged: (String code) {},
              autoFocus: true,
              textStyle: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(color: ColorTheme.textfieldBorderFocused),
              onSubmit: (code) {
                otp = code;
              },
            ),
          ),
          const SizedBox(height: 14),
          _buildResendOtp(mobileNumber)
        ],
      ),
      bottomSheet: BlocConsumer<AuthBloc, AuthBlocState>(
        listener: _authListener,
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45)
                    .copyWith(bottom: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 43,
                  child: PrimaryButton(
                    isLoading: state is AuthLoadingState,
                    buttonText: 'continue'.toUpperCase(),
                    onTap: () {
                      if (otp == null) return;
                      context.read<AuthBloc>().add(OnSubmitOtpEvent(otp!));
                    },
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildResendOtp(String? mobileNumber) {
    return BlocBuilder<ResendOtpBloc, ResendOtpState>(
      builder: (context, state) {
        if (state is ResendOtpCountDownState) {
          return RichText(
            text: TextSpan(
              text: 'Re-send code in',
              style: Theme.of(context).textTheme.labelMedium,
              children: [
                TextSpan(
                  text: ' 0:${state.currentStateTick}',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(color: ColorTheme.color().primaryColor),
                )
              ],
            ),
          );
        }
        if (state is ResendOtpCountDownDone) {
          return InkWell(
            onTap: () {
              context
                  .read<ResendOtpBloc>()
                  .add(TapResendOtpEvent(mobileNumber: mobileNumber!));
            },
            child: Text(
              'Resent OTP',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: ColorTheme.color().primaryColor),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  void _authListener(BuildContext context, AuthBlocState authState) {
    final userRepo = context.read<UserRepository>();

    if (authState is AuthErrorState) {
      showCustomSnackbar(context, authState.errorMessage);
    }

    if (authState is AuthSuccessStateAndVerified) {
      final authRepo = context.read<AuthRepository>();
      if (authRepo.isNewUser) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                      create: (_) => FormFieldBloc(authState.mobileNumber!)),
                  BlocProvider(create: (_) => EditProfileBloc(userRepo))
                ],
                child: const EditUserPage(),
              );
            },
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => BottomNavBloc()),
                BlocProvider(create: (context) => ProfileBlocBloc(userRepo)),
              ],
              child: const MainScreen(),
            ),
          ),
        );
      }
    }
  }
}
