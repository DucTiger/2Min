import 'package:two_min/feature/idea/data/idea_api.dart';
import 'package:two_min/feature/idea/data/repository/idea_repository_impl.dart';
import 'package:two_min/feature/login/data/login_api.dart';
import 'package:two_min/feature/login/data/repositories/login_repository_impl.dart';
import 'package:two_min/feature/login/presentation/bloc/login_bloc.dart';
import 'package:two_min/feature/review/data/repository/review_repository_impl.dart';
import 'package:two_min/feature/review/data/review_api.dart';
import 'package:two_min/feature/signup/data/repository/signup_repository_impl.dart';
import 'package:two_min/networking/dio_request.dart';
import 'package:get_it/get_it.dart';

import 'package:two_min/utils/shared_pref_manager.dart';

import 'package:two_min/feature/login/domain/repositories/login_repository.dart';

import 'package:two_min/feature/challenge/data/challenge_api.dart';
import 'package:two_min/feature/challenge/data/repository/challenge_repository_impl.dart';
import 'package:two_min/feature/signup/data/signup_api.dart';

/// registerFactory => Each time you call get<T>() you will get a new instance returned
/// registerSingleton => Each time you call get<T>() you will get the same instance returned
/// registerLazySingleton => Only the first time you call get<T>() this factory function will be called to create a new instance. After that you will always get the same instance returned.
final getIt = GetIt.instance;

Future setupServiceLocator() async {
  await _registerStorageComponents();
  _registerNetworkComponents();
  _registerRepositoryComponents();
  _registerBlocComponents();
}

void _registerNetworkComponents() {
  final dio = getDioInstance;
  getIt.registerSingleton(dio);

  getIt.registerSingleton(
    LoginApi(
      dio,
      baseUrl: dio.options.baseUrl,
    ),
  );

  getIt.registerSingleton(
    SignupApi(
      dio,
      baseUrl: dio.options.baseUrl,
    ),
  );

  getIt.registerSingleton(
    ChallengeApi(
      dio,
      baseUrl: dio.options.baseUrl,
    ),
  );

  getIt.registerSingleton(
    IdeaApi(
      dio,
      baseUrl: dio.options.baseUrl,
    ),
  );

  getIt.registerSingleton(
    ReviewApi(
      dio,
      baseUrl: dio.options.baseUrl,
    ),
  );
}

Future<void> _registerStorageComponents() async {
  SharedPreferencesManager sharedPreferencesManager =
      await SharedPreferencesManager.getInstance();
  getIt.registerSingleton(sharedPreferencesManager);
}

void _registerRepositoryComponents() {
  getIt.registerFactory<LoginRepositoryImpl>(
    () => LoginRepositoryImpl(
      loginApi: getIt.get<LoginApi>(),
    ),
  );

  getIt.registerFactory<SignupRepositoryImpl>(
    () => SignupRepositoryImpl(
      signupApi: getIt.get<SignupApi>(),
    ),
  );

  getIt.registerFactory<ChallengeRepositoryImpl>(
    () => ChallengeRepositoryImpl(
      challengeApi: getIt.get<ChallengeApi>(),
    ),
  );

  getIt.registerFactory<IdeaRepositoryImpl>(
    () => IdeaRepositoryImpl(
      ideaApi: getIt.get<IdeaApi>(),
    ),
  );

  getIt.registerFactory<ReviewRepositoryImpl>(
    () => ReviewRepositoryImpl(
      reviewApi: getIt.get<ReviewApi>(),
    ),
  );
}

void _registerBlocComponents() {}
