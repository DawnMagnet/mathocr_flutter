import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Head extends StatelessWidget {
  const Head({super.key});
  final String title = "MathOCR";
  final String iconPath = "assets/images/logo.png";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final height = size.height;
    final width = size.width;
    var buttonlist = <Widget>[];
    var urllist = [
      ("https://github.com/dawnmagnet/mathocr_flutter", "文档"),
      ("https://github.com/DawnMagnet/mathocr_flutter/releases", "应用下载"),
      ("https://github.com/dawnmagnet/mathocr_flutter", "快速教程")
    ];
    for (var i = 0; i < urllist.length; i++) {
      buttonlist.add(
        TextButton(
          onPressed: () {
            launchUrl(Uri.parse(urllist[i].$1));
          },
          child: Text(
            urllist[i].$2,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }
    return SizedBox(
      width: width * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // spacing: 6.0,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            iconPath,
            // height: height * 0.08,
            width: width * 0.3,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: buttonlist,
          )
        ],
      ),
    );
  }
}
