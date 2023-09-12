import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_min/config/colors.dart';
import 'package:two_min/feature/challenge/presentation/ui/challenge_screen.dart';
import 'package:two_min/feature/event/presentation/ui/event_screen.dart';
import 'package:two_min/feature/report/presentation/ui/report_screen.dart';
import 'package:two_min/feature/settings/presentation/ui/settings_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:two_min/di/service_locator.dart';
import 'package:two_min/feature/challenge/data/repository/challenge_repository_impl.dart';
import 'package:two_min/feature/challenge/presentation/bloc/challenge_bloc.dart';

class MainScreen extends StatefulWidget implements AutoRouteWrapper {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<ChallengeBloc>(
      create: (_) => ChallengeBloc(
        challengeRepository: getIt.get<ChallengeRepositoryImpl>(),
      ),
      child: this,
    );
  }
}

class _MainScreenState extends State<MainScreen> {
  final _bodyContent = [
    const ChallengeScreen(),
    const ReportScreen(),
    const EventScreen(),
    const SettingsScreen(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _bodyContent,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          backgroundColor: kWhite,
          selectedLabelStyle: const TextStyle(fontSize: 14),
          unselectedLabelStyle: const TextStyle(fontSize: 14),
          selectedItemColor: kPrimaryColor,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: AppLocalizations.of(context)!.home,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.show_chart),
              label: AppLocalizations.of(context)!.report,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.event),
              label: AppLocalizations.of(context)!.event,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: AppLocalizations.of(context)!.settings,
            ),
          ],
        ),
      ),
    );
  }
}
