import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../commons/common_imports/common_libs.dart';
import '../../../commons/common_widgets/custom_button.dart';
import '../../../routes/route_manager.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/assets_manager.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();

  final List<String> pageContentString = [
    'The Renting feature can be\n accessed from anywhere in your\n house to help you.',
    'Rent your favorite Item and\nservices quickly',
    'The Renting feature can be\n accessed from anywhere in your\n house to help you.',
  ];

  final List<String> pageContentLightPng = [
    AppAssets.onBoard1,
    AppAssets.onBoard2,
    AppAssets.onBoard3,
  ];

  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPageIndex = _pageController.page!.round();
      });
    });
  }

  void  next(){
    if(currentPageIndex==2){
      Navigator.pushReplacementNamed(context, AppRoutes.locationAccessScreen);
      return;
    }
    setState(() {
      currentPageIndex++;
    });
    _pageController.animateToPage(currentPageIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    bool isDarkTheme = brightnessValue == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.all(AppConstants.padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(
              flex: 3,
            ),
            SizedBox(
              height: 350.h,
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _pageController,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return buildPage(index);
                },
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            SmoothPageIndicator(
              controller: _pageController,
              count: 3,
              effect: ExpandingDotsEffect(
                  activeDotColor: isDarkTheme
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.primaryContainer,
                  dotColor: Theme.of(context).colorScheme.primary,
                  dotHeight: 5.h,
                  dotWidth: 5.w,
                  spacing: 12.w,
                  expansionFactor: 5),
            ),
            const Spacer(
              flex: 1,
            ),
            CustomButton(
              onPressed: next,
              buttonText: currentPageIndex == 2 ? 'Get Started' : 'Next',
            ),
            SizedBox(
              height: 10.h,
            ),
            if (!(currentPageIndex == 2)) ...[
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.locationAccessScreen);
                  },
                  child: Text(
                    'Skip',
                    style: getSemiBoldStyle(
                        color: MyColors.lightText3Color,
                        fontSize: MyFonts.size14),
                  )),
            ],
            if (currentPageIndex == 2) ...[
              SizedBox(
                height: 48.h,
              )
            ],
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPage(int index) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          pageContentLightPng[index],
          height: 250.h,
          width: 333.w,
        ),
        Text(
          pageContentString[index],
          textAlign: TextAlign.center,
          style: getRegularStyle(
              color: MyColors.lightText3Color,
              fontSize: MyFonts.size18),
        )
      ],
    );
  }
}
