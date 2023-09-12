import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:two_min/common/widgets/buttons/primary_button.dart';
import 'package:two_min/common/widgets/circle_loading.dart';
import 'package:two_min/common/widgets/dialogs/dialog_confirmation.dart';
import 'package:two_min/common/widgets/dialogs/dialog_inform.dart';
import 'package:two_min/common/widgets/dropdow_wrapper.dart';
import 'package:two_min/config/colors.dart';
import 'package:two_min/di/service_locator.dart';
import 'package:two_min/feature/idea/domain/entity/idea_entity.dart';
import 'package:two_min/feature/idea/presentation/ui/idea_detail_screen.dart';
import 'package:two_min/feature/review/data/model/review_request.dart';
import 'package:two_min/feature/review/data/repository/review_repository_impl.dart';
import 'package:two_min/feature/review/presentation/bloc/review_bloc.dart';
import 'package:two_min/feature/review/presentation/bloc/review_event.dart';
import 'package:two_min/feature/review/presentation/bloc/review_state.dart';

import 'package:two_min/config/constant.dart';
import 'package:two_min/router/app_router_path.dart';
import 'package:two_min/utils/sessions_utils.dart';

class ReviewScreen extends StatefulWidget implements AutoRouteWrapper {
  final IdeaEntity? ideaEntity;

  const ReviewScreen({
    Key? key,
    this.ideaEntity,
  }) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<ReviewBloc>(
      create: (_) => ReviewBloc(
        reviewRepository: getIt.get<ReviewRepositoryImpl>(),
      ),
      child: this,
    );
  }
}

class _ReviewScreenState extends State<ReviewScreen> {
  final TextEditingController _impactController = TextEditingController();

  final TextEditingController _feasibilityController = TextEditingController();

  final TextEditingController _auditabilityController = TextEditingController();

  String? _impactScore;

  String? _feasibilityScore;

  String? _auditabilityScore;

  int _activeCurrentStep = impactStep;

  List<Step> stepList() => [
        Step(
          state: _activeCurrentStep <= impactStep
              ? StepState.editing
              : StepState.complete,
          isActive: _activeCurrentStep >= impactStep,
          title: Text(AppLocalizations.of(context)!.reviewForImpact),
          content: CardReviewItem(
            header: AppLocalizations.of(context)!.reviewForImpact,
            hintText: AppLocalizations.of(context)!.enterYourReview,
            textEditingController: _impactController,
            onScoreChanged: (score) {
              setState(() {
                _impactScore = score;
              });
              _handleNextButtonStatusForImpact(impactScore: score);
            },
          ),
        ),
        Step(
          state: _activeCurrentStep <= feasibilityStep
              ? StepState.editing
              : StepState.complete,
          isActive: _activeCurrentStep >= feasibilityStep,
          title: Text(AppLocalizations.of(context)!.reviewForFeasibility),
          content: CardReviewItem(
            header: AppLocalizations.of(context)!.reviewForFeasibility,
            hintText: AppLocalizations.of(context)!.enterYourReview,
            textEditingController: _feasibilityController,
            onScoreChanged: (score) {
              setState(() {
                _feasibilityScore = score;
              });
              _handleNextButtonStatusForFeasibility(feasibilityScore: score);
            },
          ),
        ),
        Step(
          state: _activeCurrentStep <= auditabilityStep
              ? StepState.editing
              : StepState.complete,
          isActive: _activeCurrentStep >= auditabilityStep,
          title: Text(AppLocalizations.of(context)!.reviewForAuditability),
          content: CardReviewItem(
              header: AppLocalizations.of(context)!.reviewForAuditability,
              hintText: AppLocalizations.of(context)!.enterYourReview,
              textEditingController: _auditabilityController,
              onScoreChanged: (score) {
                setState(() {
                  _auditabilityScore = score;
                });
                _handleNextButtonStatusForAuditability(
                    auditabilityScore: score);
              }),
        ),
        Step(
          state: StepState.complete,
          isActive: _activeCurrentStep >= confirmStep,
          title: Text(AppLocalizations.of(context)!.confirm),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CardItem(
                header:
                    '${AppLocalizations.of(context)!.reviewForImpact} - $_impactScore ${AppLocalizations.of(context)!.score}',
                content: _impactController.text,
              ),
              const SizedBox(
                height: kDefaultPadding,
              ),
              CardItem(
                header:
                    '${AppLocalizations.of(context)!.reviewForFeasibility} - $_feasibilityScore ${AppLocalizations.of(context)!.score}',
                content: _feasibilityController.text,
              ),
              const SizedBox(
                height: kDefaultPadding,
              ),
              CardItem(
                header:
                    '${AppLocalizations.of(context)!.reviewForAuditability} - $_auditabilityScore ${AppLocalizations.of(context)!.score}',
                content: _auditabilityController.text,
              ),
            ],
          ),
        ),
      ];

  void _impactChangedListener() {
    _handleNextButtonStatusForImpact();
  }

  void _feasibilityChangedListener() {
    _handleNextButtonStatusForFeasibility();
  }

  void _auditabilityChangedListener() {
    _handleNextButtonStatusForAuditability();
  }

  void _handleNextButtonStatusForImpact({String? impactScore}) {
    _handleNextButtonStatusEvent(
      impactScore: impactScore ?? _impactScore,
      impactReview: _impactController.text,
    );
  }

  void _handleNextButtonStatusForFeasibility({String? feasibilityScore}) {
    _handleNextButtonStatusEvent(
      feasibilityScore: feasibilityScore ?? _feasibilityScore,
      feasibilityReview: _feasibilityController.text,
    );
  }

  void _handleNextButtonStatusForAuditability({String? auditabilityScore}) {
    _handleNextButtonStatusEvent(
      auditabilityScore: auditabilityScore ?? _auditabilityScore,
      auditabilityReview: _auditabilityController.text,
    );
  }

  void _handleNextButtonStatusEvent({
    String? impactScore,
    String? impactReview,
    String? feasibilityScore,
    String? feasibilityReview,
    String? auditabilityScore,
    String? auditabilityReview,
  }) {
    context.read<ReviewBloc>().add(HandleNextButtonStatusReviewEvent(
          activeCurrentStep: _activeCurrentStep,
          impactScore: impactScore,
          impactReview: impactReview,
          feasibilityScore: feasibilityScore,
          feasibilityReview: feasibilityReview,
          auditabilityScore: auditabilityScore,
          auditabilityReview: auditabilityReview,
        ));
  }

  void _handleNextButtonStatus(int currentStep) {
    if (currentStep <= impactStep) {
      _handleNextButtonStatusForImpact();
    } else if (currentStep <= feasibilityStep) {
      _handleNextButtonStatusForFeasibility();
    } else if (currentStep <= auditabilityStep) {
      _handleNextButtonStatusForAuditability();
    }
  }

  bool get _canClickableStep {
    final impactReview = _impactController.text;
    final feasibilityReview = _feasibilityController.text;
    final auditabilityReview = _auditabilityController.text;

    final isImpactStepClickable = _activeCurrentStep <= impactStep &&
        impactReview.isNotEmpty &&
        _impactScore != null;
    final feasibilityStepClickable = _activeCurrentStep <= feasibilityStep &&
        feasibilityReview.isNotEmpty &&
        _feasibilityScore != null;
    final auditabilityStepClickable = _activeCurrentStep <= auditabilityStep &&
        auditabilityReview.isNotEmpty &&
        _auditabilityScore != null;

    if (isImpactStepClickable ||
        feasibilityStepClickable ||
        auditabilityStepClickable) {
      return true;
    }

    return false;
  }

  @override
  void initState() {
    super.initState();
    _impactController.addListener(_impactChangedListener);
    _feasibilityController.addListener(_feasibilityChangedListener);
    _auditabilityController.addListener(_auditabilityChangedListener);
  }

  @override
  void dispose() {
    _impactController.removeListener(_impactChangedListener);
    _feasibilityController.removeListener(_feasibilityChangedListener);
    _auditabilityController.removeListener(_auditabilityChangedListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.review),
        elevation: kAppBarElevation,
        centerTitle: true,
        // actions: [
        //   TextButton(
        //     onPressed: () {},
        //     child: Text(
        //       AppLocalizations.of(context)!.submit,
        //       style: const TextStyle(color: Colors.black, fontSize: 18),
        //     ),
        //     style: TextButton.styleFrom(
        //       primary: kPrimaryColor, // foreground
        //     ),
        //   ),
        // ],
      ),
      body: Theme(
        data: ThemeData(
          primarySwatch: kPrimaryMaterialColor,
        ),
        child: BlocConsumer<ReviewBloc, ReviewState>(
          listenWhen: (previousState, currentState) =>
              currentState is ReviewFailedState ||
              currentState is ReviewSuccessState,
          listener: (_, state) {
            if (state is ReviewFailedState) {
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

            if (state is ReviewSuccessState) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => DialogInform(
                  title: AppLocalizations.of(context)!.success,
                  message: AppLocalizations.of(context)!.msgSubmitReviewSuccess,
                  actionsButton: AppLocalizations.of(context)!.ok,
                  onPressed: () {
                    context.router.popUntilRoot();
                  },
                ),
              );
            }
          },
          buildWhen: (previousState, currentState) =>
              currentState is ReviewInitState ||
              currentState is ShowReviewLoadingState,
          builder: (_, state) => Stack(
            children: [
              Stepper(
                controlsBuilder: (context, details) {
                  return Row(
                    children: [
                      BlocBuilder<ReviewBloc, ReviewState>(
                        builder: (_, state) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: kDefaultPadding,
                                right: kDefaultPadding / 2),
                            child: PrimaryButton(
                              height: 36,
                              onPressed: (state is ReviewInitState)
                                  ? null
                                  : ((state is NextButtonStatusReviewState &&
                                              (state.isEnable ?? false) &&
                                              _activeCurrentStep ==
                                                  state.currentStep) ||
                                          (_activeCurrentStep >= confirmStep))
                                      ? details.onStepContinue
                                      : null,
                              title: _activeCurrentStep >= confirmStep
                                  ? AppLocalizations.of(context)!.submit
                                  : AppLocalizations.of(context)!.next,
                              width: 80,
                            ),
                          );
                        },
                        buildWhen: (_, state) =>
                            state is ReviewInitState ||
                            state is NextButtonStatusReviewState,
                      ),
                      if (_activeCurrentStep > impactStep)
                        Padding(
                          padding: const EdgeInsets.only(top: kDefaultPadding),
                          child: TextButton(
                            onPressed: details.onStepCancel,
                            child: Text(AppLocalizations.of(context)!.cancel),
                          ),
                        ),
                    ],
                  );
                },
                type: StepperType.vertical,
                currentStep: _activeCurrentStep,
                steps: stepList(),
                onStepContinue: () {
                  if (_activeCurrentStep >= confirmStep) {
                    showDialog(
                      context: context,
                      builder: (_) => DialogConfirmation(
                        title: AppLocalizations.of(context)!.confirm,
                        message: AppLocalizations.of(context)!
                            .msgConfirmSubmitReview,
                        actionsButton: [
                          AppLocalizations.of(context)!.ok,
                          AppLocalizations.of(context)!.cancel
                        ],
                        onPositiveButtonPressed: () {
                          context.router.pop();
                          final reviewRequest = ReviewRequest(
                              impactScore: _impactScore,
                              impact: _impactController.text,
                              feasibilityScore: _feasibilityScore,
                              feasibility: _feasibilityController.text,
                              auditabilityScore: _auditabilityScore,
                              auditability: _auditabilityController.text,
                              ideaId: widget.ideaEntity?.id,
                              userId: SessionUtils.getUserId());
                          context.read<ReviewBloc>().add(AddReviewEvent(
                                reviewRequest: reviewRequest,
                              ));
                        },
                        onNegativeButtonPressed: () {
                          context.router.pop();
                        },
                      ),
                    );
                    return;
                  }

                  if (_activeCurrentStep < (stepList().length - 1)) {
                    int currentStep = _activeCurrentStep + 1;

                    setState(() {
                      _activeCurrentStep += 1;
                    });

                    _handleNextButtonStatus(currentStep);
                  }
                },
                onStepCancel: () {
                  int currentStep = _activeCurrentStep - 1;

                  setState(() {
                    _activeCurrentStep -= 1;
                  });

                  _handleNextButtonStatus(currentStep);
                },
                onStepTapped: (int index) {
                  if (index > _activeCurrentStep && !_canClickableStep) return;
                  setState(() {
                    _activeCurrentStep = index;
                  });

                  _handleNextButtonStatus(index);
                },
              ),
              if (state is ShowReviewLoadingState) const CircleLoading()
            ],
          ),
        ),
      ),
    );

    // return Scaffold(
    //   backgroundColor: kWhite,
    //   appBar: AppBar(
    //     title: Text(AppLocalizations.of(context)!.review),
    //     elevation: kAppBarElevation,
    //     centerTitle: true,
    //     actions: [
    //       TextButton(
    //         onPressed: () {},
    //         child: Text(
    //           AppLocalizations.of(context)!.submit,
    //           style: const TextStyle(color: Colors.black, fontSize: 18),
    //         ),
    //         style: TextButton.styleFrom(
    //           primary: kPrimaryColor, // foreground
    //         ),
    //       ),
    //     ],
    //   ),
    //   body: Column(
    //     children: [
    //       SizedBox(
    //         height: 64,
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             TimeLineItem(
    //               isFirst: true,
    //               title: AppLocalizations.of(context)!.impact,
    //               isActive: true,
    //             ),
    //             TimeLineItem(
    //               title: AppLocalizations.of(context)!.feasibility,
    //             ),
    //             TimeLineItem(
    //               isLast: true,
    //               title: AppLocalizations.of(context)!.auditability,
    //             ),
    //           ],
    //         ),
    //       ),
    //       Expanded(
    //         child: SingleChildScrollView(
    //           padding: const EdgeInsets.all(kPadding),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               CardItem(
    //                   header: AppLocalizations.of(context)!.reviewForImpact,
    //                   textEditingController: _impactController,
    //                   onScoreChanged: (score) {
    //                     _impactScore = score;
    //                   }),
    //               const SizedBox(
    //                 height: kPadding,
    //               ),
    //               CardItem(
    //                   header:
    //                       AppLocalizations.of(context)!.reviewForFeasibility,
    //                   textEditingController: _feasibilityController,
    //                   onScoreChanged: (score) {
    //                     _feasibility = score;
    //                   }),
    //               const SizedBox(
    //                 height: kPadding,
    //               ),
    //               CardItem(
    //                   header:
    //                       AppLocalizations.of(context)!.reviewForAuditability,
    //                   textEditingController: _auditabilityController,
    //                   onScoreChanged: (score) {
    //                     _auditability = score;
    //                   }),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}

class TimeLineItem extends StatelessWidget {
  final bool? isFirst;
  final bool? isLast;
  final String? title;
  final bool? isActive;

  const TimeLineItem({
    Key? key,
    this.isFirst,
    this.isLast,
    this.title,
    this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorStatus = (isActive ?? false) ? kPrimaryColor : Colors.grey;
    return TimelineTile(
      isFirst: isFirst ?? false,
      isLast: isLast ?? false,
      alignment: TimelineAlign.center,
      axis: TimelineAxis.horizontal,
      endChild: Padding(
        padding: const EdgeInsets.only(top: kDefaultPadding / 4),
        child: Text(title ?? ''),
      ),
      indicatorStyle: IndicatorStyle(
        // width: 20,
        // height: 20,
        indicator: Container(
          decoration: BoxDecoration(
            color: colorStatus,
            shape: BoxShape.circle,
            border: Border.fromBorderSide(
              BorderSide(
                color: Colors.white.withOpacity(0.2),
                width: kDefaultPadding / 4,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TextFieldArea extends StatelessWidget {
  final String? hintText;
  final TextEditingController? textEditingController;

  const TextFieldArea({
    Key? key,
    this.hintText,
    this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      maxLines: null,
      minLines: 6,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        fillColor: Colors.white,
        hintText: hintText ?? '',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class CardReviewItem extends StatelessWidget {
  final String? header;
  final String? hintText;
  final TextEditingController? textEditingController;
  final ValueChanged<String?>? onScoreChanged;

  const CardReviewItem({
    Key? key,
    this.header,
    this.hintText,
    this.textEditingController,
    this.onScoreChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      elevation: kDefaultElevation,
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HeaderItem(
            //   header: header,
            // ),
            // const SizedBox(
            //   height: 8,
            // ),
            TextFieldArea(
              textEditingController: textEditingController,
              hintText: hintText,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    AppLocalizations.of(context)!.score,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: DropdownWrapper<String>(
                    hint: Text(AppLocalizations.of(context)!.selectScore),
                    items: kScores
                        .map(
                          (item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                            ),
                          ),
                        )
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return AppLocalizations.of(context)!.selectScore;
                      }
                    },
                    onChanged: onScoreChanged,
                    onSaved: (value) {},
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
