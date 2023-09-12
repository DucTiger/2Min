import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:two_min/common/widgets/dialogs/dialog_inform.dart';
import 'package:two_min/common/widgets/dropdow_wrapper.dart';
import 'package:two_min/feature/challenge/data/repository/challenge_repository_impl.dart';

import 'package:two_min/di/service_locator.dart';
import 'package:two_min/feature/challenge/domain/entity/fund_entity.dart';
import 'package:two_min/feature/challenge/presentation/bloc/challenge_bloc.dart';
import 'package:two_min/feature/challenge/presentation/bloc/challenge_event.dart';
import 'package:two_min/feature/challenge/presentation/bloc/challenge_state.dart';

import 'package:two_min/config/constant.dart';
import 'package:two_min/utils/utils.dart';
import 'package:two_min/config/colors.dart';
import 'challenge_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChallengeScreen extends StatefulWidget implements AutoRouteWrapper {
  const ChallengeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();

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

class _ChallengeScreenState extends State<ChallengeScreen> {
  @override
  void initState() {
    super.initState();
    Utils.afterBuild(() {
      context.read<ChallengeBloc>().add(ShowListFundEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appName),
        elevation: kAppBarElevation,
        centerTitle: true,
      ),
      body: Column(
        children: [
          BlocConsumer<ChallengeBloc, ChallengeState>(
            buildWhen: (previousState, currentState) =>
                currentState is ShowListFundState ||
                currentState is ShowLoadingListFundState,
            listener: (_, state) {
              if (state is ListFundFailedState) {
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
              if (state is ShowListFundState) {
                return Container(
                  color: kWhite,
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.selectFundHint,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      DropdownWrapper<FundEntity>(
                        hint:
                            Text(AppLocalizations.of(context)!.selectFundHint),
                        items: state.funds!
                            .map((item) => DropdownMenuItem<FundEntity>(
                                  value: item,
                                  child: Text(
                                    item.name ?? '',
                                  ),
                                ))
                            .toList(),
                        validator: (value) {
                          if (value == null) {
                            return AppLocalizations.of(context)!.selectFundHint;
                          }
                        },
                        initialValue: state.funds?[0],
                        onChanged: (value) {
                          context.read<ChallengeBloc>().add(
                                ShowListChallengeEvent(
                                    fundId: (value as FundEntity).id),
                              );
                        },
                        onSaved: (value) {},
                      ),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
          Expanded(
            child: BlocConsumer<ChallengeBloc, ChallengeState>(
              buildWhen: (previousState, currentState) =>
                  currentState is ShowListChallengeState ||
                  currentState is ShowLoadingListChallengeState,
              listener: (_, state) {
                if (state is ListFundFailedState) {
                  // show message here
                }
              },
              builder: (_, state) {
                if (state is ShowListChallengeState) {
                  return Container(
                    color: kWhite,
                    height: double.infinity,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      shrinkWrap: true,
                      itemCount: state.challenges?.length ?? 0,
                      itemBuilder: (_, index) => ChallengeItem(
                        challengeEntity: state.challenges?[index],
                      ),
                    ),
                  );
                }
                return const ChallengeShimmerLoading();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ChallengeShimmerLoading extends StatelessWidget {
  const ChallengeShimmerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (_, index) => Shimmer.fromColors(
        child: const ChallengeItem(
          challengeEntity: null,
        ),
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
      ),
    );
  }
}
