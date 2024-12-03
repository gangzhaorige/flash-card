
import 'package:flash_cards/repository/question_repository.dart';
import 'package:flash_cards/services/authentication_service.dart';
import 'package:get_it/get_it.dart';
// import 'package:stacked_services/stacked_services.dart';

import 'api.dart';
import 'repository/topic_repository.dart';


final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => Api());
  locator.registerLazySingleton(() => TopicRepository());
  locator.registerLazySingleton(() => QuestionAnswerRepository());
  locator.registerLazySingleton(() => AuthenticationService.getInstance());
}