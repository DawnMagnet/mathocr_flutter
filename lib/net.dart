import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

String API_BASE_URL = "https://mathocr.dawnmagnet.xyz";
Future<String> netPredict(String name, String? mimeType, List<int> data) async {
  final url = Uri.parse('$API_BASE_URL/predict/');

  final req = http.MultipartRequest('POST', url)
    ..files.add(http.MultipartFile.fromBytes("file", data,
        contentType: mimeType != null ? MediaType.parse(mimeType) : null,
        filename: name));

  req.headers['content-type'] = 'multipart/form-data';

  final stream = await req.send();
  final res = await http.Response.fromStream(stream);
  final status = res.statusCode;
  if (status != 200) {
    return "NETERROR";
  }
  return res.body;
}
