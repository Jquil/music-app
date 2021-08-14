import 'package:demo/utils/CommonUtil.dart';

class Constant{

  factory Constant() => _instance;

  static final Constant _instance = Constant._internal();

  Constant._internal(){
    // todo
  }


  // ---------- API PATH ----------

  static final root = "https://www.kuwo.cn/api/www";

  static final bankList = "${root}/bang/bang/bangMenu?httpsStatus=1&reqId=e617e730-e1f7-11eb-942d-33e288737b1d";

  static final hotsearch = "${root}/search/searchKey?key=&httpsStatus=1&reqId=db3f8670-e1f6-11eb-942d-33e288737b1d";

  static final version = "https://jqwong.cn/api/music/version.json?v=${getUUid()}";

  static String getUrlOfMusicBank(int bankId,int page,int itemSize){
    String musicOfBank = "${root}/bang/bang/musicList?bangId=${bankId}&pn=${page}&rn=${itemSize}&httpsStatus=1&reqId=b092ca30-e152-11eb-90cc-79484e9fbe4d";
    return musicOfBank;
  }

  static String getMusicUrl(String musicrid){
    String url = "http://antiserver.kuwo.cn/anti.s?type=convert_url&rid=${musicrid}&format=mp3&response=url";
    return url;
  }

  static String getSearchUrl(String key,int page,int size){
    String url = "${root}/search/searchMusicBykeyWord?key=${key}&pn=${page}&rn=${size}&httpsStatus=1&reqId=23016430-e1eb-11eb-a2ee-bf024dbfa4c7";
    return url;
  }

  static String getArtistUrl(int id){
    return "$root//artist/artist?artistid=$id&httpsStatus=1&reqId=b06e62f0-f582-11eb-bd8d-c19fac490f25";
  }

  static String getArtistMusicUrl(int id,int page){
    return "$root/artist/artistMusic?artistid=$id&pn=$page&rn=${Constant.ATTR_ITEM_SIZE}&httpsStatus=1&reqId=87263830-f72d-11eb-979c-c11891b4f2ba";
  }

  // ---------- SharePreference ----------
  static final String SP_UPADTE_DATE_BANK       = "update_date_bank",
                      SP_UPADTE_DATE_HOT_SEARCH = "update_date_hot_search";


  // ---------- AssetImage ----------
  static final List<String> assetImageList = [
    "lib/assets/images/1.jpeg",
    "lib/assets/images/2.jpeg",
    "lib/assets/images/3.jpg",
    "lib/assets/images/4.jpg",
    "lib/assets/images/5.jpg",
    "lib/assets/images/6.jpg",
    "lib/assets/images/7.jpg",
    "lib/assets/images/8.jpg",
    "lib/assets/images/9.jpg",
    "lib/assets/images/10.jpeg",
    "lib/assets/images/11.jpg",
    "lib/assets/images/12.jpg",
    "lib/assets/images/13.jpg",
  ];

  // ---------- Attribute ----------
  static final String ATTR_KEY   = "key",
                      ATTR_TITLE = "title";

  static final int ATTR_ITEM_SIZE = 20,
                   ATTR_MAX_SIZE  = 100;

  // ---------- Status ----------
  static final int STATUS_DEFAULT   = 0,
                   STATUS_LOADING   = 1,
                   STATUS_LOADEDALL = 2;
}