import 'package:flutter/material.dart';
import 'package:hacker_news/bloc/get_top_stories_bloc.dart';
import 'package:hacker_news/screens/home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  AnimationController _controller;

  Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 4000), vsync: this, value: 0.1);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOutQuint);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });

    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed && mounted) {
        topStoryBloc..topStories();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage())); }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.orange,
        body: Stack(
          children: <Widget>[
            Center(
              child: ScaleTransition(
                  scale: _animation,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black12,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 2),
                                blurRadius: 20,
                              )
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image(image: NetworkImage("https://miro.medium.com/max/700/1*Odj6BW8rfq-gExKp_rJrdA.png"),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Hacker News",

                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}