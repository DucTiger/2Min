import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:two_min/config/constant.dart';
import 'package:two_min/feature/challenge/domain/entity/challenge_entity.dart';
import 'package:two_min/router/app_router.gr.dart';

class ChallengeItem extends StatelessWidget {
  final ChallengeEntity? challengeEntity;

  const ChallengeItem({
    Key? key,
    this.challengeEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: ElevatedButton(
        onPressed: () {
          context.router.push(IdeaScreen(challengeEntity: challengeEntity));
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          elevation: kDefaultElevation,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              challengeEntity?.name ?? '',
            ),
            const Icon(Icons.keyboard_arrow_right)
          ],
        ),
      ),
    );
  }
}
