实现顺序：应用更新 > 打包 > 缓存/歌词滚动/息屏...

# 应用更新

加入依赖：
```
package_info: ^2.0.0
```

将服务器返回的JSON数据封装为Bean：
```
class Version{
  String version,
  title,
  apk,
  ipa;
  List content;

  Version(this.version, this.title, this.apk, this.ipa, this.content);
}
```

网络拉取：
```
Future<Version> getNewestVersion() async{
    // https://jqwong.cn/api/music/version.html
    Version version = Version("", "", "", "", []);
    try{
        Response res = await MyDio.dio.get(Constant.version);
        Map map = json.decode(res.toString());
        version = Version(map['version'], map['title'], map['apk'], map['ipa'], map['content']);
    }
    catch(e){
        // todo
    }
    return version;
}
```


以下为逻辑代码
```
class AppVersion{

    // 检查版本号
    static Future<void> checkVersion(Function call) async{
        bool flag = false;
        PackageInfo info = await PackageInfo.fromPlatform();
        print(info.packageName);
        int now_version = int.parse(info.version.replaceAll(".", ""));
        Version newestInfo = await Service().getNewestVersion();
        int newest_version = int.parse(newestInfo.version.replaceAll(".", ""));
        if(now_version < newest_version){
            flag = true;
        }
        call(flag,version);
    }

    // 升级Dialog
    static void showUpdateDialog(Version version,Function call) async{
        showDialog(
            context: getContext(),
            builder: (context){
                return AlertDialog(
                    title: Text(version.title),
                    content: tipUpdateWidget,       // 这里修改
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
            }
        );
    }

    // 检查
    static Future<void> check() async{
        checkVersion((flag,version){
            if(flag){
                if(Platform.isAndroid){
                    showUpdateDialog(version,(){
                        androidUpdate(version);
                    })
                }
                else if(Platform.isIOS){

                }
            }
        })
    }


    // android更新
    static void androidUpdate(Version version){
        // 打开浏览器更新
    }


    // ios更新
    static void iosUpdate(){

    }
}
```


# 缓存

需要加入依赖：
```
path_provider: ^2.0.2
```

缓存命名规则：{MusicRid}.{format}

先判断该歌曲是否已经缓存（需要读写权限）：

```
Directory tempDir = await getTemporaryDirectory();
String path =  "${tempDir.path}${Platform.pathSeparator}${filename}";

var file = File(path);
if(!file.existsSync()){
    // var file = await File(path).create(recursive:true);
    // file.writeAsBytes();
    // insert to table
}
```


# 播放缓存


先查看缓存表中是否有该缓存

有这条缓存记录，先判断缓存文件是否存在

[Flutter开发之——文件及文件夹操作](https://blog.csdn.net/Calvin_zhou/article/details/117323711)

[判断文件是否存在](http://www.mybatis.cn/archives/1545.html)

大概就是：
```
Directory tempDir = await getTemporaryDirectory();
String path =  "${tempDir.path}${Platform.pathSeparator}${filename}";
var file = File(path);
if(cache_item exit){
    if(file.existsSync()){
        // todo
    }
    else{
        // delete this item
    }
}
```


以及：主页中“本地缓存音乐”的入口，需要遍历缓存目录下的文件：
```
Directory tempDir = await getTemporaryDirectory();
Stream<FileSystemEntity> filelist = Directory(tempDir.path).list();
await for(FileSystemEntity fse in filelist){
    print(fse);
}
```


当有缓存记录当没有缓存文件时，删除该缓存记录

在进入该入口时更新数据（确保缓存文件与缓存记录都有在），逻辑如上


AudioPlayers播放缓存的API：
```
// 方法1
playLocal() async {
    int result = await audioPlayer.play(localPath, isLocal: true);
}

// 方法2
playLocal() async {
    Uint8List byteData = .. // Load audio as a byte array here.
    int result = await audioPlayer.playBytes(byteData);
}
```


以及其他操作：
```
await audioPlayer.pause();
await audioPlayer.stop();
await audioPlayer.resume();
```


# 歌词滚动

（模糊图片如何设为网络加载） => NetworkImage(url)

1. Item高度为30

2. ListView高度为90，显示3个Item

3. 滚动代码：`_scrollController.animateTo(i * _ITEM_HEIGHT,
            duration: new Duration(seconds: 2), curve: Curves.ease);`

4. 切换歌曲后记得重置


# 打包

首先在清单文件中添加权限：
```
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
```

更换APP Label & ICO


生成Key

> keytool -genkey -v -keystore { D:/key.jks } -keyalg RSA -keysize 2048 -validity 10000 -alias key

记录下store的密码以及key的密码

然后再`android/app/buid.gradle`配置以下信息：

```
android{
    signingConfigs {
        release {
            keyAlias "key"
            keyPassword "123456"
            storeFile file("D:/Flutter/Key/key.jks")
            storePassword "123456"
        }
    }

    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}
```


然后执行：`flutter build apk`

生成的apk文件位于：`build/android/outputs/apk/release/`



# 息屏导致问题

1. 程序停止运行，导致不能播放下一首歌曲

：[audio_service](https://pub.dev/packages/audio_service/example)

：用通知来实现，看能否解决问题 => [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications)




# 补充

1. 收藏歌手用BottomSheetDialog实现，若数据为空，toast显示


Dio获取Byte流数据：
```
Future<Uint8List> getData(String path, [Map<String, dynamic>? params]) async {
    try {
      var response = await Dio(options).get(
        url(path),
        queryParameters: params,
        options: Options(responseType: ResponseType.stream),
      );
      final stream = await (response.data as ResponseBody).stream.toList();
      final result = BytesBuilder();
      for (Uint8List subList in stream) {
        result.add(subList);
      }
      return result.takeBytes();
    } on DioError catch (_) {
      rethrow;
    }
  }
```


以及后续增加换源功能

# 2021/10/15

1. 息屏后自动播放下一首时，播放歌曲与实际歌曲不一致

2. 歌单中的歌曲应该由ID排倒序

3. PlayBar 播放按钮在夜间模式下颜色没有变白色

4. 将PlayBar默认图片以及头像设置为本地

5. 修改歌词滚动时的Index默认为-1

6. 收藏歌曲时，对应歌单歌曲数量没有增加（删除亦是如此）

7. 点击“确定更新”后没有关闭Dialog

8. 这周实现（缓存、修改个人资料）以及修复以上BUG
