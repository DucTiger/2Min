import 'package:two_min/common/widgets/buttons/primary_button.dart';
import 'package:two_min/common/widgets/circle_loading.dart';
import 'package:two_min/config/colors.dart';
import 'package:two_min/di/service_locator.dart';
import 'package:two_min/feature/login/presentation/bloc/login_bloc.dart';
import 'package:two_min/feature/login/presentation/bloc/login_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_min/router/app_router.gr.dart';
import 'package:two_min/router/app_router_path.dart';
import 'package:two_min/feature/login/presentation/bloc/login_state.dart';
import 'package:auto_route/auto_route.dart';

import 'package:two_min/feature/login/data/repositories/login_repository_impl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:two_min/common/widgets/dialogs/dialog_inform.dart';

class LoginScreen extends StatelessWidget implements AutoRouteWrapper {
  LoginScreen({Key? key}) : super(key: key);
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
          listener: (_, state) {
            if (state is LoginSuccessState) {
              context.router.replaceAll([const MainScreen()]);
            }
            if (state is LoginFailedState) {
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
              currentState is LoginInitState ||
              currentState is LoginLoadingState,
          builder: (_, state) {
            return Scaffold(
              body: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.loginHeaderTitle,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 48,
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
                                    .read<LoginBloc>()
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
                          PrimaryButton(
                            onPressed: () {
                              // Test
                              // _emailController.text = 'thainh@teraark.com';
                              // _passwordController.text = 'teraark@2022';
                              // String email = _emailController.text;
                              // String password = _passwordController.text;
                              context.router
                                  .replaceNamed(AppRouterPath.mainScreenPath);
                              // context.read<LoginBloc>().add(
                              //       LoginPressedEvent(
                              //         email: email,
                              //         password: password,
                              //       ),
                              //     );
                            },
                            title: AppLocalizations.of(context)!.login,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  AppLocalizations.of(context)!.forgetPassword,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(AppLocalizations.of(context)!
                                  .dontHaveAccount),
                              TextButton(
                                onPressed: () {
                                  context.router.pushNamed(
                                      AppRouterPath.signupScreenPath);
                                },
                                style: TextButton.styleFrom(
                                  primary: kPrimaryColor, // foreground
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.signup,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      if (state is LoginLoadingState)
                        const Center(child: CircleLoading())
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (_) => LoginBloc(
        loginRepository: getIt.get<LoginRepositoryImpl>(),
      ),
      child: this,
    );
  }
}
