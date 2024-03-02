import 'package:flutter/material.dart';
import 'package:mathocr_flutter/app.dart';
import 'package:mathocr_flutter/head.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MathOCR',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'MathOCR Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    var whiteTitleStyle = TextStyle(
      color: Colors.white,
      fontSize: min(width / 10, 70),
      fontWeight: FontWeight.bold,
    );
    var blueTitleStyle = TextStyle(
      color: const Color.fromRGBO(0x1c, 0xb3, 0xf3, 1),
      fontSize: min(width / 10, 70),
      fontWeight: FontWeight.bold,
    );
    var whiteTextStyle = TextStyle(
      color: Colors.white,
      fontSize: min(width / 20, 30),
    );
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover,
              opacity: 0.2),
        ),
        child: FractionallySizedBox(
          heightFactor: 0.9,
          widthFactor: 0.9,
          child: Column(
            children: <Widget>[
              const Head(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "将你从",
                          style: whiteTitleStyle,
                        ),
                        Text(
                          "复杂的",
                          style: blueTitleStyle,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "数学公式",
                          style: blueTitleStyle,
                        ),
                        Text(
                          "解放出来",
                          style: whiteTitleStyle,
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.all(18)),
                    Text(
                      "使用MathOCR轻松识别PDF/网页中的数学公式",
                      style: whiteTextStyle,
                    ),
                    const Padding(padding: EdgeInsets.all(18)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color(0xff1cb3f3),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const AppPage(),
                              ),
                            );
                          },
                          child: Text(
                            "进入应用",
                            style: whiteTextStyle,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(18)),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color(0x77787eff),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            "浏览文档",
                            style: whiteTextStyle,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
