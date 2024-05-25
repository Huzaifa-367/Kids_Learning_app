import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:kids_learning_app/utils/model.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import 'Alphabet.dart';

class NumberSong extends StatefulWidget {
  const NumberSong({super.key});

  @override
  State<NumberSong> createState() => _NumberSongState();
}

List<Numbermodel> numbersongs1 = numbersongs();

class _NumberSongState extends State<NumberSong> {
  final FlutterTts flutterTts = FlutterTts();

  bool isPressed = false;
  Color istrue = Colors.green;
  Color isWrong = Colors.red;
  Color btnColor = Colors.blue;
  int score = 0;

  @override
  Widget build(BuildContext context) {
    PageController _controller = PageController(initialPage: 0);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.black, //change your color here
            ),
            backgroundColor: const Color(0xFFFEF7F0),
            title: const Center(
              child: Text(
                'Number',
                style: TextStyle(color: Colors.black, fontFamily: "arlrdbd"),
              ),
            )),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: PageView.builder(
                  controller: _controller,
                  onPageChanged: (page) {
                    isPressed = false;
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: numbersongs2.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 30.0,
                        ),
                        Image.asset("assets/images/volume.png"),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            numbersongs1[index].Text!,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 23.0,
                                fontFamily: "arlrdbd"),
                          ),
                        ),
                        const Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        Expanded(
                          child: GridView.count(
                            padding: const EdgeInsets.all(50),
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 15,
                            crossAxisCount: 2,
                            physics: const NeverScrollableScrollPhysics(),
                            primary: false,
                            children: [
                              for (int i = 0;
                                  i < numbersongs2[index].answer.length;
                                  i++)
                                MaterialButton(
                                  shape: BeveledRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  elevation: 5.0,
                                  height: 10,
                                  minWidth: double.infinity,
                                  color: isPressed
                                      ? numbersongs2[index]
                                              .answer
                                              .entries
                                              .toList()[i]
                                              .value
                                          ? istrue
                                          : isWrong
                                      : Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  onPressed: isPressed
                                      ? () {}
                                      : () {
                                          if (numbersongs2[index]
                                              .answer
                                              .entries
                                              .toList()[i]
                                              .value) {
                                            setState(() {
                                              isPressed = true;
                                            });
                                            score += 1;
                                            print(score);
                                            MotionToast.success(
                                              borderRadius: 5,
                                              animationDuration:
                                                  const Duration(seconds: 3),
                                              title: const Text(
                                                "Your Answer is Right",
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              description: const Text(''),
                                              iconType: IconType.cupertino,
                                            ).show(context);
                                          } else {
                                            setState(() {
                                              isPressed = true;
                                            });
                                            MotionToast.error(
                                              borderRadius: 5,
                                              animationDuration:
                                                  const Duration(seconds: 3),
                                              title: const Text(
                                                "Your Answer is Wrong",
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              description: const Text(''),
                                              iconType: IconType.cupertino,
                                            ).show(context);
                                          }
                                        },
                                  child: Image(
                                    image: AssetImage(numbersongs2[index]
                                        .answer
                                        .keys
                                        .toList()[i]),
                                    height: 100,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: () => flutterTts
                                      .speak(numbersongs1[index].Text!),
                                  child: Image.asset(
                                      'assets/images/11MaskGroup3.png')),
                              Center(
                                  child: ListTile(
                                trailing: InkWell(
                                  onTap: isPressed
                                      ? index + 1 == numberquestion.length
                                          ? () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ResultSrceen(score)));
                                            }
                                          : () {
                                              _controller.nextPage(
                                                  duration: const Duration(
                                                      microseconds: 500),
                                                  curve: Curves.linear);
                                              flutterTts.speak(
                                                  numbersongs1[index + 1]
                                                      .Text!);
                                            }
                                      : null,
                                  child: const Image(
                                    image: AssetImage(
                                        'assets/images/11MaskGroup5.png'),
                                  ),
                                ),
                                leading: InkWell(
                                  onTap: isPressed
                                      ? index - 1 == questions.length
                                          ? () {}
                                          : () {
                                              _controller.previousPage(
                                                  duration: const Duration(
                                                      microseconds: 500),
                                                  curve: Curves.linear);
                                              flutterTts.speak(
                                                  numbersongs1[index - 1]
                                                      .Text!);
                                            }
                                      : null,
                                  child: const Image(
                                    image: AssetImage(
                                        'assets/images/11MaskGroup4.png'),
                                  ),
                                ),
                              ))
                            ]),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}