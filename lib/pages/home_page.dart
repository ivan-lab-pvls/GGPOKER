import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gg_poker/model/user_item.dart';
import 'package:gg_poker/pages/bid_page.dart';
import 'package:gg_poker/pages/game_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? timer;
  @override
  void initState() {
    super.initState();
    getSP(() {
      setState(() {});
    });
    timer = Timer.periodic(
      const Duration(hours: 10),
      (timer) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF171717),
      body: Column(children: [
        Container(
          width: double.infinity,
          height: 95,
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: const BoxDecoration(color: Color(0xFF262525)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset('assets/logoInBar.png'),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, top: 6, bottom: 6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xFF504747)),
                        child: Row(children: [
                          Image.asset('assets/gold.png'),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            user.money!.toString(),
                            style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.white),
                          )
                        ]),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                    ],
                  )
                ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 22, bottom: 24),
          child: Image.asset('assets/image.png'),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => const BidPage()),
            );
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 0, 22, 24),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(21),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xFFAF222D), Colors.black]),
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 25),
                          child: Text(
                            'Black Jack',
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                        Container(
                          width: 117,
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          decoration: BoxDecoration(
                              color: const Color(0xFFDBB23C),
                              borderRadius: BorderRadius.circular(12)),
                          child: const Text(
                            'Play',
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ]),
                ),
                Positioned(
                    right: -15,
                    top: -35,
                    child: Image.asset('assets/cards.png'))
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(21),
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Color(0xFFAF222D), Colors.black]),
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 25),
                        child: Text(
                          'Fortune Bonus',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ),
                      Container(
                          width: 117,
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          decoration: BoxDecoration(
                              color: const Color(0xFF8E9097),
                              borderRadius: BorderRadius.circular(12)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomTimer(),
                            ],
                          ))
                    ]),
              ),
              Positioned(
                  right: 15, top: -15, child: Image.asset('assets/fortune.png'))
            ],
          ),
        ),
      ]),
    );
  }

  void getSP(Function() callback) async {
    final prefs = await SharedPreferences.getInstance();

    final rawJson6 = prefs.getString('user') ?? '';

    Map<String, dynamic> map6 = {};

    if (rawJson6.isNotEmpty) {
      map6 = jsonDecode(rawJson6);
    }

    if (map6.isNotEmpty) {
      user = UserItem.fromJson(map6);
    }
    callback();
  }
}

class CustomTimer extends StatefulWidget {
  const CustomTimer({super.key});

  @override
  _CustomTimerState createState() => _CustomTimerState();
}

class _CustomTimerState extends State<CustomTimer> {
  final interval = const Duration(seconds: 1);

  final int timerMaxSeconds = 36000;

  int currentSeconds = 0;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60 ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) ~/ 60 % 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  startTimeout([int? milliseconds]) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      if (mounted) {
        setState(() {
          currentSeconds = timer.tick;
          if (timer.tick >= timerMaxSeconds) timer.cancel();
        });
      }
    });
  }

  @override
  void initState() {
    startTimeout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          timerText,
          style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
