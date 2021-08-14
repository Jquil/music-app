import 'package:demo/db/MyDB.dart';
import 'package:demo/db/sp/MySP.dart';
import 'package:demo/page/HomePage.dart';
import 'package:demo/provider/PlayStateProvider.dart';
import 'package:demo/provider/SongProvider.dart';
import 'package:demo/provider/SongQueueProvider.dart';
import 'package:demo/routers/MyRouter.dart';
import 'package:demo/utils/AppVersion.dart';
import 'package:demo/utils/MyAudio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlayStateProvider()),
        ChangeNotifierProvider(create: (_) => SongProvider()),
        ChangeNotifierProvider(create: (_) => SongQueueProvider()),
      ],
      child: MyApp(),
    ),
  );
  init();
  AppVersion.check();
}

void init() async{
  MyDB();
  MySP();
  MyAudio();
}
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    listen(context);
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'MyMusic App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      //initialRoute: MyRouter.HOME,
      routes: MyRouter.instance.getRoutes(context),
    );
  }

  void listen(BuildContext context) async{
    // 播放监听：0:00:00:000000
    MyAudio.player.onAudioPositionChanged.listen((event) {
      //print(event);
    });

    // 状态监听
    MyAudio.player.onPlayerStateChanged.listen((event) {
      context.read<PlayStateProvider>().setState(event);
    });

    // 播放完成
    MyAudio.player.onPlayerCompletion.listen((event) {
      context.read<SongQueueProvider>().next(context);
    });
  }

  /*
  存在问题：
    1. 下拉加载
      1.1 先显示加载完成，再显示正在加载
      1.2 设置加载最大数量，没起作用
  未实现：
    1. 底部播放栏 √
    2. 歌词页
    3. 播放队列
    4. 数据库部分
  UI：
    1. 排行榜
  * */
}