import 'package:dio/dio.dart';

class MyDio{

  factory MyDio() => _instance;

  static MyDio _instance = MyDio._internal();

  static final _option = BaseOptions(
    baseUrl: '',
    connectTimeout: 85000,
    receiveTimeout: 85000,
    headers: {
      "COOKIE":COOKIE,
      "CSRF":CSRF
    }
  );

  static final Dio dio = Dio(_option);

  static final String COOKIE = "_ga=GA1.2.291993560.1625886876; _gid=GA1.2.445012141.1625886876; Hm_lvt_cdb524f42f0ce19b169a8071123a4797=1625903943,1625967386; Hm_lpvt_cdb524f42f0ce19b169a8071123a4797=1625967696; kw_token=IP4FK471YEF",
                      CSRF   = "IP4FK471YEF",
                      REFERER_ROOT     = "https://www.kuwo.cn/";

  static String REFERER_SEARCH(String key){
    return "https://www.kuwo.cn/search/list?key=${key}";
  }

  static String REFERER_ARTIST_SONG(int id){
    return "${REFERER_ROOT}singer_detail/$id";
  }


  MyDio._internal(){
  }
}

/*
  1. flutter网络dio框架公共请求参数、请求header使用总结
  https://blog.csdn.net/zl18603543572/article/details/106739256/
*/