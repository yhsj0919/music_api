import 'package:flutter/material.dart';
import 'package:music_api/server.dart';

class ServerPage extends StatefulWidget {
  const ServerPage({Key? key}) : super(key: key);

  @override
  _ServerPageState createState() => _ServerPageState();
}

class _ServerPageState extends State<ServerPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Text("服务能单独使用，输入本机ip端口号即可访问"),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cast),
              Container(width: 16),
              SizedBox(
                width: 120,
                child: Text('${MusicServer.ip()}:${MusicServer.port()}', style: const TextStyle(fontSize: 20)),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 16, bottom: 16),
            child: TextButton(
              onPressed: () async {
                MusicServer.startServer(address: '0.0.0.0', port: 3001).then((value) {
                  setState(() {});
                });
              },
              child: const Text('开启服务：3001', style: TextStyle(fontSize: 20)),
            ),
          ),
          TextButton(
            onPressed: () async {
              MusicServer.stopServer()?.then((value) {
                setState(() {});
              });
            },
            child: const Text('关闭服务', style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
