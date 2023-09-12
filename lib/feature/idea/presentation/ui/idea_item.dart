import 'package:flutter/material.dart';
import 'package:two_min/config/constant.dart';

import 'package:two_min/feature/idea/domain/entity/idea_entity.dart';

import 'package:auto_route/auto_route.dart';
import 'package:two_min/router/app_router.gr.dart';

class IdeaItem extends StatelessWidget {
  final IdeaEntity? ideaEntity;

  const IdeaItem({
    Key? key,
    this.ideaEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 72,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      child: ElevatedButton(
        onPressed: () {
          context.router.push(IdeaDetailScreen(ideaEntity: ideaEntity));
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          elevation: kDefaultElevation,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    ideaEntity?.name ?? '',
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    ideaEntity?.problem ?? '',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Icon(Icons.keyboard_arrow_right)
          ],
        ),
      ),
    );
  }
}
