// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;

import '../feature/challenge/domain/entity/challenge_entity.dart' as _i11;
import '../feature/challenge/presentation/ui/challenge_screen.dart' as _i5;
import '../feature/idea/domain/entity/idea_entity.dart' as _i12;
import '../feature/idea/presentation/ui/idea_detail_screen.dart' as _i7;
import '../feature/idea/presentation/ui/idea_screen.dart' as _i6;
import '../feature/login/presentation/ui/login_screen.dart' as _i2;
import '../feature/main/presentation/ui/main_screen.dart' as _i4;
import '../feature/review/presentation/ui/review_screen.dart' as _i8;
import '../feature/signup/presentation/ui/signup_screen.dart' as _i3;
import '../feature/splash/presentation/ui/splash_screen.dart' as _i1;

class AppRouter extends _i9.RootStackRouter {
  AppRouter([_i10.GlobalKey<_i10.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    SplashScreen.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.SplashScreen());
    },
    LoginScreen.name: (routeData) {
      final args = routeData.argsAs<LoginScreenArgs>(
          orElse: () => const LoginScreenArgs());
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i9.WrappedRoute(child: _i2.LoginScreen(key: args.key)));
    },
    SignupScreen.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i9.WrappedRoute(child: const _i3.SignupScreen()));
    },
    MainScreen.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i9.WrappedRoute(child: const _i4.MainScreen()));
    },
    ChallengeScreen.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i9.WrappedRoute(child: const _i5.ChallengeScreen()));
    },
    IdeaScreen.name: (routeData) {
      final args = routeData.argsAs<IdeaScreenArgs>();
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i9.WrappedRoute(
              child: _i6.IdeaScreen(
                  key: args.key, challengeEntity: args.challengeEntity)));
    },
    IdeaDetailScreen.name: (routeData) {
      final args = routeData.argsAs<IdeaDetailScreenArgs>();
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData,
          child:
              _i7.IdeaDetailScreen(key: args.key, ideaEntity: args.ideaEntity));
    },
    ReviewScreen.name: (routeData) {
      final args = routeData.argsAs<ReviewScreenArgs>(
          orElse: () => const ReviewScreenArgs());
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i9.WrappedRoute(
              child: _i8.ReviewScreen(
                  key: args.key, ideaEntity: args.ideaEntity)));
    }
  };

  @override
  List<_i9.RouteConfig> get routes => [
        _i9.RouteConfig('/#redirect',
            path: '/', redirectTo: '/splashScreen', fullMatch: true),
        _i9.RouteConfig(SplashScreen.name, path: '/splashScreen'),
        _i9.RouteConfig(LoginScreen.name, path: '/loginScreen'),
        _i9.RouteConfig(SignupScreen.name, path: '/signupScreen'),
        _i9.RouteConfig(MainScreen.name, path: '/mainScreen'),
        _i9.RouteConfig(ChallengeScreen.name, path: '/challengeScreen'),
        _i9.RouteConfig(IdeaScreen.name, path: '/ideaScreen'),
        _i9.RouteConfig(IdeaDetailScreen.name, path: '/ideaDetailScreen'),
        _i9.RouteConfig(ReviewScreen.name, path: '/reviewScreen')
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashScreen extends _i9.PageRouteInfo<void> {
  const SplashScreen() : super(SplashScreen.name, path: '/splashScreen');

  static const String name = 'SplashScreen';
}

/// generated route for
/// [_i2.LoginScreen]
class LoginScreen extends _i9.PageRouteInfo<LoginScreenArgs> {
  LoginScreen({_i10.Key? key})
      : super(LoginScreen.name,
            path: '/loginScreen', args: LoginScreenArgs(key: key));

  static const String name = 'LoginScreen';
}

class LoginScreenArgs {
  const LoginScreenArgs({this.key});

  final _i10.Key? key;

  @override
  String toString() {
    return 'LoginScreenArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.SignupScreen]
class SignupScreen extends _i9.PageRouteInfo<void> {
  const SignupScreen() : super(SignupScreen.name, path: '/signupScreen');

  static const String name = 'SignupScreen';
}

/// generated route for
/// [_i4.MainScreen]
class MainScreen extends _i9.PageRouteInfo<void> {
  const MainScreen() : super(MainScreen.name, path: '/mainScreen');

  static const String name = 'MainScreen';
}

/// generated route for
/// [_i5.ChallengeScreen]
class ChallengeScreen extends _i9.PageRouteInfo<void> {
  const ChallengeScreen()
      : super(ChallengeScreen.name, path: '/challengeScreen');

  static const String name = 'ChallengeScreen';
}

/// generated route for
/// [_i6.IdeaScreen]
class IdeaScreen extends _i9.PageRouteInfo<IdeaScreenArgs> {
  IdeaScreen({_i10.Key? key, required _i11.ChallengeEntity? challengeEntity})
      : super(IdeaScreen.name,
            path: '/ideaScreen',
            args: IdeaScreenArgs(key: key, challengeEntity: challengeEntity));

  static const String name = 'IdeaScreen';
}

class IdeaScreenArgs {
  const IdeaScreenArgs({this.key, required this.challengeEntity});

  final _i10.Key? key;

  final _i11.ChallengeEntity? challengeEntity;

  @override
  String toString() {
    return 'IdeaScreenArgs{key: $key, challengeEntity: $challengeEntity}';
  }
}

/// generated route for
/// [_i7.IdeaDetailScreen]
class IdeaDetailScreen extends _i9.PageRouteInfo<IdeaDetailScreenArgs> {
  IdeaDetailScreen({_i10.Key? key, required _i12.IdeaEntity? ideaEntity})
      : super(IdeaDetailScreen.name,
            path: '/ideaDetailScreen',
            args: IdeaDetailScreenArgs(key: key, ideaEntity: ideaEntity));

  static const String name = 'IdeaDetailScreen';
}

class IdeaDetailScreenArgs {
  const IdeaDetailScreenArgs({this.key, required this.ideaEntity});

  final _i10.Key? key;

  final _i12.IdeaEntity? ideaEntity;

  @override
  String toString() {
    return 'IdeaDetailScreenArgs{key: $key, ideaEntity: $ideaEntity}';
  }
}

/// generated route for
/// [_i8.ReviewScreen]
class ReviewScreen extends _i9.PageRouteInfo<ReviewScreenArgs> {
  ReviewScreen({_i10.Key? key, _i12.IdeaEntity? ideaEntity})
      : super(ReviewScreen.name,
            path: '/reviewScreen',
            args: ReviewScreenArgs(key: key, ideaEntity: ideaEntity));

  static const String name = 'ReviewScreen';
}

class ReviewScreenArgs {
  const ReviewScreenArgs({this.key, this.ideaEntity});

  final _i10.Key? key;

  final _i12.IdeaEntity? ideaEntity;

  @override
  String toString() {
    return 'ReviewScreenArgs{key: $key, ideaEntity: $ideaEntity}';
  }
}
