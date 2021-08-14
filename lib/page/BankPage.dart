import 'package:demo/api/Constant.dart';
import 'package:demo/db/MyDB.dart';
import 'package:demo/db/TBBank.dart';
import 'package:demo/db/sp/MySP.dart';
import 'package:demo/model/Bank.dart';
import 'package:demo/routers/MyRouter.dart';
import 'package:demo/utils/Date.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:demo/api/Service.dart';

class BankPage extends StatefulWidget{
  @override
  _BankPageState createState() => _BankPageState();
}

class _BankPageState extends State<BankPage> with AutomaticKeepAliveClientMixin<BankPage>{

  List<Bank> data = [];

  @override
  bool get wantKeepAlive {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        width: double.infinity,

        child: Column(
          children: [Expanded(child: bankListView())],
        )
      )
    );
  }

  ListView bankListView(){
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) =>
            GestureDetector(child:
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Image.network(data[index].pic,fit: BoxFit.contain,width: 80,height: 80,),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("  " + data[index].name,style: TextStyle(fontSize: 17),),
                        Text("  今日更新",style: TextStyle(fontSize: 14),)
                      ],
                    ))
                  ],
                ),
              ),
              onTap: () => {
                toBankList(index)
              }),
            
      separatorBuilder: (BuildContext context, int index) =>
          Divider(height: 1.0, color: Colors.black12,indent: 30,endIndent: 30),
      itemCount: data.length,
    );
  }

  @override
  void initState(){
    super.initState();
  }

  @override
  void didChangeDependencies() async{
    super.didChangeDependencies();

    var date = Date.getDate();
    if( MySP.instance.getString(Constant.SP_UPADTE_DATE_BANK) != date){
      data = await Service().getBankList();
      TBBank.instance.updateBank(data);
      MySP.instance.setString(Constant.SP_UPADTE_DATE_BANK, date);
    }
    else{
      data = await TBBank.instance.getAll();
    }
    setState(() {

    });
  }

  
  void toBankList(index){
    Navigator.pushNamed(context, MyRouter.PAGE_BANKMUSIC,arguments: data[index]);
  }

}

/*
  1. Return async value to initState()
  https://stackoverflow.com/questions/64370556/return-async-value-to-initstate

  2. 更新ListView
  https://blog.csdn.net/zl18603543572/article/details/109232421

  3. Flutter ScrollView 滑动组件
  https://blog.csdn.net/zl18603543572/article/details/94426582

  4. Flutter Column嵌套Listview不能滚动的问题
  https://www.jianshu.com/p/a5d6e203d292
*/