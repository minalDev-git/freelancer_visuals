import 'package:flutter/material.dart';
import 'package:freelancer_visuals/core/theme/app_pallete.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  bool _isLastPage = false;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.lightBackgroundColor,
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: _controller,
          onPageChanged: (value) => setState(() {
            _isLastPage = value == 3;
          }),
          children: [
            OnBoardingPage(
              imagePath: 'assets/images/clients.png',
              title: 'Manage Clients Easily',
              subTitle: '"Add and track all your clients in one place"',
            ),
            OnBoardingPage(
              imagePath: 'assets/images/graph.png',
              title: 'Track your income',
              subTitle: '"View earnings, pending payments, and trends"',
            ),
            OnBoardingPage(
              imagePath: 'assets/images/invoice.png',
              title: 'Manage Invoices with ease',
              subTitle: '"Create, View, and Export invoices easily"',
            ),
            OnBoardingPage(
              imagePath: 'assets/images/FFD_logo.png',
              title: '',
              subTitle: '',
            ),
          ],
        ),
      ),
      bottomSheet: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (child, animation) {
          // Slide + Fade transition
          final offsetAnimation = Tween<Offset>(
            begin: const Offset(0, 1), // starts off-screen (bottom)
            end: Offset.zero,
          ).animate(animation);

          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        child: _isLastPage
            ? Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                child: ElevatedButton(
                  key: const ValueKey('getStartedBtn'), // important for switch
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppPallete.primary,
                    minimumSize: const Size.fromHeight(60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).pushNamedAndRemoveUntil('/login/', (route) => false);
                  },
                  child: const Text(
                    'Get Started',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              )
            : Container(
                key: const ValueKey('navBtns'), // important for switch
                decoration: BoxDecoration(
                  color: AppPallete.lightBackgroundColor,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).pushNamedAndRemoveUntil('/login/', (route) => false);
                      },
                      child: const Text(
                        'SKIP',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Center(
                      child: SmoothPageIndicator(
                        controller: _controller,
                        count: 4,
                        effect: WormEffect(
                          spacing: 16,
                          dotColor: Colors.black26,
                          activeDotColor: AppPallete.blackColor,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      ),
                      child: const Text(
                        'NEXT',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subTitle,
  });

  final String imagePath;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.6,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: AppPallete.lightTextSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          // const SizedBox(height: 20),
          Text(
            subTitle,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppPallete.lightTextSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
