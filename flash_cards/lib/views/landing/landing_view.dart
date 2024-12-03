import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flash_cards/commons/responsive.dart';
import 'package:flash_cards/views/landing/landing_desktop_view.dart';
import 'package:flash_cards/views/landing/landing_mobile_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_models/topic_view_model.dart';


class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<TopicViewModel>(context, listen: false).fetchTopics();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: ColorfulSafeArea(
        bottomColor: Colors.white,
        child: ScreenTypeLayout(
          mobile: LandingMobile(),
          tablet: LandingDesktop(),
          desktop: LandingDesktop(),
        ),
      ),
      // floatingActionButton: Row(
      //   children: [
      //     FloatingActionButton(
      //       onPressed: () async {
      //         Provider.of<TopicViewModel>(context, listen: false).fetchTopics();
      //       },
      //       child: Text('Fetch'),
      //     ),
      //     FloatingActionButton(
      //       onPressed: () async {
      //         await locator<AuthenticationService>().login("ganzorig34", "Number#001");
      //       },
      //       child: Text('Login'),
      //     ),
      //     FloatingActionButton(
      //       onPressed: () async {
      //         var res = await locator<AuthenticationService>().logout();
      //         if(res.statusCode == 204) {
      //           print('success logout');
      //         } 
      //       },
      //       child: Text('Logout'),
      //     ),
      //     FloatingActionButton(
      //       onPressed: () async {
      //         var res = await locator<AuthenticationService>().refreshToken();
      //       },
      //       child: Text('Refresh'),
      //     ),
      //   ],
      // ),
    );
  }
}