import 'package:demo/api/Constant.dart';
import 'package:demo/api/Service.dart';
import 'package:demo/db/TBHotSearch.dart';
import 'package:demo/db/sp/MySP.dart';
import 'package:demo/routers/MyRouter.dart';
import 'package:demo/utils/Date.dart';
import 'package:demo/widget/CommonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchPage extends StatefulWidget{
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with AutomaticKeepAliveClientMixin<SearchPage> {

  TextEditingController ?_tc;

  List hotSearch = [];

  final showHotSearchSize = 5;

  @override
  void initState() {
    super.initState();

    _tc = TextEditingController();
    _tc?.addListener(() {
      setState(() {});
    });
  }


  @override
  void dispose() {
    _tc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      // 头部：返回 - 搜索框 - 搜索按钮
      appBar: AppBar(
        titleSpacing: 15,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(
          alignment: Alignment.center,
          height: 38,
          decoration: BoxDecoration(
            //border: Border.all(color: Colors.grey,width: 1),
            color: Color.fromARGB(100, 218, 218, 218),
            borderRadius: BorderRadius.all(Radius.circular(15.0))
          ),
          //padding: EdgeInsets.only(right: 12),
          child: TextField(
            controller: _tc,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: "请输入歌手或歌名",
              hintStyle: TextStyle(fontSize: 13),
              border: OutlineInputBorder(borderSide: BorderSide.none),  // 取消下边框
              contentPadding: EdgeInsets.all(0),                        // 文本垂直居中
              suffixIcon: _tc?.text.length != 0 ? IconButton(onPressed: (){ _tc?.clear(); }, icon: Icon(Icons.cancel,color: Colors.grey,)) : null,
            ),
          ),
        ),
        actions: [
          InkResponse(
            radius: 0,
            highlightColor: Colors.transparent,
            child: Container(
              margin: EdgeInsets.only(right: 25),
              height: 50,
              child: Center(
                child: Align(
                    child: Text("搜索",style: TextStyle(color: Colors.black),),alignment: Alignment.centerLeft),
              ),
            ),
            onTap: (){
              search();
            },
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 30,top: 10),
            child:Align(child: Text("热门搜索",style: TextStyle(fontSize: 18)),alignment: Alignment.centerLeft,),
          ),
          Container(
            margin: EdgeInsets.only(left: 25,right: 25),
            child:
            Align(
              child:
              FutureBuilder(
                  initialData:hotSearch,
                  future: getHotSearch(),
                  builder: (BuildContext context, AsyncSnapshot snapshot){

                    if(snapshot.hasData){
                      return hotSearchWrap();
                    }
                    else{
                      return Text("Error");
                    }
              }),
              alignment: Alignment.centerLeft,
            ),

          ),
          //CommonWidget().Title("历史搜索"),
        ],
      ),
    );
  }



  @override
  bool get wantKeepAlive {
    return true;
  }


  Wrap hotSearchWrap(){
    List<ActionChip> list = [];
    for(int i = 0; i < hotSearch.length; i++){
      //if(i >= showHotSearchSize)
      //    break;
      list.add(ActionChip(label: Text(hotSearch[i].toString()),
                          onPressed: (){
                                Navigator.pushNamed(context, MyRouter.PAGE_SEARCHLIST,arguments: hotSearch[i].toString());
                          }));
    }

    return Wrap(
      direction: Axis.horizontal,
      spacing: 8,
      children: list,
    );
  }


  void search(){
    if(_tc?.text == "")
        return;
    Navigator.pushNamed(context, MyRouter.PAGE_SEARCHLIST,arguments: _tc?.text);
  }


  Future<List> getHotSearch() async{

    if(hotSearch.length > 0){
      //print("重复请求");
      return [];
    }
    var date = Date.getDate();
    if( MySP.instance.getString(Constant.SP_UPADTE_DATE_HOT_SEARCH) != date){
      hotSearch = await Service().getHotSearch();
      TBHotSearch.update(hotSearch);
      MySP.instance.setString(Constant.SP_UPADTE_DATE_HOT_SEARCH, date);
    }
    else{
      hotSearch = await TBHotSearch.getAll();
    }

    return hotSearch;
  }

  void getHistorySearch() async{

  }


/*
    1. 头部搜索框实现
      https://blog.csdn.net/iotjin/article/details/105977742
      https://www.cnblogs.com/zhouyong0330/p/14317622.html(添加搜索图标)
      http://findsrc.com/article/flutter_textformfield_clear_text(添加清除图标)

     2. Chip
      http://www.5imoban.net/jiaocheng/hbuilder/2020/1007/4025.html
  * */
}