import 'package:charge_mod/repositories/auth_repostiory.dart';
import 'package:charge_mod/repositories/location_repostiory.dart';
import 'package:charge_mod/repositories/user_repostiroy.dart';
import 'package:charge_mod/services/dio_service.dart';
import 'package:charge_mod/utils/snackbar.dart';
import 'package:charge_mod/views/edit_pofile/bloc/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:charge_mod/views/edit_pofile/bloc/form_field_bloc/form_field_bloc.dart';
import 'package:charge_mod/views/home_screen/bloc/location_bloc/location_bloc.dart';
import 'package:charge_mod/views/main_screen/bloc/bottom_nav_bloc/bottom_nav_bloc.dart';
import 'package:charge_mod/views/main_screen/bloc/profile_bloc/profile_bloc_bloc.dart';
import 'package:charge_mod/views/main_screen/main_screeen.dart';
import 'package:charge_mod/views/profile/log_out_bloc/log_out_bloc.dart';
import 'package:charge_mod/widgets/primary_button.dart';
import 'package:charge_mod/widgets/textfield.dart';
import 'package:flutter/material.dart' hide FormFieldState;
import 'package:flutter_bloc/flutter_bloc.dart';

class EditUserPage extends StatelessWidget {
  const EditUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Update Profile',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<FormFieldBloc, FormFieldState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextField(
                  controller: TextEditingController(),
                  hintText: 'First Name',
                  labelText: 'First Name',
                  onChanged: (value) {
                    context
                        .read<FormFieldBloc>()
                        .add(FirstNameChangeEvent(value));
                  },
                  error: state is FormErrorState && state.firstNameError != null
                      ? state.firstNameError
                      : null,
                ),
                const SizedBox(height: 18),
                AppTextField(
                  controller: TextEditingController(),
                  hintText: 'Last Name',
                  labelText: 'Last Name',
                  onChanged: (value) {
                    context
                        .read<FormFieldBloc>()
                        .add(LastNameChangeEvent(value));
                  },
                  error: state is FormErrorState && state.lastNameError != null
                      ? state.lastNameError
                      : null,
                ),
                const SizedBox(height: 18),
                AppTextField(
                  controller: TextEditingController(),
                  hintText: 'e-mail',
                  labelText: 'E-mail',
                  onChanged: (value) {
                    context.read<FormFieldBloc>().add(EmailChangeEvent(value));
                  },
                  error: state is FormErrorState && state.emailError != null
                      ? state.emailError
                      : null,
                ),
                const SizedBox(height: 23),
                Text(
                  'Phone Number',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 12),
                ),
                const SizedBox(height: 16),
                Text(
                  state.mobileNumber,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
          );
        },
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Completing Your Profile',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'This action will reflect in your activities and payments after saving. we ask for email details for recieving monthly activity and notifications.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            const SizedBox(height: 13),
            BlocConsumer<EditProfileBloc, EditProfileState>(
              listener: (context, state) {
                if (state is EditProfileErrorState) {
                  showCustomSnackbar(context, state.errorMessage);
                  return;
                }
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => RepositoryProvider(
                      create: (context) =>
                          LocationRepository(dio: BaseDioService.instance.dio),
                      child: MultiBlocProvider(
                        providers: [
                          BlocProvider(create: (context) => BottomNavBloc()),
                          BlocProvider(
                            create: (context) =>
                                ProfileBlocBloc(context.read<UserRepository>()),
                          ),
                          BlocProvider(
                            create: (context) => LocationBloc(
                                context.read<LocationRepository>()),
                          ),
                          BlocProvider(
                            create: (context) => LogoutBloc(
                                context.read<AuthRepository>(),
                                context.read<UserRepository>()),
                          ),
                        ],
                        child: const MainScreen(),
                      ),
                    ),
                  ),
                );
              },
              builder: (context, state) {
                final formState = context.read<FormFieldBloc>().state;
                return IgnorePointer(
                  ignoring: state is EditProfileLoadingState ||
                      formState is! FormFillState,
                  child: SizedBox(
                    width: double.infinity,
                    height: 38,
                    child: PrimaryButton(
                      isLoading: state is EditProfileLoadingState,
                      buttonText: 'Save Changes',
                      onTap: () {
                        final form = formState as FormFillState;
                        context.read<EditProfileBloc>().add(
                              EditProfileDoneEvent(
                                firstName: form.firstName,
                                lastName: form.lastName,
                                email: form.email,
                                mobileNumber: form.mobileNumber,
                              ),
                            );
                      },
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 26),
          ],
        ),
      ),
    );
  }
}
