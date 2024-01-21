import 'package:flutter/material.dart';
import 'package:gg_poker/model/user_item.dart';
import 'package:gg_poker/pages/game_page.dart';
import 'package:gg_poker/pages/home_page.dart';

UserItem user = UserItem(money: 5000, musicOn: true);

class BidPage extends StatefulWidget {
  const BidPage({super.key});

  @override
  State<BidPage> createState() => _BidPageState();
}

class _BidPageState extends State<BidPage> {
  List<String> userBid = [];
  int userBidNumber = 0;
  Map<String, int> chips = {
    'assets/10.png': 10,
    'assets/50.png': 50,
    'assets/100.png': 100,
    'assets/200.png': 200,
    'assets/500.png': 500,
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF171717),
      body: Column(
        children: [
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
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                                color: const Color(0xFFBD2F2A),
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
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
                                          padding:
                                              const EdgeInsets.only(top: 8),
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
                                              padding: const EdgeInsets.only(
                                                  top: 17),
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF504747),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
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
                      ],
                    )
                  ]),
            ),
          ),
          Expanded(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 64, bottom: 84),
                child: Row(
                  children: [
                    getBid().isEmpty
                        ? const SizedBox(
                            height: 150,
                            width: 150,
                          )
                        : Stack(clipBehavior: Clip.none, children: getBid()),
                    Padding(
                      padding: const EdgeInsets.only(left: 100),
                      child: Text(
                        '\$${userBidNumber.toString()}',
                        style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 36),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 21),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          if ((user.money! - userBidNumber) >= 10) {
                            userBid.add('assets/10.png');
                            userBidNumber = userBidNumber + 10;
                          }
                          setState(() {});
                        },
                        child: (user.money! - userBidNumber) <= 10
                            ? Image.asset('assets/501.png')
                            : Image.asset('assets/10.png')),
                    const SizedBox(
                      width: 7,
                    ),
                    InkWell(
                        onTap: () {
                          if ((user.money! - userBidNumber) >= 50) {
                            userBid.add('assets/50.png');
                            userBidNumber = userBidNumber + 50;
                          }
                          setState(() {});
                        },
                        child: (user.money! - userBidNumber) <= 50
                            ? Image.asset('assets/502.png')
                            : Image.asset('assets/50.png')),
                    const SizedBox(
                      width: 7,
                    ),
                    InkWell(
                        onTap: () {
                          if ((user.money! - userBidNumber) >= 100) {
                            userBid.add('assets/100.png');
                            userBidNumber = userBidNumber + 100;
                          }
                          setState(() {});
                        },
                        child: (user.money! - userBidNumber) <= 100
                            ? Image.asset('assets/503.png')
                            : Image.asset('assets/100.png')),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                        if ((user.money! - userBidNumber) >= 200) {
                          userBid.add('assets/200.png');
                          userBidNumber = userBidNumber + 200;
                        }
                        setState(() {});
                      },
                      child: (user.money! - userBidNumber) <= 200
                          ? Image.asset('assets/504.png')
                          : Image.asset('assets/200.png')),
                  const SizedBox(
                    width: 7,
                  ),
                  InkWell(
                      onTap: () {
                        if ((user.money! - userBidNumber) >= 500) {
                          userBid.add('assets/500.png');
                          userBidNumber = userBidNumber + 500;
                        }
                        setState(() {});
                      },
                      child: (user.money! - userBidNumber) <= 500
                          ? Image.asset('assets/505.png')
                          : Image.asset('assets/500.png')),
                ],
              )
            ],
          )),
          Container(
            padding: const EdgeInsets.only(top: 40),
            height: 164,
            color: const Color(0xFF262525),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      int userBidCount = user.money!;
                      do {
                        if (userBidCount >= 500) {
                          userBidCount = userBidCount - 500;
                          userBid.add('assets/500.png');
                          userBidNumber = userBidNumber + 500;
                        } else if (userBidCount >= 200) {
                          userBidCount = userBidCount - 200;
                          userBid.add('assets/200.png');
                          userBidNumber = userBidNumber + 200;
                        } else if (userBidCount >= 100) {
                          userBidCount = userBidCount - 100;
                          userBid.add('assets/100.png');
                          userBidNumber = userBidNumber + 100;
                        } else if (userBidCount >= 50) {
                          userBidCount = userBidCount - 50;
                          userBid.add('assets/50.png');
                          userBidNumber = userBidNumber + 50;
                        } else if (userBidCount >= 10) {
                          userBidCount = userBidCount - 10;
                          userBid.add('assets/10.png');
                          userBidNumber = userBidNumber + 10;
                        }
                      } while (userBidCount > 0);

                      // chips.forEach((key, value) {
                      //   if (userBidCount >= 500) {
                      //     userBidCount = userBidCount - 500;
                      //     userBid.add('assets/500.png');
                      //     userBidNumber = userBidNumber + 500;
                      //   }
                      //   setState(() {});
                      // });

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
                          Image.asset('assets/allIn.png'),
                          const SizedBox(
                            width: 7,
                          ),
                          const Text(
                            'All in',
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
                      if (userBidNumber != 0) {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                              builder: (BuildContext context) => GamePage(
                                    userBid: userBidNumber,
                                  )),
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: const Color(0xFFBD2F2A),
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/deal.png'),
                          const SizedBox(
                            width: 7,
                          ),
                          const Text(
                            'Deal',
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
            ),
          )
        ],
      ),
    );
  }

  List<Widget> getBid() {
    List<Widget> list = [];
    double left = 10;
    int count = 0;
    for (var card in userBid) {
      count++;
      if (card == userBid[0] && count == 1) {
        list.add(InkWell(
          onTap: () {
            userBid.remove(card);
            if (card == 'assets/10.png') {
              userBidNumber = userBidNumber - 10;
            } else if (card == 'assets/20.png') {
              userBidNumber = userBidNumber - 20;
            } else if (card == 'assets/50.png') {
              userBidNumber = userBidNumber - 50;
            } else if (card == 'assets/100.png') {
              userBidNumber = userBidNumber - 100;
            } else if (card == 'assets/200.png') {
              userBidNumber = userBidNumber - 200;
            } else if (card == 'assets/500.png') {
              userBidNumber = userBidNumber - 500;
            }
            setState(() {});
          },
          child: SizedBox(
            height: 150,
            child: Image.asset(card),
          ),
        ));
      } else if (card == userBid[1]) {
        list.add(Positioned(
            left: left,
            child: InkWell(
              onTap: () {
                userBid.remove(card);
                if (card == 'assets/10.png') {
                  userBidNumber = userBidNumber - 10;
                } else if (card == 'assets/20.png') {
                  userBidNumber = userBidNumber - 20;
                } else if (card == 'assets/50.png') {
                  userBidNumber = userBidNumber - 50;
                } else if (card == 'assets/100.png') {
                  userBidNumber = userBidNumber - 100;
                } else if (card == 'assets/200.png') {
                  userBidNumber = userBidNumber - 200;
                } else if (card == 'assets/500.png') {
                  userBidNumber = userBidNumber - 500;
                }
                setState(() {});
              },
              child: SizedBox(
                height: 150,
                child: Image.asset(card),
              ),
            )));
      } else {
        left = left + 10;
        list.add(Positioned(
            left: left,
            child: InkWell(
              onTap: () {
                userBid.remove(card);
                if (card == 'assets/10.png') {
                  userBidNumber = userBidNumber - 10;
                } else if (card == 'assets/20.png') {
                  userBidNumber = userBidNumber - 20;
                } else if (card == 'assets/50.png') {
                  userBidNumber = userBidNumber - 50;
                } else if (card == 'assets/100.png') {
                  userBidNumber = userBidNumber - 100;
                } else if (card == 'assets/200.png') {
                  userBidNumber = userBidNumber - 200;
                } else if (card == 'assets/500.png') {
                  userBidNumber = userBidNumber - 500;
                }
                setState(() {});
              },
              child: SizedBox(
                height: 150,
                child: Image.asset(card),
              ),
            )));
      }
    }
    return list;
  }
}
