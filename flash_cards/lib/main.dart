import 'package:flash_cards/repository/question_repository.dart';
import 'package:flash_cards/repository/topic_repository.dart';
import 'package:flash_cards/view_models/login_view_model.dart';
import 'package:flash_cards/view_models/question_answer_view_model.dart';
import 'package:flash_cards/view_models/signup_view_model.dart';
import 'package:flash_cards/view_models/topic_view_model.dart';
import 'package:flash_cards/views/landing/landing_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sizer/sizer.dart';

import 'locator.dart';
import 'views/login/login_view.dart';
import 'views/signup/signup_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  ResponsiveSizingConfig.instance.setCustomBreakpoints(
    const ScreenBreakpoints(desktop: 960, tablet: 600, watch: 200),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => SignUpViewModel()),
        ChangeNotifierProvider(create: (_) => TopicViewModel(locator<TopicRepository>())),
        ChangeNotifierProxyProvider<TopicViewModel, QuestionAnswerViewModel>(
          create: (_) => QuestionAnswerViewModel(locator<QuestionAnswerRepository>()),
          update: (context, topicViewModel, questionAnswerViewModel) {
            // Inject TopicViewModel into QuestionAnswerViewModel
            questionAnswerViewModel?.setTopicViewModel(topicViewModel);
            return questionAnswerViewModel!;
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (p0, p1, p2) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          getPages: [
            GetPage(name: '/', page: () => const LandingPage()),
            GetPage(name: '/login', page: () => const LoginView()), // Add your LoginPage
            GetPage(name: '/signup', page: () => const SignUpView()), // Add your LoginPage
          ],
        );
      },
    );
  }
}
