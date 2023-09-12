import 'package:flutter/material.dart';
import 'package:two_min/config/colors.dart';
import 'package:two_min/feature/idea/domain/entity/idea_entity.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:two_min/config/constant.dart';
import 'package:auto_route/auto_route.dart';
import 'package:two_min/router/app_router.gr.dart';

class IdeaDetailScreen extends StatelessWidget {
  final IdeaEntity? ideaEntity;

  const IdeaDetailScreen({
    Key? key,
    required this.ideaEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ideaEntity?.name ?? ''),
        elevation: kAppBarElevation,
        centerTitle: true,
      ),
      floatingActionButton: SizedBox(
        height: kDefaultButtonHeight,
        child: FloatingActionButton.extended(
          onPressed: () {
            context.router.push(ReviewScreen(ideaEntity: ideaEntity));
          },
          label: Text(
            AppLocalizations.of(context)!.review,
            style: const TextStyle(
              color: kWhite,
            ),
          ),
          backgroundColor: kPrimaryColor,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: kWhite,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardItem(
                header: AppLocalizations.of(context)!.problemStatement,
                content: ideaEntity?.problem,
              ),
              const SizedBox(
                height: 16,
              ),
              CardItem(
                header: AppLocalizations.of(context)!.summarizeSolution,
                content: ideaEntity?.solution,
              ),
              const SizedBox(
                height: 16,
              ),
              CardItem(
                header: AppLocalizations.of(context)!.requestedFundsInUSD,
                content: ideaEntity?.requestedFunds,
              ),
              const SizedBox(
                height: 16,
              ),
              CardItem(
                header: AppLocalizations.of(context)!.impact,
                content: ideaEntity?.impact,
              ),
              const SizedBox(
                height: 16,
              ),
              CardItem(
                header: AppLocalizations.of(context)!.auditability,
                content: ideaEntity?.auditability,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderItem extends StatelessWidget {
  final String? header;

  const HeaderItem({
    Key? key,
    this.header,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      header ?? '',
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.black,
        fontSize: 16,
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final String? header;
  final String? content;

  const CardItem({
    Key? key,
    this.header,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: kPrimaryColor),
        borderRadius: BorderRadius.circular(kDefaultBorderRadius),
      ),
      margin: const EdgeInsets.all(0),
      elevation: kDefaultElevation,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderItem(
              header: header,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(content ?? ''),
          ],
        ),
      ),
    );
  }
}
