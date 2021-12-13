import 'package:flutter/material.dart';
import 'package:music_api/api/baidu/baidu.dart';
import 'package:music_api/api/kugou/kugou.dart';
import 'package:music_api/api/my_free_mp3/my_free_mp3.dart';

class KuGouPage extends StatefulWidget {
  const KuGouPage({Key? key}) : super(key: key);

  @override
  _KuGouPageState createState() => _KuGouPageState();
}

class _KuGouPageState extends State<KuGouPage> with AutomaticKeepAliveClientMixin {
  String result = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 150.0,
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12, width: 1),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                child: Text(result, style: const TextStyle(fontSize: 16)),
              ),
            ),
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 40),
                children: [
                  ListTile(
                    title: const Text('Banner'),
                    onTap: () {
                      KuGou?.banner().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('新歌推荐'),
                    onTap: () {
                      KuGou?.musicList().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('推荐歌单'),
                    onTap: () {
                      KuGou?.playList().then(onData).catchError(onError);
                    },
                  ),
                  ListTile(
                    title: const Text('歌单详情'),
                    onTap: () {
                      KuGou?.playListInfo(id: "4099219").then(onData).catchError(onError);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void onData(value) {
    setState(() {
      result = value.body.toString();
    });
  }

  void onError(e) {
    setState(() {
      result = e.toString();
    });
  }
}
