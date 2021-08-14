import 'package:demo/api/Constant.dart';
import 'package:demo/api/Service.dart';
import 'package:demo/model/Bank.dart';
import 'package:demo/model/Song.dart';
import 'package:demo/utils/CommonUtil.dart';
import 'package:demo/utils/MyAudio.dart';
import 'package:demo/widget/PlayRow.dart';
import 'package:demo/widget/ScrollViewSong.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BankMusicPage extends StatefulWidget{

  @override
  State createState() {
    return _BankMusicPageState();
  }
}

class _BankMusicPageState extends State<BankMusicPage>{

  final int itemSize = 20;
  Bank ?bank;
  int page   = 0,
      bankId = 0;
  List<int >status = [Constant.STATUS_DEFAULT];
  List<Song> data = [];
  bool isFirstLoaded = false;
  ScrollController _sc = ScrollController();

  @override
  void initState() {
    super.initState();
    _sc.addListener(() {
      if(_sc.position.pixels == _sc.position.maxScrollExtent){
        getMusicByBank();
      }
    });
  }

  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bank = ModalRoute.of(context)!.settings.arguments as Bank;
    bankId = int.parse(bank!.sourceid);
    if(!isFirstLoaded){
      getMusicByBank();
      isFirstLoaded = true;
    }
    return Scaffold(
        body: Builder(builder: (BuildContext context){
          return Flex(
            direction: Axis.vertical,
            children: [
              Expanded(child: ScrollViewSong(data:data, title:bank!.name, image:getAssetImage(), sc:_sc, status: status, scaffoldContext: context, call: (){

              }),flex: 1,),
              PlayRow()
            ],
          );
        })
    );
  }

  void getMusicByBank() async{
    if(status[0] == Constant.STATUS_LOADEDALL)
      return;


    setState(() {
      status[0] = Constant.STATUS_LOADING;
    });
    page++;
    List<Song> list = await Service().getMusicByBank(bankId, page, itemSize);

    setState(() {
      data.addAll(list);
      if(list.length < Constant.ATTR_ITEM_SIZE || data.length == Constant.ATTR_MAX_SIZE){
        status[0] = Constant.STATUS_LOADEDALL;
      }
      else{
        status[0] = Constant.STATUS_LOADING;
      }
    });

  }

  void play(BuildContext context,Song song,int index) async{
    MyAudio.play(context,song);
  }



  /*
    1. Flutter ListView 分页加载更多效果
    https://www.awaimai.com/2758.html

    2. Flutter ListTile、ExpansionTile 设置 leading 和 title之的间隔
    https://blog.csdn.net/m0_37973043/article/details/108519087
  */
}