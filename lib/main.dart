import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onboarding/data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      home: SliderPage(),
    );
  }
}

class SliderPage extends StatefulWidget {
  const SliderPage({Key? key}) : super(key: key);

  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  CarouselController _carouselController = CarouselController();
  int currentSlider = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffECF8FF),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1.0,
                height: MediaQuery.of(context).size.height,
                initialPage: 0,
                enableInfiniteScroll: false,
                onPageChanged: (index, _) {
                  setState(() {
                    currentSlider = index;
                  });
                },
              ),
              carouselController: _carouselController,
              items: data.map((e) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(e["image"]),
                );
              }).toList(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 267,
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                  color: Color(0xffFBFDFF),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      data[currentSlider]["title"],
                      style: TextStyle(
                        color: Color(0xff3B4161),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      data[currentSlider]["desc"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff878F95),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CarouselIndicator(activePage: currentSlider),
            Positioned(
              bottom: 30,
              right: 30,
              child: GestureDetector(
                onTap: () {
                  _carouselController.nextPage(
                    duration: Duration(milliseconds: 300),
                  );
                },
                child: Image.asset(
                  "assets/next_icon.png",
                  width: 40,
                ),
              ),
            ),
            Positioned(
              right: 30,
              top: 32,
              child: InkWell(
                onTap: () {
                  _carouselController.animateToPage(2,
                      duration: Duration(milliseconds: 300));
                },
                child: Text(
                  "Skip",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            (currentSlider > 0)
                ? Positioned(
                    top: 35,
                    left: 38,
                    child: InkWell(
                      onTap: () {
                        _carouselController.previousPage(
                          duration: Duration(milliseconds: 300),
                        );
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 14,
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

class CarouselIndicator extends StatelessWidget {
  const CarouselIndicator({
    Key? key,
    required this.activePage,
  }) : super(key: key);

  final int activePage;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 30,
      bottom: 48,
      child: Container(
        height: 4,
        width: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [0, 1, 2].map((e) {
            return Container(
              height: 4,
              width: (e == activePage) ? 18 : 12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color:
                    (e == activePage) ? Color(0xff6686D8) : Color(0xffCBD6F3),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
