import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:two_min/common/widgets/dialogs/dialog_inform.dart';

import 'package:two_min/di/service_locator.dart';

import 'package:two_min/config/colors.dart';
import 'package:two_min/config/constant.dart';
import 'package:two_min/utils/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../challenge/domain/entity/challenge_entity.dart';
import '../../data/repository/idea_repository_impl.dart';
import '../bloc/idea_bloc.dart';
import '../bloc/idea_event.dart';
import '../bloc/idea_state.dart';
import 'idea_item.dart';

class IdeaScreen extends StatefulWidget implements AutoRouteWrapper {
  final ChallengeEntity? challengeEntity;

  const IdeaScreen({
    Key? key,
    required this.challengeEntity,
  }) : super(key: key);

  @override
  State<IdeaScreen> createState() => _IdeaScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<IdeaBloc>(
      create: (_) => IdeaBloc(
        ideaRepository: getIt.get<IdeaRepositoryImpl>(),
      ),
      child: this,
    );
  }
}

class _IdeaScreenState extends State<IdeaScreen> {
  @override
  void initState() {
    super.initState();
    Utils.afterBuild(() {
      context.read<IdeaBloc>().add(
            ListIdeaEvent(
              challengeId: widget.challengeEntity?.id,
            ),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<IdeaBloc, IdeaState>(
        buildWhen: (previousState, currentState) =>
            currentState is ShowLoadingListIdeaState ||
            currentState is ShowListIdeaState,
        listener: (_, state) {
          if (state is ListIdeaFailedState) {
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
        builder: (_, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.challengeEntity?.name ??
                  AppLocalizations.of(context)!.appName),
              elevation: kAppBarElevation,
              centerTitle: true,
            ),
            body: state is ShowListIdeaState
                ? Container(
                    color: kWhite,
                    height: double.infinity,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      shrinkWrap: true,
                      itemCount: state.ideas?.length ?? 0,
                      itemBuilder: (_, index) => IdeaItem(
                        ideaEntity: state.ideas?[index],
                      ),
                    ),
                  )
                : const IdeaShimmerLoading(),
            // body: FundShimmerLoading(),
          );
        },
      ),
    );
  }
}

class IdeaShimmerLoading extends StatelessWidget {
  const IdeaShimmerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (_, index) => Shimmer.fromColors(
        child: const IdeaItem(
          ideaEntity: null,
        ),
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
      ),
    );
  }
}
