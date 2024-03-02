import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:mathocr_flutter/drag.dart';
import 'package:mathocr_flutter/euqation.dart';
import 'package:mathocr_flutter/head.dart';
import 'package:mathocr_flutter/net.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});
  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  List<String> equations = List.empty(growable: true);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        alignment: Alignment.topCenter,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover,
              opacity: 0.2),
        ),
        child: FractionallySizedBox(
          widthFactor: 0.9,
          heightFactor: 0.9,
          child: SingleChildScrollView(
            child: Wrap(
              direction: Axis.vertical,
              spacing: 20,
              children: <Widget>[
                const Head(),
                SizedBox(
                  height: height * 0.4,
                  child: DragZone(
                    f: (xt) async {
                      for (XFile x in xt) {
                        var res = await netPredict(
                            x.name, x.mimeType, await x.readAsBytes());
                        setState(() {
                          equations.add(res
                              .substring(1, res.length - 1)
                              .replaceAll('\\\\', '\\'));
                        });
                      }
                      xt.clear();
                    },
                  ),
                ),
                ...equations.asMap().keys.map((key) => Equation(
                      equation: equations[key],
                      number: key + 1,
                      d: (x) => {
                        setState(() {
                          equations.removeAt(x - 1);
                        })
                      },
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
