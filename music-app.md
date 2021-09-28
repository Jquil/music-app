# 重构

之前已经初步完成了「Music-App」的开发，但由于以下原因需要将项目重构一遍：

1. UI不美观

2. 些许功能未完成

3. 代码太乱

我们将模块、功能分解，一步步来实现~

# 模块

1. “我的”，包含「本地音乐、播放列表、收藏歌手、我的喜欢 以及 创建的歌单」入口

2. “排行榜”：展示各大音乐排行榜

3. “搜索”：实现热搜以及搜索历史

4. “歌词”：歌词滚动，播放/暂停，切换上一首、下一首

# 数据库

\>> **tb_song_list_info(歌单信息)**

|Column|Type|Other|Info|
|------------|---------|-------------|----------|
| Tsli\_id   | Integer | Primary key | 主键       |
| Tsli\_name | Text    |             | 歌单名称     |
| Tsli\_only | Integer |             | 唯一（是否可删） |

\>> **tb_song_list_{tsli_id}(歌单)**

|Column|Type|Other|Info|
|---------|---------|-------------|------|
| Tsl\_id | Integer | Primary key | 主键   |
| Ts\_id  | Integer |             | 歌曲id |


\>> **tb_song(歌曲)**

|Column|Type|Other|Info|
|---------------------|---------|-------------|-----------------|
| Ts\_id              | Integer | Primary key | 主键              |
| ts\_musicRid        | Text    |             | 歌曲id \(JSON数据\) |
| Ts\_name            | Text    |             | 歌曲名称            |
| Ts\_artist          | Text    |             | 歌手              |
| Ts\_artistId        | Integer |             | 歌手ID            |
| Ts\_album           | Text    |             | 专辑            |
| Ts\_albumpic        | Text    |             | 专辑照片            |
| Ts\_songTimeMinutes | Text    |             | 歌曲时长            |
| Ts\_hasmv           | Integer |             | 是否有MV           |

\>> **tb_collect_singer(收藏的歌手)**

|Column|Type|Other|Info|
|----------------|---------|-------------|-------|
| Tcs\_id        | Integer | Primary key | 主键    |
| Tcs\_artistId  | Integer |             | 歌手ID  |
| Tcs\_artist    | Text    |             | 歌手    |
| Tcs\_pic       | Text    |             | 照片 |

\>> **tb_leaderboard_type(排行榜类别)**

|Column|Type|Other|Info|
|--------------|---------|-------------|------|
| Tlt\_id       | Integer | Primary key | 主键   |
| Tlt\_name     | Text    |             | 名称   |

\>> **tb_leaderboard(排行榜)**

|Column|Type|Other|Info|
|--------------|---------|-------------|------|
| Tl\_id       | Integer | Primary key | 主键   |
| Tl\_sourceId | Text    |             | 资源id |
| Tl\_pic      | Text    |             | 照片   |
| Tl\_name     | Text    |             | 名称   |
| Tl\_intro    | Text    |             | 备注   |
| Tl\_type     | Integer |             | 类别ID |


\>> **tb_hot_search(热搜)**

|Column|Type|Other|Info|
|----------|---------|-------------|-------|
| Ths\_id  | Integer | Primary key | 主键    |
| Ths\_key | Text    |             | 热搜关键字 |


\>> **tb_search_history(搜索历史)**

|Column|Type|Other|Info|
|----------|---------|-------------|-------|
| Tsh\_id  | Integer | Primary key | 主键    |
| Tsh\_key | Text    |             | 搜索关键字 |


\>> **tb_cache_song(缓存歌曲)**

|Column|Type|Other|Info|
|-------------|---------|-------------|------|
| Tcs\_id     | Integer | Primary key | 主键   |
| Tcs\_songId | Integer |             | 歌曲ID |


# 功能

## 播放器

播放歌曲逻辑如下：

1. 首先到缓存表中查是否存在该歌曲缓存信息

2. 有：判断缓存文件是否存在，存在则播放，不存在则删掉该缓存数据

3. 无：正常播放


实现步骤如下：

1. 添加网络权限

1. 加入`audioplayers`依赖

2. 调用其API播放

找到`project/android/app/src/main/AndroidManifest.xml`，添加权限：
```
<uses-permission android:name="android.permission.INTERNET" />
```

加入依赖：
```
dependencies:
  audioplayers: ^0.18.1
```

播放API：
```
// 播放缓存：
playLocal() async {
    int result = await audioPlayer.play(localPath, isLocal: true);
}

// 正常播放：
play() async {
    int result = await audioPlayer.play(url);
    if (result == 1) {
        // success
    }
}
```

## 缓存

缓存歌曲功能，我们大致需要经过以下步骤：

1. 授予文件读写权限

2. 加入`path_provider`插件，用于获取路径

3. 加入`dio`插件，用于拉取数据并下载


同样，添加权限：
```
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
```


加入依赖：
```
dependencies:
  path_provider: ^2.0.2
  dio: ^4.0.0
```

并在控制台中执行：`flutter pub get`


dio下载
```
await Dio().download(url, path);
```


补充：在实现上我采用的是手动缓存，如果需要缓存的歌曲正在播放，就不download了。直接创建文件并将数据流写进去即可~

缓存目录API为：`getTemporaryDirectory`


## 更新

Android App如果没有上架应用商店，就需要通过以下步骤：

1. 下载应用至本地

2. 授权安装应用权限

3. 打开安装包安装

虽然说只有三步，但实现起来还是颇为繁琐。所以这里用一个较为简便的方法：**用浏览器打开下载链接下载并安装**

这里通过[「url_launcher」](https://pub.dev/packages/url_launcher)的插件来实现：

加入依赖：
```
dependencies:
  url_launcher: ^6.0.12

// flutter pub get
```

例子代码：
```
_launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
```


## 夜间模式

判断系统当前模式：
```
bool isDarkMode(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark;
}
```

```
MaterialApp( 
    theme: ThemeData( 
        brightness: Brightness.light, 
        primaryColor: Colors.blue, 
    ), 
    darkTheme: ThemeData.dark()
);
```

参考文章：[快速适配 Flutter 之深色模式](https://zhuanlan.zhihu.com/p/138530205) 以及 [Flutter 夜间模式及字体设置](https://blog.csdn.net/weixin_44819566/article/details/109627337)



## 

# 最终

最终实现效果图如下：

。。。。

# 文章

1. [条形固定值进度条](https://blog.csdn.net/zl18603543572/article/details/94581899)（播放进度）以及 [进度指示器](https://book.flutterchina.club/chapter3/progress.html)

2. [图片圆角与圆形](https://www.jianshu.com/p/33a72d85df71)（Item）

3. [背景模糊图](http://findsrc.com/flutter/detail/8805)（歌词）

4. [ListView的横向滚动](https://blog.csdn.net/beyondforme/article/details/104318502) （排行榜）

5. [TextField使用 - 搜索按钮](https://blog.csdn.net/yuzhiqiang_1993/article/details/88204031)（搜索）

6. [Flutter 入门与实战（七）：使用 cached_image_network 优化图片加载体验](https://juejin.cn/post/6966962044432023566)

7. [Google文字字体库](https://pub.flutter-io.cn/packages/google_fonts)

8. [Flutter SafeArea - 异形屏适配利器](https://cloud.tencent.com/developer/article/1472092)

9. [Flutter Card阴影效果](https://cloud.tencent.com/developer/article/1723858)（主页）

10. [Flutter ListView 分页加载更多效果](https://www.awaimai.com/2758.html)

11. [Flutter ListTile、ExpansionTile 设置 leading 和 title之的间隔](https://blog.csdn.net/m0_37973043/article/details/108519087)

12. [Flutter Column嵌套Listview不能滚动的问题](https://www.jianshu.com/p/a5d6e203d292)

13. [Flutter开发弹起键盘出现Overflow问题的解决方法](https://www.cnblogs.com/yongfengnice/p/13927197.html)

14. [Flutter Listview 设置分割线](https://www.jianshu.com/p/26077de545d8)（Item）

15. [Flutter SliverAppBar全解析，你要的效果都在这了！](https://blog.csdn.net/yechaoa/article/details/90701321)（详情）

16.  头部搜索框实现（搜索）
      [Flutter - 导航栏搜索框实现](https://blog.csdn.net/iotjin/article/details/105977742)
      [Flutter TextField 使用prefixIcon图标和文字间距问题](https://www.cnblogs.com/zhouyong0330/p/14317622.html)
      [Flutter文本输入框TextFormField显示清除按钮](http://findsrc.com/article/flutter_textformfield_clear_text)

17. [Flutter 去除安卓的半透明的状态栏](https://www.cnblogs.com/lude1994/p/14319005.html)

18. [滚动监听及控制](https://book.flutterchina.club/chapter6/scroll_controller.html)

19. [GridView](https://book.flutterchina.club/chapter6/gridview.html)（主页）

20. [Flutter底部导航栏BottomNavigationBar](https://blog.csdn.net/yuzhiqiang_1993/article/details/88118902)

21. [页面切换时避免组件重载](https://www.jianshu.com/p/52bacff37d78)

22. [Flutter开发之——文件及文件夹操作](https://blog.csdn.net/Calvin_zhou/article/details/117323711)

23. [Flutter Chip 示例](https://www.pianshen.com/article/2850420186/)

24. [获取设备宽高](https://www.jianshu.com/p/7914727000a5)

25. [Flutter 状态视图的封装](https://blog.csdn.net/daividtu/article/details/107084796)

26. [Flutter 背景渐变色](https://www.webascii.cn/article/5ef2cb74071be112473165e4)

# 小结


[Flutter Widget大全解析](https://www.jianshu.com/p/3320350b3814)

[优秀轮子](https://www.jianshu.com/p/a26ed51565a1)

`select last_insert_rowid() from table;`

Scaffold的`bottomSheet`属性用来写播放栏widget，而`AppBar`用来显示title

[好看的背景色1](https://webkul.github.io/coolhue/) | [好看的背景色2](https://webgradients.com/) | [好看的背景色3](https://uigradients.com/#Orca)
