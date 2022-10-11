import 'package:flutter/material.dart';
import 'package:music_api/proxy.dart';

class ProxyPage extends StatefulWidget {
  const ProxyPage({Key? key}) : super(key: key);

  @override
  _ProxyPageState createState() => _ProxyPageState();
}

class _ProxyPageState extends State<ProxyPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Text("这里启动一个代理服务器，\n用于WEB页面的跨域请求，\n暂时地址是写死的，以后再改了\n在本地启动此服务之后，\nweb版即可正常使用"),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cast),
              Container(width: 16),
              SizedBox(
                width: 120,
                child: Text('${Proxy.ip()}:${Proxy.port()}', style: const TextStyle(fontSize: 20)),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 16, bottom: 16),
            child: TextButton(
              onPressed: () async {
                Proxy.startServer(address: '0.0.0.0', port: 3001).then((value) {
                  setState(() {});
                });
              },
              child: const Text('开启服务：3001', style: TextStyle(fontSize: 20)),
            ),
          ),
          TextButton(
            onPressed: () async {
              Proxy.stopServer()?.then((value) {
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
