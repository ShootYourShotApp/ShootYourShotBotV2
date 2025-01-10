import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sysbotv2/widgets/custom_button.dart';

import '../../widgets/gradient_text.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final carouselController = PageController();
  int currentIndex = 0;
  List<String> selectedFlexFactors = [];
  List<String> flexFactorsOptions = [
    'Lock eyes confidently',
    'Compliment their outfit',
    'Friendly wave',
    'Wait for queues',
    'Offer first drink',
    'Walk up smiling',
    'Hover near them',
    'Stay mysterious',
    'Approach with friend',
    'Start playful banter'
  ];
  List<String> selectedDripCheck = [];
  List<String> dripCheckOptions = [
    'Trendy outfit',
    'Bold color combos',
    'Subtle accessories',
    'A sharp suit',
    'Comfy but clean',
    'Perfect hygiene',
    'Whatever’s easiest',
    'Fresh haircut',
    'Crisp button-down',
    'Throwback vintage style'
  ];
  List<String> selectedJuiceLevel = [];
  List<String> juiceLevelOptions = [
    'Stay quiet & listen',
    'Keep the convo flowing',
    'Mention others wins',
    'Compliment someone’s insight',
    'Include someone who’s quiet',
    'Fade into the background',
    'Make everyone laugh',
    'Ask for someone’s opinion',
    'Give supportive nods',
    'Shift focus onto others'
  ];
  List<String> selectedPickupGame = [];
  List<String> pickupGameOptions = [
    'U French? bc Eiffel for u',
    'Come here often?',
    'Love your vibe, let’s talk',
    'Can’t believe u looked my way',
    'Been hoping you’d notice me',
    'Hi, I’m HIM and u’re mine',
    'I’d like to break the ice..& bed',
    'U Box? bc u’re a knockout',
    'Let’s skip the small talk',
    'Got a sweet tooth & u’re a snack'
  ];
  List<String> selectedGoalDigger = [];
  List<String> goalDiggerOptions = [
    'Hitting the gym',
    'Working on personal project',
    'Chilling',
    'Planing future goals',
    'Earn extra money',
    'Binge watch TV',
    'Grow personal brand',
    'Party',
    'Launch side hustle',
    'Get new certificates'
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xff0A0A0A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                width: width,
                height: height - 170,
                child: PageView(
                  dragStartBehavior: DragStartBehavior.down,
                  controller: carouselController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  children: [
                    CarouselItem(
                      selectedListItems: selectedFlexFactors,
                      allItems: flexFactorsOptions,
                      title: 'Flex Factor',
                      iconPath: 'assets/images/flexed-biceps-icon.png',
                      subtitle:
                          'At a party, you spot someone you like. Your next move is to ____.',
                      txtGradient: [Color(0xffFFFF00), Color(0xffEACDA3)],
                    ),
                    CarouselItem(
                      selectedListItems: selectedDripCheck,
                      allItems: dripCheckOptions,
                      title: 'Drip Check',
                      subtitle: 'For a big date, your go-to\nlook is ____.',
                      iconPath: 'assets/images/water-drop-icon.png',
                      txtGradient: const [Color(0xff4FACFE), Color(0xff00F2FE)],
                    ),
                    CarouselItem(
                      selectedListItems: selectedJuiceLevel,
                      allItems: juiceLevelOptions,
                      title: 'Juice Level',
                      subtitle:
                          'In a group, your way to stand\nout is to ____.',
                      iconPath: 'assets/images/juice-box-icon.png',
                      txtGradient: const [Color(0xff43E97B), Color(0xff43E97B)],
                    ),
                    CarouselItem(
                      selectedListItems: selectedPickupGame,
                      allItems: pickupGameOptions,
                      title: 'Pickup Game',
                      subtitle:
                          'You see your crush and walk over.\nYour first words are ____.',
                      iconPath: 'assets/images/ball.png',
                      txtGradient: const [Color(0xffF6D365), Color(0xffFDA085)],
                    ),
                    CarouselItem(
                      selectedListItems: selectedGoalDigger,
                      allItems: goalDiggerOptions,
                      title: 'Goal Digger',
                      subtitle: 'Your free time is spent\nworking on ____.',
                      iconPath: 'assets/images/trophy-icon.png',
                      txtGradient: const [Color(0xffF89418), Color(0xffEACDA3)],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Check if the selected items count for the current carousel is exactly 3
                  bool isSelectionValid = false;
                  switch (currentIndex) {
                    case 0:
                      isSelectionValid = selectedFlexFactors.length == 3;
                      break;
                    case 1:
                      isSelectionValid = selectedDripCheck.length == 3;
                      break;
                    case 2:
                      isSelectionValid = selectedJuiceLevel.length == 3;
                      break;
                    case 3:
                      isSelectionValid = selectedPickupGame.length == 3;
                      break;
                    case 4:
                      isSelectionValid = selectedGoalDigger.length == 3;
                      break;
                  }

                  if (isSelectionValid) {
                    if (carouselController.page == 4) {
                      print(selectedFlexFactors);
                      print(selectedDripCheck);
                      print(selectedJuiceLevel);
                      print(selectedPickupGame);
                      print(selectedGoalDigger);
                    } else {
                      carouselController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    }
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomButton(
                      title: 'Next',
                      bgClr: getButtonColors()['bgClr'],
                      txtClr: getButtonColors()['txtClr']),
                ),
              ),
              const Spacer(),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${currentIndex + 1}/',
                      style: TextStyle(
                        fontFamily: 'SFProRound',
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                      text: '5',
                      style: TextStyle(
                        fontFamily: 'SFProRound',
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }

  Map<String, Color?> getButtonColors() {
    bool isSelectionValid = false;
    switch (currentIndex) {
      case 0:
        isSelectionValid = selectedFlexFactors.length == 3;
        break;
      case 1:
        isSelectionValid = selectedDripCheck.length == 3;
        break;
      case 2:
        isSelectionValid = selectedJuiceLevel.length == 3;
        break;
      case 3:
        isSelectionValid = selectedPickupGame.length == 3;
        break;
      case 4:
        isSelectionValid = selectedGoalDigger.length == 3;
        break;
    }

    if (isSelectionValid) {
      return {
        'bgClr': null,
        'txtClr': null,
      };
    } else {
      return {
        'bgClr': const Color(0xff582AFF).withValues(alpha: 0.41),
        'txtClr': const Color(0xffffffff).withValues(alpha: 0.5),
      };
    }
  }
}

class CarouselItem extends StatefulWidget {
  const CarouselItem(
      {super.key,
      required this.selectedListItems,
      required this.allItems,
      required this.title,
      required this.iconPath,
      required this.subtitle,
      required this.txtGradient});

  final List<String> selectedListItems;
  final List<String> allItems;
  final String iconPath;
  final String title;
  final List<Color> txtGradient;
  final String subtitle;

  @override
  State<CarouselItem> createState() => _CarouselItemState();
}

class _CarouselItemState extends State<CarouselItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 36),
        Center(
          child: Image.asset(
            widget.iconPath,
            width: 50,
          ),
        ),
        const SizedBox(height: 8),
        GradientText(
          gradientColors: widget.txtGradient,
          textWidget: Text(
            widget.title,
            style: TextStyle(
              fontFamily: 'LuckiestGuy',
              color: Colors.white,
              fontSize: 32,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            widget.subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'SFCompactRounded',
              fontWeight: FontWeight.w400,
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ),
        const SizedBox(height: 36),
        Wrap(
          runSpacing: 16,
          spacing: 6,
          runAlignment: WrapAlignment.center,
          alignment: WrapAlignment.center,
          children: List.generate(widget.allItems.length, (index) {
            final item = widget.allItems[index];
            return OptionContainer(
              title: item,
              isSelected: widget.selectedListItems.contains(item),
              onTap: () => onOptionTapped(item),
            );
          }),
        ),
        const Spacer(flex: 2),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Select ',
                style: TextStyle(
                  fontFamily: 'SFProRound',
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              TextSpan(
                text: '3 answers',
                style: TextStyle(
                  fontFamily: 'SFProRound',
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        const Spacer()
      ],
    );
  }

  void onOptionTapped(String flagTitle) {
    setState(() {
      if (widget.selectedListItems.contains(flagTitle)) {
        widget.selectedListItems.remove(flagTitle);
      } else {
        widget.selectedListItems.add(flagTitle);
      }
      // Notify the parent widget to rebuild the button
      (context.findAncestorStateOfType<_QuestionsScreenState>()!)
          .setState(() {});
    });
  }
}

class OptionContainer extends StatefulWidget {
  const OptionContainer({
    super.key,
    required this.title,
    this.isSelected,
    this.onTap,
  });

  final String title;
  final bool? isSelected;
  final VoidCallback? onTap;

  @override
  _OptionContainerState createState() => _OptionContainerState();
}

class _OptionContainerState extends State<OptionContainer> {
  @override
  Widget build(BuildContext context) {
    bool selection = widget.isSelected ?? false;

    return IntrinsicWidth(
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: selection ? const Color(0xff582AFF) : Colors.transparent,
            border: Border.all(
              color: selection ? Colors.transparent : const Color(0xff582AFF),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Center(
              child: Text(
                widget.title,
                style: TextStyle(
                  fontFamily: 'SFProRound',
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 11,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
