import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'dart:math';
import 'package:flutter/services.dart';

class Equation extends StatefulWidget {
  Equation(
      {super.key,
      required this.equation,
      required this.number,
      required this.d});
  final String equation;
  final int number;
  void Function(int x) d;
  @override
  State<Equation> createState() => _EquationState();
}

class _EquationState extends State<Equation> {
  String equation = "";
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if (equation == "") {
      equation = widget.equation;
    }
    return Container(
        padding: const EdgeInsets.all(10),
        height: max(height * 0.1, 110),
        width: width * 0.9,
        decoration: const BoxDecoration(
//背景
          color: Color.fromRGBO(255, 255, 255, 200),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        // color: _dragging ? Colors.blue.withOpacity(0.4) : Colors.black26,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("公式${widget.number}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: min((width / 20.0), 20.0))),
              SizedBox(
                width: width * 0.05 + width * width * 0.00017,
                child: TextFormField(
                  initialValue: widget.equation,
                  style: TextStyle(fontSize: min((width / 20.0), 20.0)),
                  decoration: InputDecoration(
                      labelText: "修改公式",
                      labelStyle:
                          TextStyle(fontSize: min((width / 20.0), 20.0)),
                      hintText: "例如：x=f(x)"),
                  onChanged: (value) {
                    setState(() {
                      if (value.isEmpty) {
                        equation = "请输入公式";
                      } else {
                        equation = value;
                      }
                    });
                  },
                ),
              ),
              Math.tex(
                equation,
                mathStyle: MathStyle.display,
                textStyle: TextStyle(fontSize: min((width / 30.0), 30)),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: equation));
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.copy,
                        ),
                        Text("Latex")
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await Clipboard.setData(
                          ClipboardData(text: "\$$equation\$"));
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.copy,
                        ),
                        Text("MD")
                      ],
                    ),
                  ),
                ],
              ),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     ElevatedButton(
              //       onPressed: () {},
              //       child: const Row(
              //         children: [
              //           Icon(
              //             Icons.download,
              //           ),
              //           Text("PNG")
              //         ],
              //       ),
              //     ),
              //     ElevatedButton(
              //       onPressed: () {},
              //       child: const Row(
              //         children: [
              //           Icon(
              //             Icons.download,
              //           ),
              //           Text("SVG")
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
            ]));
  }
}
