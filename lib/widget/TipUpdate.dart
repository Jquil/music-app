import 'package:flutter/material.dart';

class TipUpdate extends StatefulWidget{

  List content;

  _StateTipUpdate ?state;

  TipUpdate(this.content);

  @override
  State createState() {
    state = _StateTipUpdate(content);
    return state!;
  }
}

class _StateTipUpdate extends State<TipUpdate>{

  List content;
  List<Widget> contentWidget = [];
  _StateTipUpdate(this.content);
  double value = 0;
  bool hide = true;

  @override
  void initState() {
    super.initState();
    for(int i = 0; i < content.length; i++){
      contentWidget.add(Text(content[i].toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          child: Column(
            children: contentWidget,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 15),
          child: Offstage(
              offstage: hide,
              child: LinearProgressIndicator(
                value: value,
              )
          ),
        )
      ],
    );
  }

  void setValue(v){
    setState(() {
      value = v;
    });
  }

  void showProgress(){
    setState(() {
      hide = false;
    });
  }
}