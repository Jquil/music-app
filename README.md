# 前言

因为版权问题，所以在听歌的时候总是需要切换APP，麻烦

并且，因为穷，听不起付费歌曲

所以就萌生了自己动手开发一个音乐APP的念头

因为我想弄个跨平台的APP，在一番考量后决定用Flutter作为跨平台框架


# 实现

1. 搜集数据接口
2. 定下基本框架
3. 设计数据库
4. 思考操作流程

然后就可以开始搬砖了~

# 界面展示

| column1 | column2 |column3|column4|
| ----------- | ----------- |----------- |----------- |
| ![](https://static.jqwong.cn/202110231959184.jpg)| ![](https://static.jqwong.cn/202110231959214.jpg)|![](https://static.jqwong.cn/202110231959213.jpg)|![](https://static.jqwong.cn/202110231959210.jpg)|
|![](https://static.jqwong.cn/202110231959212.jpg)|![](https://static.jqwong.cn/202110231959182.jpg)|![](https://static.jqwong.cn/202110231959183.jpg)|![](https://static.jqwong.cn/202110231959209.jpg)|

# 版本更新

### V1.0.0

初始版本 -- 2021/10/01

### V2.0.0

1. 新增歌曲页

2. 新增自动切换歌曲功能

3. 更换部分场景图片

-- 更新时间：2021/10/10

### V3.0.0

1. 修复息屏后自动播放下一首时，播放歌曲与实际歌曲不一致

2. 修改歌单中的歌曲排序

3. PlayBar 播放按钮颜色没有适应夜间模式

4. 将PlayBar默认图片以及头像作缓存操作

5. 修改歌词滚动时的高亮歌词与实际歌词不一致问题

6. 修复收藏歌曲时，对应歌单歌曲数量没有增加（删除亦是如此）

7. 修复点击“确定更新”后没有关闭Dialog

8. 歌词页添加Action Button并实现「喜欢，收藏到歌单，缓存」功能

-- 更新时间：2021/10/17

### V4.0.0

1. 修复“本地缓存”重复加载

2. 实现“修改资料”功能

3. 开放“我的喜欢”入口

4. 实现通知功能

5. 修复歌曲页ActionItem颜色不能适配夜间模式问题

6. 实现“收藏歌手”功能

-- 更新时间：2021/10/24


### V5.0.0(未发布)

1. 修改播放页歌词Widget高度为自适应

2. 收藏歌手图像作缓存处理

3. 循环播放 & 列表播放

4. 适配英文歌词


# 文章

1. [条形固定值进度条](https://blog.csdn.net/zl18603543572/article/details/94581899)以及 [进度指示器](https://book.flutterchina.club/chapter3/progress.html)

2. [图片圆角与圆形](https://www.jianshu.com/p/33a72d85df71)

3. [背景模糊图](http://findsrc.com/flutter/detail/8805)

4. [ListView的横向滚动](https://blog.csdn.net/beyondforme/article/details/104318502)

5. [TextField使用 - 搜索按钮](https://blog.csdn.net/yuzhiqiang_1993/article/details/88204031)

6. [Flutter 入门与实战（七）：使用 cached_image_network 优化图片加载体验](https://juejin.cn/post/6966962044432023566)

7. [Google文字字体库](https://pub.flutter-io.cn/packages/google_fonts)

8. [Flutter SafeArea - 异形屏适配利器](https://cloud.tencent.com/developer/article/1472092)

9. [Flutter Card阴影效果](https://cloud.tencent.com/developer/article/1723858)

10. [Flutter ListView 分页加载更多效果](https://www.awaimai.com/2758.html)

11. [Flutter ListTile、ExpansionTile 设置 leading 和 title之的间隔](https://blog.csdn.net/m0_37973043/article/details/108519087)

12. [Flutter Column嵌套Listview不能滚动的问题](https://www.jianshu.com/p/a5d6e203d292)

13. [Flutter开发弹起键盘出现Overflow问题的解决方法](https://www.cnblogs.com/yongfengnice/p/13927197.html)

14. [Flutter Listview 设置分割线](https://www.jianshu.com/p/26077de545d8)

15. [Flutter SliverAppBar全解析，你要的效果都在这了！](https://blog.csdn.net/yechaoa/article/details/90701321)

16.
     - [Flutter - 导航栏搜索框实现](https://blog.csdn.net/iotjin/article/details/105977742)
     - [Flutter TextField 使用prefixIcon图标和文字间距问题](https://www.cnblogs.com/zhouyong0330/p/14317622.html)
     - [Flutter文本输入框TextFormField显示清除按钮](http://findsrc.com/article/flutter_textformfield_clear_text)

17. [Flutter 去除安卓的半透明的状态栏](https://www.cnblogs.com/lude1994/p/14319005.html)

18. [滚动监听及控制](https://book.flutterchina.club/chapter6/scroll_controller.html)

19. [GridView](https://book.flutterchina.club/chapter6/gridview.html)

20. [Flutter底部导航栏BottomNavigationBar](https://blog.csdn.net/yuzhiqiang_1993/article/details/88118902)

21. [页面切换时避免组件重载](https://www.jianshu.com/p/52bacff37d78)

22. [Flutter开发之——文件及文件夹操作](https://blog.csdn.net/Calvin_zhou/article/details/117323711)

23. [Flutter Chip 示例](https://www.pianshen.com/article/2850420186/)

24. [获取设备宽高](https://www.jianshu.com/p/7914727000a5)

25. [Flutter 状态视图的封装](https://blog.csdn.net/daividtu/article/details/107084796)

26. [Flutter 背景渐变色](https://www.webascii.cn/article/5ef2cb74071be112473165e4)

27. [flutter_local_notifications 填坑](https://blog.csdn.net/Katie_fly/article/details/109694116)

28. [快速适配 Flutter 之深色模式](https://zhuanlan.zhihu.com/p/138530205) 以及 [Flutter 夜间模式及字体设置](https://blog.csdn.net/weixin_44819566/article/details/109627337)

29. [好看的背景色1](https://webkul.github.io/coolhue/) | [好看的背景色2](https://webgradients.com/) | [好看的背景色3](https://uigradients.com/#Orca)
