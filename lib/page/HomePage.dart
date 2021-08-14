import 'package:demo/page/BankPage.dart';
import 'package:demo/page/MinePage.dart';
import 'package:demo/page/SearchPage.dart';
import 'package:demo/utils/AppVersion.dart';
import 'package:demo/widget/PlayRow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget{

  static HomePage _instance = HomePage._internal();

  final HomePageState state = HomePageState();

  factory HomePage() => _instance;

  HomePage._internal(){
    // todo
  }

  @override
  State createState() {
    return HomePageState();
  }


}

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  final List<String> _title = ["排行榜","我的","搜索"];
  final List<Widget> _page  = [BankPage(),MinePage(),SearchPage()];
  final List<Align> _tabs   = [];
  double screenHeight = 0,appBarViewHeight = 0;

  TabController? _controller;


  @override
  void initState() {
    super.initState();
    Alignment align = Alignment.center;
    for(var i = 0; i < _title.length; i++){
      switch(i){
        case 0:
          align = Alignment.centerRight;
          break;
        case 1:
          align = Alignment.center;
          break;
        case 2:
          align = Alignment.centerLeft;
          break;
      }
      _tabs.add(Align(alignment:align,child: Text(_title[i])));

    }
    _controller = TabController(length: _title.length, vsync: this,initialIndex: 1);

  }

  @override
  Widget build(BuildContext context) {
    if(screenHeight == 0){
      screenHeight = MediaQuery.of(context).size.height;
      appBarViewHeight = screenHeight - AppBar().preferredSize.height - MediaQuery.of(context).padding.top - 70;
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Theme(
            data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent
            ),
            child:TabBar(
                tabs: _tabs,
                indicatorColor: Colors.transparent,
                labelColor: Colors.black,
                labelPadding: EdgeInsets.zero,
                indicatorSize: TabBarIndicatorSize.label,
                unselectedLabelStyle: TextStyle(fontSize: 16),
                labelStyle: TextStyle(fontSize: 16.5,fontWeight: FontWeight.w500),
                controller: _controller,
                onTap: (index) => {
                  //print(index)
                },
            )),
        backgroundColor: Colors.white10,
        elevation: 0,
      ),
      body: Flex(
          direction: Axis.vertical,
          children: [
            SizedBox(
              height: appBarViewHeight,
              child: Column(
                children: [
                  Expanded(child: _getView(),flex: 1,)
                ],
              )
            ),
            PlayRow()
          ],
      )
    );
  }

  TabBarView _getView(){
    return TabBarView(
        //physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        children: _page,
    );
  }

}

/*
   1. Flutter 仅去掉TabBar水波纹效果
   https://www.jianshu.com/p/f36f0c4dec12

   2. Flutter——TabBar组件（顶部Tab切换组件）
   https://www.cnblogs.com/chichung/p/12012689.html

   3. 避免TabBarView中的Widget重载
   https://www.jianshu.com/p/52bacff37d78

   4. TabBarView禁止左右滑动
   http://bbs.itying.com/topic/6007ca34bb952e1090195fc6

   5. AppBarView设置高度（默认为body高度）
   https://www.appblog.cn/2019/01/20/Flutter%E4%B8%AD%E8%AE%BE%E7%BD%AETabBarView%E9%AB%98%E5%BA%A6/

   6. Flutter获取AppBar的高度
   https://www.tpyyes.com/a/flutter/1100.html

   7. flutter获取状态栏高度及安全区域
   https://www.cnblogs.com/pjl43/p/9906069.html

   8. flutter弹起键盘出现Overflow问题的解决方法
   Scaffold下添加：resizeToAvoidBottomInset: false,
 */