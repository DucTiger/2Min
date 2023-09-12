import 'package:auto_route/auto_route.dart';
import 'package:two_min/feature/challenge/presentation/ui/challenge_screen.dart';
import 'package:two_min/feature/idea/presentation/ui/idea_detail_screen.dart';
import 'package:two_min/feature/idea/presentation/ui/idea_screen.dart';
import 'package:two_min/feature/login/presentation/ui/login_screen.dart';
import 'package:two_min/feature/review/presentation/ui/review_screen.dart';
import 'package:two_min/feature/signup/presentation/ui/signup_screen.dart';

import 'package:two_min/feature/splash/presentation/ui/splash_screen.dart';
import '../feature/main/presentation/ui/main_screen.dart';
import 'app_router_path.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: SplashScreen,
      initial: true,
      path: AppRouterPath.splashScreenPath,
    ),
    AutoRoute(
      page: LoginScreen,
      path: AppRouterPath.loginScreenPath,
    ),
    AutoRoute(
      page: SignupScreen,
      path: AppRouterPath.signupScreenPath,
    ),
    AutoRoute(
      page: MainScreen,
      path: AppRouterPath.mainScreenPath,
    ),
    AutoRoute(
      page: ChallengeScreen,
      path: AppRouterPath.challengeScreenPath,
    ),
    AutoRoute(
      page: IdeaScreen,
      path: AppRouterPath.ideaScreenPath,
    ),
    AutoRoute(
      page: IdeaDetailScreen,
      path: AppRouterPath.ideaDetailScreenPath,
    ),
    AutoRoute(
      page: ReviewScreen,
      path: AppRouterPath.reviewScreenPath,
    )
  ],
)
class $AppRouter {}
