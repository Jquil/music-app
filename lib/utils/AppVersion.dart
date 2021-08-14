import 'dart:io';

import 'package:demo/api/Service.dart';
import 'package:demo/http/MyDio.dart';
import 'package:demo/model/Version.dart';
import 'package:demo/utils/CommonUtil.dart';
import 'package:demo/widget/TipUpdate.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AppVersion{

  static Future<void> check() async{
    bool downloading = false;
    checkVersion((bool flag,Version version){
      if(flag){
        if(downloading)
          return;
        downloading = true;
        checkPermission((int status){
          switch(status){
            case 1:
              // 下载并显示进度
              showUpdateDialog(version,(TipUpdate widget){
                widget.state?.showProgress();
                if(Platform.isAndroid){
                  download(version.apk,"apk", (int progress,double value,String path){
                    widget.state?.setValue(value);
                    if(progress == 100){
                      installAPK(path);
                    }
                  });
                }
                else if(Platform.isIOS){

                }

              });
              break;
            case 2:
              print("repeat");
              break;
          }
        });
      }
    });

  }


  static Future<void> checkVersion(Function call) async{
    bool needToUpdate = false;
    PackageInfo info = await PackageInfo.fromPlatform();
    print(info.packageName);
    int now_version = int.parse(info.version.replaceAll(".", ""));
    Version newestInfo = await Service().getNewestVersion();
    int newest_version = int.parse(newestInfo.version.replaceAll(".", ""));
    if(now_version < newest_version){
      needToUpdate = true;
    }
    call(needToUpdate,newestInfo);
  }

  static void showUpdateDialog(Version version,Function call) async{
    var tipUpdateWidget = TipUpdate(version.content);
    showDialog(
        context: getContext(),
        builder: (context){
          return AlertDialog(
            title: Text(version.title),
            content: tipUpdateWidget,
            actions: <Widget>[
              FlatButton(
                  child: Text("取消"),
                  onPressed: () => Navigator.pop(context, "cancel")),
              FlatButton(
                  child: Text("更新 "),
                  onPressed: (){
                    call(tipUpdateWidget);
                  }),
            ],
          );
        });
  }

  static void download(String url,String format,Function call) async{
    print(url);
    Directory ?dir = await getSavePath();
    String path = "${dir?.path}/music.$format";
    print(path);
    double value = 0;

    MyDio.dio.download(url, path,options:Options(method: "GET"),onReceiveProgress:(received, total){
        value = received / total;
        call(int.parse((value * 100).toStringAsFixed(0)),value,path);
    });
  }


  static void checkPermission(Function call) async{
    Map<Permission, PermissionStatus> map = await [
      Permission.requestInstallPackages,
      Permission.storage,
    ].request();

//    PermissionStatus status1 = await Permission.requestInstallPackages.request();
//    PermissionStatus status2 = await Permission.storage.request();
//    bool b1 = await Permission.requestInstallPackages.isGranted,
//         b2 = await Permission.storage.isGranted;
//    print("$b1 -- $b2");
//
    if(map[Permission.storage] == PermissionStatus.granted){
        call(1);
    }
    else{
      call(2);
    }
  }


  static Future<Directory?> getSavePath() async{
    return getExternalStorageDirectory();
  }


  static void installAPK(String path) async{
    OpenFile.open(path);
  }
}