import 'package:universal_io/io.dart';

import 'package:music_api/api/utils/answer.dart';

typedef Api = Future<Answer> Function(Map query, List<Cookie> cookie);
