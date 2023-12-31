import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../config/constant.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.event),
        elevation: kAppBarElevation,
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Event Screen'),
      ),
    );
  }
}
