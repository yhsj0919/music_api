import 'dart:async';

import 'package:flutter/services.dart';

import 'api/my_free_mp3/my_free_mp3.dart';
import 'api/my_free_mp3/my_free_mp3.dart';

class MusicApi {
  MusicApi._();

  static Future search({required String keyWords, int page = 0}) {
    return MyFreeMp3.search(keyWords: keyWords, page: page);
  }
}
