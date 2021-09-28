# 统一参数

```
$root = "https://www.kuwo.cn/api/www"
Method:GET
Headers["COOKIE"]  = "_ga=GA1.2.291993560.1625886876; _gid=GA1.2.445012141.1625886876; Hm_lvt_cdb524f42f0ce19b169a8071123a4797=1625903943,1625967386; Hm_lpvt_cdb524f42f0ce19b169a8071123a4797=1625967696; kw_token=IP4FK471YEF"
Headers["CSRF"]    = "IP4FK471YEF"
Headers["REFERER"] = "https://www.kuwo.cn/"
```


# 热搜

请求地址：
```
${root}/search/searchKey?key=&httpsStatus=1&reqId=db3f8670-e1f6-11eb-942d-33e288737b1d
```

返回以下JSON数据：
```
{
    "code":200,
    "curTime":1632563969004,
    "data":[
        "错位的遗憾",
        "自娱自乐",
        "阿衣莫",
        "想",
        "提笔忘情",
        "余香",
        "中国好声音2021",
        "怨苍天变了心",
        "最后的人",
        "枯木与海"
    ],
    "msg":"success",
    "profileId":"site",
    "reqId":"e268846fc9e5bd2b4323dbb43a879334",
    "tId":""
}
```

# 搜索

请求地址：
```
${root}/search/searchMusicBykeyWord?key=${key}&pn=${page}&rn=${size}&httpsStatus=1&reqId=23016430-e1eb-11eb-a2ee-bf024dbfa4c7
```

> REFERER也可以设为`https://www.kuwo.cn/search/list?key=${key}`

返回以下JSON数据：
```
{
    "code":200,
    "curTime":1632564166484,
    "data":{
        "total":"6606",
        "list":[
            {
                "musicrid":"MUSIC_228908",
                "barrage":"0",
                "artist":"周杰伦",
                "mvpayinfo":{
                    "play":0,
                    "vid":8247609,
                    "down":0
                },
                "pic":"https://img2.kuwo.cn/star/albumcover/500/64/96/2266534336.jpg",
                "isstar":0,
                "rid":228908,
                "duration":269,
                "score100":"91",
                "content_type":"0",
                "track":3,
                "hasLossless":true,
                "hasmv":1,
                "releaseDate":"2003-07-31",
                "album":"叶惠美",
                "albumid":1293,
                "pay":"16711935",
                "artistid":336,
                "albumpic":"https://img2.kuwo.cn/star/albumcover/500/64/96/2266534336.jpg",
                "originalsongtype":1,
                "songTimeMinutes":"04:29",
                "isListenFee":true,
                "pic120":"https://img2.kuwo.cn/star/albumcover/120/64/96/2266534336.jpg",
                "name":"晴天",
                "online":1,
                "payInfo":{
                    "play":"1111",
                    "download":"1111",
                    "local_encrypt":"1",
                    "limitfree":0,
                    "cannotDownload":0,
                    "refrain_start":83941,
                    "listen_fragment":"1",
                    "refrain_end":142584,
                    "cannotOnlinePlay":0,
                    "feeType":{
                        "song":"1",
                        "vip":"1"
                    },
                    "down":"1111"
                }
            }
        ]
    },
    "msg":"success",
    "profileId":"site",
    "reqId":"2601d2100f89ae34e799ad32c16277e6",
    "tId":""
}
```

# 排行榜

请求地址：
```
${root}/bang/bang/bangMenu?httpsStatus=1&reqId=e617e730-e1f7-11eb-942d-33e288737b1d
```

返回以下JSON数据：
```
{
    "code":200,
    "curTime":1632564679492,
    "data":[
        {
            "name":"官方榜",
            "list":[
                {
                    "sourceid":"93",
                    "intro":"酷我用户每天播放线上歌曲 的飙升指数TOP排行榜，为你展示流行趋势、蹿红歌曲，每天更新",
                    "name":"酷我飙升榜",
                    "id":"489929",
                    "source":"2",
                    "pic":"https://img3.kuwo.cn/star/upload/2/0/1632523319.png",
                    "pub":"今日更新"
                }
            ]
        }
    ],
    "msg":"success",
    "profileId":"site",
    "reqId":"178af75bd0ea3b7abb97aecf9bce4451",
    "tId":""
}
```

# 排行榜下的歌曲

请求地址：
```
${root}/bang/bang/musicList?bangId=${sourceid}&pn=${page}&rn=${itemSize}&httpsStatus=1&reqId=b092ca30-e152-11eb-90cc-79484e9fbe4d
```

返回以下JSON数据：
```
{
    "code":200,
    "curTime":1632568353890,
    "data":{
        "img":"https://img1.kuwo.cn/star/upload/11/11/1539055092699_.png",
        "num":"300",
        "pub":"2021-09-25",
        "musicList":[
            {
                "musicrid":"MUSIC_192972503",
                "barrage":"0",
                "artist":"刘耀文",
                "mvpayinfo":{
                    "play":0,
                    "vid":0,
                    "down":0
                },
                "trend":"e0",
                "pic":"https://img3.kuwo.cn/star/albumcover/500/49/15/1433066330.jpg",
                "isstar":0,
                "rid":192972503,
                "duration":195,
                "score100":"10",
                "content_type":"0",
                "rank_change":"0",
                "track":1,
                "hasLossless":true,
                "hasmv":0,
                "releaseDate":"2021-09-23",
                "album":"Got You",
                "albumid":23231994,
                "pay":"16515324",
                "artistid":3015711,
                "albumpic":"https://img3.kuwo.cn/star/albumcover/500/49/15/1433066330.jpg",
                "originalsongtype":1,
                "songTimeMinutes":"03:15",
                "isListenFee":false,
                "pic120":"https://img3.kuwo.cn/star/albumcover/120/49/15/1433066330.jpg",
                "name":"Got You",
                "online":1,
                "payInfo":{
                    "play":"1100",
                    "download":"1111",
                    "local_encrypt":"1",
                    "limitfree":0,
                    "cannotDownload":0,
                    "refrain_start":80000,
                    "refrain_end":113000,
                    "cannotOnlinePlay":0,
                    "feeType":{
                        "song":"1",
                        "vip":"1"
                    },
                    "down":"1111"
                }
            }
        ]
    },
    "msg":"success",
    "profileId":"site",
    "reqId":"538ba82c252350ee89c02897b76afdbb",
    "tId":""
}
```


# 获取播放地址

请求地址：
```
http://antiserver.kuwo.cn/anti.s?type=convert_url&rid=${musicrid}&format=mp3&response=url
```

返回歌曲播放地址，如以下：
```
http://sy.sycdn.kuwo.cn/0f85e8478c3ffa4b0216ecfa4d9a5974/614ef6f0/resource/n1/84/19/2974502628.mp3
```

# 歌手信息

请求地址：
```
$root/artist/artist?artistid=$id&httpsStatus=1&reqId=b06e62f0-f582-11eb-bd8d-c19fac490f25
```

返回以下JSON数据：
```
{
    "code":200,
    "curTime":1632565172999,
    "data":{
        "birthday":"1979-01-18",
        "country":"中国台湾",
        "artistFans":1186697,
        "albumNum":39,
        "gener":"男",
        "weight":"60kg",
        "language":"国语;",
        "mvNum":488,
        "pic":"https://star.kuwo.cn/star/starheads/120/10/6/294045140.jpg",
        "upPcUrl":"kuwo://Jump?param=ch%3A10002%3Bname%3Aartist%3Burl%3A%24%7Bnetsong%7Dcontent_artist.html%3Fsourceid%3D336%26name%3D%E5%91%A8%E6%9D%B0%E4%BC%A6%26playall%3Dtrue%26channel%3Dclassify&channel=classify",
        "musicNum":1680,
        "pic120":"https://star.kuwo.cn/star/starheads/120/10/6/294045140.jpg",
        "isStar":0,
        "birthplace":"台湾新北市林口区",
        "constellation":"魔羯座",
        "content_type":"0",
        "aartist":"Jay Chou",
        "name":"周杰伦",
        "pic70":"https://star.kuwo.cn/star/starheads/70/10/6/294045140.jpg",
        "id":336,
        "tall":"173cm",
        "pic300":"https://star.kuwo.cn/star/starheads/300/10/6/294045140.jpg",
        "info":"周杰伦（Jay Chou），1979年1月18日出生于台湾省新北市..."
    },
    "msg":"success",
    "profileId":"site",
    "reqId":"4354993b092aa04aaaaf9871ea1d5e62",
    "tId":""
}
```

# 获取歌手歌曲

请求地址：
```
$root/artist/artistMusic?artistid=$id&pn=$page&rn=$returnSize&httpsStatus=1&reqId=87263830-f72d-11eb-979c-c11891b4f2ba
```

返回以下JSON数据：
```
{
    "code":200,
    "curTime":1632565284612,
    "data":{
        "total":1680,
        "list":[
            {
                "musicrid":"MUSIC_228908",
                "barrage":"0",
                "artist":"周杰伦",
                "mvpayinfo":{
                    "play":"0",
                    "vid":"8247609",
                    "download":"0"
                },
                "pic":"https://img4.kuwo.cn/star/albumcover/120/64/96/2266534336.jpg",
                "isstar":0,
                "releasedate":"2003-07-01",
                "rid":228908,
                "duration":269,
                "score100":"91",
                "content_type":"0",
                "track":3,
                "hasLossless":true,
                "hasmv":1,
                "album":"叶惠美",
                "albumid":"1293",
                "pay":"16711935",
                "artistid":336,
                "albumpic":"https://img4.kuwo.cn/star/albumcover/120/64/96/2266534336.jpg",
                "originalsongtype":1,
                "songTimeMinutes":"04:29",
                "isListenFee":true,
                "pic120":"https://img4.kuwo.cn/star/albumcover/120/64/96/2266534336.jpg",
                "name":"晴天",
                "online":1,
                "payInfo":{
                    "play":"1111",
                    "download":"1111",
                    "local_encrypt":"1",
                    "limitfree":"0",
                    "cannotDownload":"0",
                    "refrain_start":"83941",
                    "cannotOnlinePlay":"0",
                    "feeType":{
                        "song":"1",
                        "album":"0",
                        "vip":"1",
                        "bookvip":"0"
                    },
                    "listen_fragment":"1",
                    "refrain_end":"142584",
                    "tips_intercept":"0"
                }
            }
        ]
    },
    "msg":"success",
    "profileId":"site",
    "reqId":"ea69aed1710580ba8ce9fb3a55eec28b",
    "tId":""
}
```

# 歌词

请求地址：（无需携带参数）
```
http://m.kuwo.cn/newh5/singles/songinfoandlrc?musicId=${rid}}&httpsStatus=1&reqId=f9204c10-1df1-11ec-8b4f-9f163660962a
```

返回以下JSON数据：
```
{
    "data":{
        "lrclist":[
            {
                "lineLyric":"晴天 - 周杰伦 (Jay Chou)",
                "time":"0.0"
            },
            {
                "lineLyric":"词：周杰伦",
                "time":"7.34"
            },
            {
                "lineLyric":"曲：周杰伦",
                "time":"14.69"
            },
            {
                "lineLyric":"编曲：周杰伦",
                "time":"22.04"
            },
            {
                "lineLyric":"故事的小黄花",
                "time":"29.39"
            },
            {
                "lineLyric":"从出生那年就飘着",
                "time":"32.64"
            },
            {
                "lineLyric":"童年的荡秋千",
                "time":"36.19"
            },
            {
                "lineLyric":"随记忆一直晃到现在",
                "time":"39.93"
            },
            {
                "lineLyric":"Re So So Si Do Si La ",
                "time":"42.99"
            },
            {
                "lineLyric":"So La Si Si Si Si La Si La So ",
                "time":"46.11"
            },
            {
                "lineLyric":"吹着前奏望着天空",
                "time":"49.79"
            },
            {
                "lineLyric":"我想起花瓣试着掉落",
                "time":"53.35"
            },
            {
                "lineLyric":"为你翘课的那一天",
                "time":"56.78"
            },
            {
                "lineLyric":"花落的那一天",
                "time":"59.03"
            },
            {
                "lineLyric":"教室的那一间",
                "time":"60.65"
            },
            {
                "lineLyric":"我怎么看不见",
                "time":"62.21"
            },
            {
                "lineLyric":"消失的下雨天",
                "time":"64.02"
            },
            {
                "lineLyric":"我好想再淋一遍",
                "time":"65.71"
            },
            {
                "lineLyric":"没想到失去的勇气我还留着",
                "time":"69.95"
            },
            {
                "lineLyric":"好想再问一遍",
                "time":"76.13"
            },
            {
                "lineLyric":"你会等待还是离开",
                "time":"77.87"
            },
            {
                "lineLyric":"刮风这天我试过握着你手",
                "time":"84.74"
            },
            {
                "lineLyric":"但偏偏雨渐渐大到我看你不见",
                "time":"90.42"
            },
            {
                "lineLyric":"还要多久我才能在你身边",
                "time":"98.84"
            },
            {
                "lineLyric":"等到放晴的那天也许我会比较好一点",
                "time":"105.4"
            },
            {
                "lineLyric":"从前从前有个人爱你很久",
                "time":"112.759995"
            },
            {
                "lineLyric":"但偏偏风渐渐把距离吹得好远",
                "time":"118.5"
            },
            {
                "lineLyric":"好不容易又能再多爱一天",
                "time":"126.74"
            },
            {
                "lineLyric":"但故事的最后你好像还是说了拜拜",
                "time":"133.35"
            },
            {
                "lineLyric":"为你翘课的那一天",
                "time":"155.0"
            },
            {
                "lineLyric":"花落的那一天",
                "time":"156.75"
            },
            {
                "lineLyric":"教室的那一间",
                "time":"158.63"
            },
            {
                "lineLyric":"我怎么看不见",
                "time":"160.31"
            },
            {
                "lineLyric":"消失的下雨天",
                "time":"162.05"
            },
            {
                "lineLyric":"我好想再淋一遍",
                "time":"163.74"
            },
            {
                "lineLyric":"没想到失去的勇气我还留着",
                "time":"167.98"
            },
            {
                "lineLyric":"好想再问一遍",
                "time":"174.53"
            },
            {
                "lineLyric":"你会等待还是离开",
                "time":"175.97"
            },
            {
                "lineLyric":"刮风这天我试过握着你手",
                "time":"182.77"
            },
            {
                "lineLyric":"但偏偏雨渐渐大到我看你不见",
                "time":"188.45"
            },
            {
                "lineLyric":"还要多久我才能在你身边",
                "time":"196.87"
            },
            {
                "lineLyric":"等到放晴的那天也许我会比较好一点",
                "time":"203.49"
            },
            {
                "lineLyric":"从前从前有个人爱你很久",
                "time":"210.91"
            },
            {
                "lineLyric":"偏偏风渐渐把距离吹得好远",
                "time":"217.03"
            },
            {
                "lineLyric":"好不容易又能再多爱一天",
                "time":"224.77"
            },
            {
                "lineLyric":"但故事的最后你好像还是说了拜拜",
                "time":"231.07"
            },
            {
                "lineLyric":"刮风这天我试过握着你手",
                "time":"239.62"
            },
            {
                "lineLyric":"但偏偏雨渐渐大到我看你不见",
                "time":"242.05"
            },
            {
                "lineLyric":"还要多久我才能够在你身边",
                "time":"245.44"
            },
            {
                "lineLyric":"等到放晴那天也许我会比较好一点",
                "time":"248.99"
            },
            {
                "lineLyric":"从前从前有个人爱你很久",
                "time":"252.86"
            },
            {
                "lineLyric":"但偏偏雨渐渐把距离吹得好远",
                "time":"255.86"
            },
            {
                "lineLyric":"好不容易又能再多爱一天",
                "time":"259.29"
            },
            {
                "lineLyric":"但故事的最后你好像还是说了拜",
                "time":"262.79"
            }
        ]
    },
    "msg":"成功",
    "msgs":null,
    "profileid":"site",
    "reqid":"bc2f73d3X804cX4d2cX91ceX6318cadbaee1",
    "status":200
}
```

# 获取歌手高清图片

JSON数据中的：`https://star.kuwo.cn/star/starheads/120/10/6/294045140.jpg`

更改为：`https://star.kuwo.cn/star/starheads/700/...`