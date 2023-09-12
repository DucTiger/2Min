import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../config/constant.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.report),
        elevation: kAppBarElevation,
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Report Screen'),
      ),
    );
  }
}
