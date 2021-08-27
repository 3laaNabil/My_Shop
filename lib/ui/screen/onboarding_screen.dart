import 'package:flutter/material.dart';
import 'package:shop_app/constants/constants.dart';
import 'package:shop_app/data/local/cache_helper.dart';
import 'package:shop_app/data/models/onboarding_model.dart';
import 'package:shop_app/ui/screen/login_screen.dart';
import 'package:shop_app/ui/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/onbording.jpg',
      title: 'On Board 1 Title',
      body: 'On Board 1 Body',
    ),
    BoardingModel(
      image: 'assets/images/boarding2.jpg',
      title: 'On Board 2 Title',
      body: 'On Board 2 Body',
    ),
    BoardingModel(
      image: 'assets/images/onbording.jpg',
      title: 'On Board 3 Title',
      body: 'On Board 3 Body',
    ),
  ];

  bool isLast = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {

                CacheHelper.saveData(
                  key: 'onBoarding',
                  value: true,
                ).then((value) {
                  if (value) {
                    navigatToFinish(
                      context,
                      LoginScreen(),
                    );
                  }
                });
              },
              child: Text("Skip"),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: boardController,
                  itemBuilder: (context, index) =>
                      onBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController, // PageController
                    count: boarding.length,
                    effect: ExpandingDotsEffect(activeDotColor: defaultColor),
                    // your preferred effect
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        CacheHelper.saveData(
                          key: 'onBoarding',
                          value: true,
                        ).then((value) {
                          if (value) {
                            navigatToFinish(
                              context,
                              LoginScreen(),
                            );
                          }
                        });
                      } else {
                        boardController.nextPage(
                            duration: Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: Icon(Icons.arrow_forward_ios),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget onBoardingItem(BoardingModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage('${model.image}'),
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Text(
          '${model.title}',
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Text(
          '${model.body}',
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
      ],
    );
  }
}
