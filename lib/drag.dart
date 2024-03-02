import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cross_file/cross_file.dart';
import 'dart:math';

class DragZone extends StatefulWidget {
  DragZone({super.key, required this.f});
  Future<void> Function(List<XFile> xt) f;

  @override
  State<DragZone> createState() => _DragZoneState();
}

class _DragZoneState extends State<DragZone> {
  List<XFile> files = List.empty(growable: true);

  bool _dragging = false;

  Offset? offset;

  List<XFile> getFiles() {
    return files;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return DropTarget(
      onDragDone: (detail) async {
        setState(() {
          files.addAll(detail.files);
          widget.f(files);
        });

        debugPrint('onDragDone:');
        for (final file in detail.files) {
          debugPrint('  ${file.path} ${file.name}'
              '  ${await file.lastModified()}'
              '  ${await file.length()}'
              '  ${file.mimeType}');
        }
      },
      onDragUpdated: (details) {
        setState(() {
          offset = details.localPosition;
        });
      },
      onDragEntered: (detail) {
        setState(() {
          _dragging = true;
          offset = detail.localPosition;
        });
      },
      onDragExited: (detail) {
        setState(() {
          _dragging = false;
          offset = null;
        });
      },
      child: GestureDetector(
        onTap: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles();
          if (result != null) {
            if (kIsWeb) {
              files.addAll(result.files.map((f) =>
                  XFile.fromData(f.bytes!, name: f.name, length: f.size)));
            } else {
              files.addAll(result.paths.nonNulls.map((f) => XFile(f)));
            }
            widget.f(files);
          }
        },
        child: Container(
          height: height * 0.4,
          width: width * 0.9,
          decoration: BoxDecoration(
//背景
            color: const Color.fromRGBO(255, 255, 255, 150),

            //设置四周圆角 角度
            borderRadius: const BorderRadius.all(Radius.circular(40.0)),
            //设置四周边框
            border: Border.all(
              width: 8,
              color: _dragging
                  ? const Color.fromARGB(255, 118, 90, 123)
                  : Colors.grey,
            ),
          ),
          // color: _dragging ? Colors.blue.withOpacity(0.4) : Colors.black26,
          child: Center(
              child: Text(
            _dragging ? "松开鼠标以上传文件" : "将你的文件拖拽或者点击此处上传",
            style: TextStyle(
              fontSize: min(width / 20, 30),
              color: Colors.black,
            ),
          )),
        ),
      ),
    );
  }
}
