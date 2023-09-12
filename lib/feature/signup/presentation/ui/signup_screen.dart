import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:two_min/common/widgets/buttons/primary_button.dart';
import 'package:two_min/common/widgets/circle_loading.dart';
import 'package:two_min/feature/signup/data/model/signup_request.dart';
import 'package:two_min/feature/signup/presentation/bloc/signup_bloc.dart';

import 'package:two_min/config/colors.dart';
import 'package:two_min/config/constant.dart';
import 'package:two_min/di/service_locator.dart';
import 'package:two_min/router/app_router.gr.dart';
import 'package:two_min/feature/signup/data/repository/signup_repository_impl.dart';
import 'package:two_min/feature/signup/presentation/bloc/signup_state.dart';
import 'package:two_min/feature/signup/presentation/bloc/signup_event.dart';
import 'package:auto_route/auto_route.dart';

import 'package:two_min/utils/utils.dart';

import 'package:two_min/common/widgets/dialogs/dialog_inform.dart';

class SignupScreen extends StatefulWidget implements AutoRouteWrapper {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<SignupBloc>(
      create: (_) => SignupBloc(
        signupRepository: getIt.get<SignupRepositoryImpl>(),
      ),
      child: this,
    );
  }
}

class _SignupScreenState extends State<SignupScreen> {
  final _userNameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userNameController.addListener(_userNameChangedListener);
    _emailController.addListener(_emailChangedListener);
    _passwordController.addListener(_passwordChangedListener);
    _confirmPasswordController.addListener(_confirmPasswordChangedListener);
  }

  @override
  void dispose() {
    _userNameController.removeListener(_userNameChangedListener);
    _emailController.removeListener(_emailChangedListener);
    _passwordController.removeListener(_passwordChangedListener);
    _confirmPasswordController.removeListener(_confirmPasswordChangedListener);
    super.dispose();
  }

  void _userNameChangedListener() {
    _raiseEventCheckSignupButtonStatus();
  }

  void _emailChangedListener() {
    _raiseEventCheckSignupButtonStatus();
  }

  void _passwordChangedListener() {
    _raiseEventCheckSignupButtonStatus();
  }

  void _confirmPasswordChangedListener() {
    _raiseEventCheckSignupButtonStatus();
  }

  void _raiseEventCheckSignupButtonStatus() {
    final userName = _userNameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    context.read<SignupBloc>().add(
          EnableSignupButtonEvent(
            userName: userName,
            email: email,
            password: password,
            confirmPassword: confirmPassword,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: kWhite,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: 0,
            right: kDefaultPadding,
            left: kDefaultPadding,
            bottom: kDefaultPadding,
          ),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              BlocConsumer<SignupBloc, SignupState>(
                listener: (_, state) {
                  if (state is SignupSuccessState) {
                    context.router.replaceAll([const MainScreen()]);
                  }
                  if (state is SignupFailedState) {
                    // show message here
                    showDialog(
                      context: context,
                      builder: (_) => DialogInform(
                        title: AppLocalizations.of(context)!.error,
                        message: state.errorMessage,
                        actionsButton: AppLocalizations.of(context)!.ok,
                        onPressed: () {},
                      ),
                    );
                  }
                },
                buildWhen: (previousState, currentState) =>
                    currentState is ShowHidePasswordState ||
                    currentState is SignupInitState,
                builder: (_, state) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.createAccount,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                      Text(
                        AppLocalizations.of(context)!.userName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _userNameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          fillColor: Colors.white,
                          hintText: AppLocalizations.of(context)!.userName,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        AppLocalizations.of(context)!.email,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          fillColor: Colors.white,
                          hintText: AppLocalizations.of(context)!.emailHint,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        AppLocalizations.of(context)!.password,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.text,
                        obscureText: state is ShowHidePasswordState
                            ? state.showHidePassword
                            : true,
                        decoration: InputDecoration(
                          hintText: '********',
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () => context
                                .read<SignupBloc>()
                                .add(ShowHidePasswordEvent()),
                            icon: const Icon(
                              Icons.visibility,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        AppLocalizations.of(context)!.confirmPassword,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _confirmPasswordController,
                        keyboardType: TextInputType.text,
                        obscureText: state is ShowHidePasswordState
                            ? state.showHidePassword
                            : true,
                        decoration: InputDecoration(
                          hintText: '********',
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () => context
                                .read<SignupBloc>()
                                .add(ShowHidePasswordEvent()),
                            icon: const Icon(
                              Icons.visibility,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      BlocBuilder<SignupBloc, SignupState>(
                        buildWhen: (previousState, currentState) =>
                            currentState is SignupInitState ||
                            currentState is EnableSignupButtonState,
                        builder: (_, state) => PrimaryButton(
                          onPressed: state is EnableSignupButtonState &&
                              state.isEnableSignupButton
                              ? () {
                            // Test
                            String userName = _userNameController.text;
                            String email = _emailController.text;
                            String password = _passwordController.text;
                            String confirmPassword =
                                _confirmPasswordController.text;
                            if (password.isNotEmpty &&
                                confirmPassword.isNotEmpty &&
                                password != confirmPassword) {
                              Utils.showSnackBarMessage(
                                  context,
                                  AppLocalizations.of(context)!
                                      .msgPasswordNotMatch);
                              return;
                            }
                            context.read<SignupBloc>().add(
                              SubmitSignupEvent(
                                signupRequest: SignupRequest(
                                  username: userName,
                                  email: email,
                                  password: password,
                                ),
                              ),
                            );
                          }
                              : null,
                          title: AppLocalizations.of(context)!.signup,
                        ),
                      ),
                    ],
                  );
                },
              ),
              BlocBuilder<SignupBloc, SignupState>(
                buildWhen: (previousState, currentState) =>
                    currentState is SignupLoadingState ||
                    currentState is SignupFailedState,
                builder: (_, state) {
                  if (state is SignupLoadingState) {
                    return const CircleLoading();
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
