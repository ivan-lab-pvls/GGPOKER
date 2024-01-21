import 'dart:convert';
import 'dart:math';

import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gg_poker/model/user_item.dart';
import 'package:gg_poker/pages/bid_page.dart';
import 'package:gg_poker/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key, required this.userBid});
  final int userBid;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  Map<String, int> deck = {
    'assets/2C.png': 2,
    'assets/2D.png': 2,
    'assets/2H.png': 2,
    'assets/2S.png': 2,
    'assets/3C.png': 3,
    'assets/3D.png': 3,
    'assets/3H.png': 3,
    'assets/3S.png': 3,
    'assets/4C.png': 4,
    'assets/4D.png': 4,
    'assets/4H.png': 4,
    'assets/4S.png': 4,
    'assets/5C.png': 5,
    'assets/5D.png': 5,
    'assets/5H.png': 5,
    'assets/5S.png': 5,
    'assets/6C.png': 6,
    'assets/6D.png': 6,
    'assets/6H.png': 6,
    'assets/6S.png': 6,
    'assets/7C.png': 7,
    'assets/7D.png': 7,
    'assets/7H.png': 7,
    'assets/7S.png': 7,
    'assets/8C.png': 8,
    'assets/8D.png': 8,
    'assets/8H.png': 8,
    'assets/8S.png': 8,
    'assets/9C.png': 9,
    'assets/9D.png': 9,
    'assets/9H.png': 9,
    'assets/9S.png': 9,
    'assets/10C.png': 10,
    'assets/10D.png': 10,
    'assets/10H.png': 10,
    'assets/10S.png': 10,
    'assets/jC.png': 10,
    'assets/jD.png': 10,
    'assets/jH.png': 10,
    'assets/jS.png': 10,
    'assets/qC.png': 10,
    'assets/qD.png': 10,
    'assets/qH.png': 10,
    'assets/qS.png': 10,
    'assets/kC.png': 10,
    'assets/kD.png': 10,
    'assets/kH.png': 10,
    'assets/kS.png': 10,
    'assets/aC.png': 11,
    'assets/aD.png': 11,
    'assets/aH.png': 11,
    'assets/aS.png': 11,
  };
  // My cards
  List<Image> dealersCards = [];
  List<Image> myCards = [];

  //Dealers Cards
  String? dealersFirstCard;
  String? dealersSecondCard;

  //My Cards
  String? myFirstCard;
  String? mySecondCard;

  //Scores
  int dealersScore = 0;
  int myScore = 0;
  Map<String, int> playingCards = {};
  Random random = Random();
  final FlipCardController _controller = FlipCardController();

  // Reset the cards and reset the rounds
  void changeCards() {
    dealersCards.clear();
    myCards.clear();
    playingCards.clear();
    playingCards.addAll(deck);

    // Getting the dealers card
    dealersFirstCard =
        playingCards.keys.elementAt(random.nextInt(playingCards.keys.length));
    playingCards.removeWhere((key, value) => key == dealersFirstCard);
    dealersSecondCard =
        playingCards.keys.elementAt(random.nextInt(playingCards.keys.length));
    playingCards.removeWhere((key, value) => key == dealersSecondCard);

    // getting the players card
    myFirstCard =
        playingCards.keys.elementAt(random.nextInt(playingCards.keys.length));
    playingCards.removeWhere((key, value) => key == myFirstCard);
    mySecondCard =
        playingCards.keys.elementAt(random.nextInt(playingCards.keys.length));
    playingCards.removeWhere((key, value) => key == mySecondCard);

    // Adding the image assets to the lists
    dealersCards.add(Image.asset(dealersFirstCard!));
    dealersCards.add(Image.asset(dealersSecondCard!));
    myCards.add(Image.asset(myFirstCard!));
    myCards.add(Image.asset(mySecondCard!));

    // Calculating the scores
    dealersScore = deck[dealersFirstCard]!;
    myScore = deck[myFirstCard]! + deck[mySecondCard]!;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    changeCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF262525),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 95,
                  padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
                  decoration: const BoxDecoration(color: Color(0xFF262525)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Dialog(
                                          backgroundColor: Colors.transparent,
                                          elevation: 0,
                                          child: Column(
                                            children: [
                                              const Text(
                                                'Pause',
                                                style: TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontSize: 36,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  width: 171,
                                                  height: 54,
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFFBD2F2A),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image.asset(
                                                            'assets/repeat.png'),
                                                        const Text(
                                                          'Back to game',
                                                          style: TextStyle(
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 16,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ]),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8),
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    Navigator.of(context)
                                                        .pushReplacement(
                                                      MaterialPageRoute<void>(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              const HomePage()),
                                                    );
                                                  },
                                                  child: Container(
                                                    width: 171,
                                                    height: 54,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 17),
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xFF504747),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
                                                    child: const Text('Menu',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16,
                                                          color: Colors.white,
                                                        )),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    );
                                  });
                            },
                            child: Row(
                              children: [
                                Image.asset('assets/menu.png'),
                                const SizedBox(
                                  width: 8,
                                ),
                                Image.asset('assets/logoInBar.png'),
                              ],
                            ),
                          ),
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
                              InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return StatefulBuilder(
                                              builder: (context, setstate) {
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Dialog(
                                                  child: Column(
                                                    children: [
                                                      Stack(
                                                        clipBehavior: Clip.none,
                                                        alignment:
                                                            Alignment.topCenter,
                                                        children: [
                                                          Container(
                                                            width:
                                                                double.infinity,
                                                            height: 306,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            14),
                                                                gradient: const LinearGradient(
                                                                    end: Alignment
                                                                        .bottomCenter,
                                                                    begin: Alignment.topCenter,
                                                                    colors: [
                                                                      Color(
                                                                          0xFF464242),
                                                                      Color(
                                                                          0xFF262525)
                                                                    ])),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 15),
                                                              child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          bottom:
                                                                              28),
                                                                      child: Image
                                                                          .asset(
                                                                              'assets/profile2.png'),
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        user.musicOn =
                                                                            !user.musicOn!;
                                                                        setstate(
                                                                            () {});
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            171,
                                                                        height:
                                                                            54,
                                                                        decoration: BoxDecoration(
                                                                            color: user.musicOn!
                                                                                ? const Color(0xFFBD2F2A)
                                                                                : const Color(0xFF8E9097),
                                                                            borderRadius: BorderRadius.circular(12)),
                                                                        child: Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Image.asset('assets/repeat.png'),
                                                                              Text(
                                                                                user.musicOn! ? 'Music ON' : 'Music OFF',
                                                                                style: const TextStyle(
                                                                                  fontFamily: 'Inter',
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontSize: 16,
                                                                                  color: Colors.white,
                                                                                ),
                                                                              )
                                                                            ]),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                              8),
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                          Navigator.of(context)
                                                                              .pushReplacement(
                                                                            MaterialPageRoute<void>(builder: (BuildContext context) => const HomePage()),
                                                                          );
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              171,
                                                                          height:
                                                                              54,
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              top: 17),
                                                                          decoration: BoxDecoration(
                                                                              color: const Color(0xFF504747),
                                                                              borderRadius: BorderRadius.circular(12)),
                                                                          child: const Text(
                                                                              'Privacy Policy',
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                fontFamily: 'Inter',
                                                                                fontWeight: FontWeight.w600,
                                                                                fontSize: 16,
                                                                                color: Colors.white,
                                                                              )),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ]),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            top: -20,
                                                            right: -15,
                                                            child: Container(
                                                              height: 44,
                                                              width: 44,
                                                              decoration: BoxDecoration(
                                                                  color: const Color(
                                                                      0xFFDBB23C),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12)),
                                                              child: const Icon(
                                                                Icons.close,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          });
                                        });
                                  },
                                  child: Image.asset('assets/profile.png'))
                            ],
                          )
                        ]),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 54,
                        decoration:
                            const BoxDecoration(color: Color(0xFF262525)),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: getDealersCards(),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 44),
                        child: Container(
                          width: 74,
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color(0xFF504747)),
                          child: Text(
                            dealersScore.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Container(
                          width: 74,
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color(0xFF504747)),
                          child: Text(
                            myScore.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: getMyCards(),
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: Row(children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                String newCard = playingCards.keys.elementAt(
                                    random.nextInt(playingCards.keys.length));
                                myCards.add(Image.asset(newCard));
                                playingCards.removeWhere(
                                    (key, value) => key == newCard);
                                myScore = myScore + deck[newCard]!;
                                setState(() {});
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: const Color(0xFFBD2F2A),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/hit_button.png'),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    const Text(
                                      'Hit',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                _controller.toggleCard();
                                dealersScore =
                                    myScore + deck[dealersSecondCard]!;
                                if (dealersScore < 19) {
                                  String newCard = playingCards.keys.elementAt(
                                      random.nextInt(playingCards.keys.length));
                                  dealersCards.add(Image.asset(newCard));
                                  playingCards.removeWhere(
                                      (key, value) => key == newCard);
                                  dealersScore = myScore + deck[newCard]!;
                                }

                                Future.delayed(
                                    const Duration(milliseconds: 1000), () {
                                  if (dealersScore > 21 && myScore < 21) {
                                    return goodDialog(context);
                                  } else if (myScore == 21) {
                                    return goodDialog(context);
                                  } else if (myScore == dealersScore) {
                                    return goodDialog(context);
                                  } else if (myScore > 21) {
                                    return badDialog(context);
                                  } else if ((21 - dealersScore) >
                                      (21 - myScore)) {
                                    return goodDialog(context);
                                  } else if ((21 - dealersScore) <
                                      (21 - myScore)) {
                                    return badDialog(context);
                                  }
                                });
                                setState(() {});
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: const Color(0xFFBD2F2A),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/stand_button.png'),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    const Text(
                                      'Stand',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Positioned(right: 0, child: Image.asset('assets/deck.png'))
          ],
        ),
      ),
    );
  }

  Future<dynamic> goodDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Dialog(
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 306,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              gradient: const LinearGradient(
                                  end: Alignment.bottomCenter,
                                  begin: Alignment.topCenter,
                                  colors: [
                                    Color(0xFF464242),
                                    Color(0xFF262525)
                                  ])),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Column(children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 15),
                                child: DefaultTextStyle(
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                    child: Text('Good play!')),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Container(
                                  width: 125,
                                  padding: const EdgeInsets.only(
                                    top: 6,
                                    bottom: 6,
                                  ),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF504747),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const DefaultTextStyle(
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                          child: Text('+')),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Image.asset('assets/gold.png'),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      DefaultTextStyle(
                                          style: const TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                          child: Text(
                                            (widget.userBid * 2).toString(),
                                            style: const TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  user.money =
                                      user.money! + (widget.userBid * 2);
                                  Navigator.pop(context);
                                  if (user.money != 0 &&
                                      user.money! >= widget.userBid) {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              GamePage(
                                                userBid: widget.userBid,
                                              )),
                                    );
                                  } else {
                                    notEnoughChipsDialog(context);
                                  }
                                  addSP(user);
                                },
                                child: Container(
                                  width: 171,
                                  height: 54,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFBD2F2A),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset('assets/repeat.png'),
                                        const Text(
                                          'Repeat game',
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: InkWell(
                                  onTap: () {
                                    user.money =
                                        user.money! + (widget.userBid * 2);
                                    Navigator.pop(context);

                                    addSP(user);
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              const HomePage()),
                                    );
                                  },
                                  child: Container(
                                    width: 171,
                                    height: 54,
                                    padding: const EdgeInsets.only(top: 17),
                                    decoration: BoxDecoration(
                                        color: const Color(0xFF504747),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: const Text('Menu',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.white,
                                        )),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                        Positioned(
                          top: -80,
                          child: Image.asset('assets/gold2.png'),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  Future<dynamic> badDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Dialog(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 306,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          gradient: const LinearGradient(
                              end: Alignment.bottomCenter,
                              begin: Alignment.topCenter,
                              colors: [Color(0xFF464242), Color(0xFF262525)])),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 15),
                                child: DefaultTextStyle(
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                    child: Text(
                                      'Oops!\nTry again to win',
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Container(
                                  width: 125,
                                  padding: const EdgeInsets.only(
                                    top: 6,
                                    bottom: 6,
                                  ),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF504747),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const DefaultTextStyle(
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                          child: Text('-')),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Image.asset('assets/gold.png'),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      DefaultTextStyle(
                                          style: const TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                          child: Text(
                                            widget.userBid.toString(),
                                            style: const TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  user.money = user.money! - widget.userBid;
                                  Navigator.pop(context);
                                  if (user.money != 0 &&
                                      user.money! >= widget.userBid) {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              GamePage(
                                                userBid: widget.userBid,
                                              )),
                                    );
                                  } else {
                                    notEnoughChipsDialog(context);
                                  }
                                  addSP(user);
                                },
                                child: Container(
                                  width: 171,
                                  height: 54,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFBD2F2A),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset('assets/repeat.png'),
                                        const Text(
                                          'Repeat game',
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: InkWell(
                                  onTap: () {
                                    user.money = user.money! - widget.userBid;
                                    Navigator.pop(context);
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              const HomePage()),
                                    );
                                    addSP(user);
                                  },
                                  child: Container(
                                    width: 171,
                                    height: 54,
                                    padding: const EdgeInsets.only(top: 17),
                                    decoration: BoxDecoration(
                                        color: const Color(0xFF504747),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: const Text('Menu',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.white,
                                        )),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  void notEnoughChipsDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Dialog(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          gradient: const LinearGradient(
                              end: Alignment.bottomCenter,
                              begin: Alignment.topCenter,
                              colors: [Color(0xFF464242), Color(0xFF262525)])),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 15),
                                child: DefaultTextStyle(
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                    child: Text(
                                      'Oops!\nYou\'ve run out of chips.',
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);

                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            const HomePage()),
                                  );
                                },
                                child: Container(
                                  width: 171,
                                  height: 54,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFBD2F2A),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset('assets/repeat.png'),
                                        const Text(
                                          'Return to menu',
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  List<Widget> getDealersCards() {
    List<Widget> list = [];
    double left = 20;
    double top = -10;
    for (var card in dealersCards) {
      if (card == dealersCards[0]) {
        list.add(SizedBox(
          height: 150,
          child: card,
        ));
      } else if (card == dealersCards[1]) {
        list.add(Positioned(
            left: left,
            top: top,
            child: SizedBox(
                height: 150,
                child: FlipCard(
                  side: CardSide.BACK,
                  flipOnTouch: false,
                  controller: _controller,
                  front: card,
                  back: Image.asset('assets/back.png'),
                ))));
      } else {
        left = left + 20;
        top = top - 10;
        list.add(Positioned(
            left: left,
            top: top,
            child: SizedBox(
                height: 150,
                child: FlipCard(
                  flipOnTouch: false,
                  side: CardSide.FRONT,
                  controller: _controller,
                  front: card,
                  back: Image.asset('assets/back.png'),
                ))));
      }
    }
    return list;
  }

  List<Widget> getMyCards() {
    List<Widget> list = [];
    double left = 20;
    double top = -10;
    for (var card in myCards) {
      if (card == myCards[0]) {
        list.add(SizedBox(height: 150, child: card));
      } else if (card == myCards[1]) {
        list.add(Positioned(
            left: left, top: top, child: SizedBox(height: 150, child: card)));
      } else {
        left = left + 20;
        top = top - 10;
        list.add(Positioned(
            left: left, top: top, child: SizedBox(height: 150, child: card)));
      }
    }
    return list;
  }

  Future<void> addSP(UserItem? user) async {
    final prefs = await SharedPreferences.getInstance();

    String rawJson6 = jsonEncode(user!.toJson());
    prefs.setString('user', rawJson6);
  }
}
