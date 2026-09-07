import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/ui/login/login_Screen.dart';
import 'package:flutter/material.dart';

import '../home/home_screen.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final PageController _pageController = PageController();

  int currentPage = 0;

  final List<Map<String, String>> pages = [
    {
      'image': 'assets/images/intro_1.png',
      'title': 'Find Events That Inspire You',
      'body':
          'Dive into a world of events crafted to fit \n your unique interests. Whether youre into \n '
          'live music, art workshops, professional \n'
          ' networking, or simply discovering new \n'
          'experiences, we have something for \n'
          'everyone. Our curated recommendations \n '
          'will help you explore, connect, and make\n'
          ' the most of every opportunity around you.',
    },
    {
      'image': 'assets/images/intro_2.png',
      'title': 'Effortless Event Planning',
      'body':
          'Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.',
    },
    {
      'image': 'assets/images/intro_3.png',
      'title': 'Connect with Friends & Share Moments ',
      'body':
          'Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Next
  void nextPage() {
    if (currentPage < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      goToLogin();
    }
  }

  // Back
  void backPage() {
    if (currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Skip
  void skip() {
    goToLogin();
  }

  void goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // =========================
              // Back | Logo | Skip
              // =========================
              SizedBox(
                height: 65,
                child: Stack(
                  children: [
                    // Logo في النص
                    Center(
                      child: Image.asset(
                        'assets/images/intro_logo.png',
                        width: 142,
                        height: 27,
                      ),
                    ),

                    // Back
                    if (currentPage > 0)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).bottomNavigationBarTheme.backgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                width: 1,
                                color: Theme.of(context).highlightColor,
                              ),
                            ),
                          ),
                          onPressed: backPage,
                          child: Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                      ),

                    // Skip
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).bottomNavigationBarTheme.backgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              width: 1,
                              color: Theme.of(context).highlightColor,
                            ),
                          ),
                        ),
                        onPressed: skip,
                        child: Text(
                          AppLocalizations.of(context)!.skip,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // =========================
              const SizedBox(height: 20),

              // =========================
              // Pages
              // =========================
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: pages.length,

                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },

                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        // الصورة الكبيرة
                        Expanded(
                          flex: 5,
                          child: Image.asset(
                            pages[index]['image']!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Dots
                        // =========================
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(pages.length, (index) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: currentPage == index ? 20 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: currentPage == index
                                    ? Colors.blue
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            );
                          }),
                        ),

                        Column(
                          children: [
                            // العنوان
                            Text(
                              pages[index]['title']!,
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            const SizedBox(height: 10),
                            // Body
                            Text(
                              pages[index]['body']!,
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 10),
                            // const Spacer(),

                            // Next
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).cardColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                onPressed: nextPage,
                                child: Text(
                                  currentPage == pages.length - 1
                                      ? AppLocalizations.of(
                                          context,
                                        )!.get_started
                                      : AppLocalizations.of(context)!.next,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.displayLarge,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
