import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:music_api/api/netease/net_request.dart';
import 'package:music_api/entity/music_entity.dart';
import 'package:music_api/utils/answer.dart';
import 'package:music_api/utils/types.dart';
import 'package:music_api/utils/utils.dart';
import 'package:universal_io/io.dart';
import 'dart:math' as math;

part 'module/record.dart';

part 'module/sign.dart';

part 'module/album.dart';

part 'module/artist.dart';

part 'module/banner.dart';

part 'module/batch.dart';

part 'module/calendar.dart';

part 'module/captcha.dart';

part 'module/check_music.dart';

part 'module/cloud_match.dart';

part 'module/comment.dart';

part 'module/countries.dart';

part 'module/daily_signin.dart';

part 'module/digitalAlbum.dart';

part 'module/dj.dart';

part 'module/event.dart';

part 'module/fm.dart';

part 'module/history.dart';

part 'module/homepage.dart';

part 'module/hot.dart';

part 'module/like.dart';

part 'module/listen.dart';

part 'module/login.dart';

part 'module/lyric.dart';

part 'module/msg.dart';

part 'module/musician.dart';

part 'module/mlog.dart';

part 'module/mv.dart';

part 'module/personal.dart';

part 'module/playlist.dart';

part 'module/playmode.dart';

part 'module/recommend.dart';

part 'module/register.dart';

part 'module/related.dart';

part 'module/resource_like.dart';

part 'module/scrobble.dart';

part 'module/search.dart';

part 'module/send.dart';

part 'module/setting.dart';

part 'module/share.dart';

part 'module/simi.dart';

part 'module/song.dart';

part 'module/top.dart';

part 'module/user.dart';

part 'module/video.dart';

part 'module/weblog.dart';

part 'module/vip.dart';

part 'module/yunbei.dart';

class Netease {
  Netease._();

  static Future<Answer> banner() {
    return _banner.call({}, []);
  }

  static Future<Answer> search({String? keyWord, int? type, int? page, int? size}) {
    return _search.call({"keyWord": keyWord, "type": type, "page": page, "size": size}, []);
  }

  static Future<Answer> songUrl({String? id, int? br}) {
    return _songUrl.call({"id": id, "br": br}, []);
  }

  ///精品歌单
  static Future<Answer> topPlaylist({String? cat, int? page, int? size}) {
    return _topPlaylist.call({"cat": cat, "page": page, "size": size}, []);
  }

  ///通过传过来的歌单id拿到所有歌曲数据
  static Future<Answer> playlistTrackAll({required String? id}) {
    return _playlistTrackAll.call({
      "id": id,
    }, []);
  }

  static Future<Answer> api(String? path, {Map? params, List<Cookie> cookie = const []}) {
    if (!_api.containsKey(path)) {
      return Future.value(const Answer(site: MusicSite.Netease).copy(code: 500, msg: "url:“$path”未被定义, 请检查", data: _api.keys.toList()));
    }
    return _api[path]!.call(params ?? {}, cookie);
  }
}

//Api列表
final _api = <String, Api>{
  //专辑
  "/album": _album,
  "/album/detail/dynamic": _albumDetailDynamic,
  "/album/detail": _albumDetail,
  "/album/style": _albumStyle,
  "/album/list": _albumList,
  "/album/new": _albumNewest,
  "/album/newest": _albumNewest,
  "/album/songsaleboard": _albumSongSaleBoard,
  "/album/sub": _albumSub,
  "/album/sublist": _albumSublist,
  "/album/sales": _albumSales,
  //歌手
  "/artist/album": _artistAlbum,
  "/artist/desc": _artistDesc,
  "/artist/detail": _artistDetail,
  "/artist/list": _artistList,
  "/artist/mv": _artistMv,
  "/artist/video": _artistVideo,
  "/artist/new/mv": _artistNewMv,
  "/artist/new/song": _artistNewSong,
  "/artist/songs": _artistSongs,
  "/artist/sub": _artistSub,
  "/artist/sublist": _artistSubList,
  "/artist/top/song": _artistTopSong,
  "/artists": _artists,
  "/artists/fans": _artistFans,
  //Banner
  "/banner": _banner,
  // 批量请求接口
  "/batch": _batch,
  //音乐日历
  "/calendar": _calendar,
  //验证码
  "/captcha/send": _captchaSend,
  "/captcha/verify": _captchaVerify,
  //音乐是否可用
  "check/music": _checkMusic,
  //云盘
  "cloud/match": _cloudMatch,
  //评论
  "/comment/album": _commentAlbum,
  "/comment/dj": _commentDj,
  "/comment/events": _commentEvents,
  "/comment/floor": _commentFloor,
  "/comment/hot": _commentHot,
  "/comment/hug/list": _commentHugList,
  "/comment/hug": _commentHugListener,
  "/comment/like": _commentLike,
  "/comment/music": _commentMusic,
  "/comment/mv": _commentMv,
  "/comment/playlist": _commentPlaylist,
  "/comment/video": _commentVideo,
  "/comment/new": _commentNew,
  "/comment": _comment,
  //签到
  "/daily_signin": _dailySignin,
  //数字专辑
  "/digitalAlbum/ordering": _digitalAlbumOrdering,
  "/digitalAlbum/purchased": _digitalAlbumPurchased,
  //电台
  "/dj/banner": _djBanner,
  "/dj/category/excludehot": _djCategoryExcludehot,
  "/dj/category/recommend": _djCategoryRecommend,
  "/dj/catelist": _djCatelist,
  "/dj/detail": _djDetail,
  "/dj/hot": _djHot,
  "/dj/paygift": _djPaygift,
  "/dj/personalize/recommend": _djPersonalizeRcmd,
  "/dj/program/detail": _djProgramDetail,
  "/dj/program/toplist/hours": _djProgramToplistHours,
  "/dj/program/toplist": _djProgramToplist,
  "/dj/program": _djProgram,
  "/dj/radio/hot": _djRadioHot,
  "/dj/recommend/type": _djRecommendType,
  "/dj/recommend": _djRecommend,
  "/dj/sub": _djSub,
  "/dj/sublist": _djSublist,
  "/dj/subscriber": _djSubscriber,
  "/dj/today/perfered": _djTodayPerfered,
  "/dj/toplist/hours": _djToplistHours,
  "/dj/toplist/newcomer": _djToplistNewcomer,
  "/dj/toplist/pay": _djToplistPay,
  "/dj/toplist/popular": _djToplistPopular,
  "/dj/toplist": _djToplist,
  //动态
  "/event/del": _eventDel,
  "/event/forward": _eventForward,
  "/event": _event,
  //垃圾桶
  "/fm_trash": _fmTrash,
  //历史日推
  "/history/recommend/songs/detail": _historyRecommendSongsDetail,
  "/history/recommend/songs": _historyRecommendSongs,
  //首页
  "/homepage/block/page": _homepageBlockPage,
  "/homepage/dragon/ball": _homepageDragonBall,
  //热门话题
  "/hot/topic": _hotTopic,
  //喜欢音乐
  "/like": _like,
  "/likelist": _likelist,
  //一起听状态
  "listen/together/status": _listenTogetherStatus,
  //登录
  "/login/cellphone": _loginCellphone,
  "/login/qr/check": _loginQrCheck,
  "/login/qr/create": _loginQrCreate,
  "/login/qr/key": _loginQrKey,
  "/login/refresh": _loginRefresh,
  "/login/status": _loginStatus,
  "/login": _login,
  "/logout": _logout,
  "/cellphone/existence/check": _cellphoneExistenceCheck,
  "/activate/init/profile": _activateInitProfile,
  //歌词
  "/lyric": _lyric,
  //mlog
  "/mlog/video": _mlogToVideo,
  "/mlog/url": _mlogUrl,
  "/mlog/music/rcmd": _mlogMusicRcmd,
  //通知消息
  "/msg/comment": _msgComment,
  "/msg/forwards": _msgForwards,
  "/msg/notice": _msgNotice,
  "/msg/private/history": _msgPrivateHistory,
  "/msg/private": _msgPrivate,
  "/msg/recentcontact": _msgRecentcontact,
  //音乐人
  'musician/cloudbean': _musicianCloudBean,
  'musician/cloudbean/obtain': _musicianCloudBeanObtain,
  'musician/data/overview': _musicianDataOverview,
  'musician/play/trend': _musicianPlayTrend,
  'musician/task': _musicianTask,
  'musician/sign': _musicianSign,
  //MV
  "/mv/all": _mvAll,
  "/mv/detail/info": _mvDetailInfo,
  "/mv/detail": _mvDetail,
  "/mv/exclusive/rcmd": _mvExclusiveRcmd,
  "/mv/first": _mvFirst,
  "/mv/sub": _mvSub,
  "/mv/sublist": _mvSublist,
  "/mv/url": _mvUrl,
  //电台
  "/personal_fm": _personalFm,
  "/personalized/djprogram": _personalizedDjprogram,
  "/personalized/mv": _personalizedMv,
  "/personalized/newsong": _personalizedNewsong,
  "/personalized/privatecontent/list": _personalizedPrivatecontentList,
  "/personalized/privatecontent": _personalizedPrivatecontent,
  "/personalized": _personalized,

  //歌单
  "/playlist/catlist": _playlistCatlist,
  "/playlist/create": _playlistCreate,
  "/playlist/delete": _playlistDelete,
  "/playlist/desc/update": _playlistDescUpdate,
  "/playlist/detail/dynamic": _playlistDetailDynamic,
  "/playlist/detail": _playlistDetail,
  "/playlist/track/all": _playlistTrackAll,
  "/playlist/highquality/tags": _playlistHighqualityTags,
  "/playlist/hot": _playlistHot,
  "/playlist/mylike": _playlistMyLike,
  "/playlist/name/update": _playlistNameUpdate,
  "/playlist/order/update": _playlistOrderUpdate,
  "/playlist/subscribe": _playlistSubscribe,
  "/playlist/subscribers": _playlistSubscribers,
  "/playlist/tags/update": _playlistTagsUpdate,
  "/playlist/track/add": _playlistTrackAdd,
  "/playlist/track/delete": _playlistTrackDelete,
  "/playlist/tracks": _playlistTracks,
  "/playlist/update": _playlistUpdate,
  "/playlist/video/recent": _playlisVideoRecent,
  "/playlist/privacy": _playlisPrivacy,
  //心动模式/智能播放
  "/playmode/intelligence/list": _playmodeIntelligenceList,
  //推荐
  "/program/recommend": _programRecommend,
  "/recommend/resource": _recommendResource,
  "/recommend/songs": _recommendSongs,
  //注册(修改密码)
  "/register/cellphone": _registerCellphone,
  //相关
  "/related/allvideo": _relatedAllvideo,
  "/related/playlist": _relatedPlaylist,
  //资源点赞( MV,电台,视频)
  "/resource/like": _resourceLike,
  "/scrobble": _scrobble,
  //搜索
  "/search/default": _searchDefaultKeyword,
  "/search/hot/detail": _searchHotDetail,
  "/search/hot": _searchHot,
  "/search/multimatch": _searchMultimatch,
  "/search/suggest": _searchSuggest,
  "/search": _search,
  "/cloudSearch": _cloudSearch,
  //私信
  "send/playlist": _sendPlaylist,
  "send/song": _sendSong,
  "send/text": _sendText,
  //设置
  "setting": _setting,
  //分享
  "/share/resource": _shareResource,
  //相似
  "/simi/artist": _simiArtist,
  "/simi/mv": _simiMv,
  "/simi/playlist": _simiPlaylist,
  "/simi/song": _simiSong,
  "/simi/user": _simiUser,
  //歌曲
  "/song/detail": _songDetail,
  "/song/order/update": _songOrderUpdate,
  "/song/url": _songUrl,
  "/song/download/url": _songDownloadUrl,
  "/song/purchased": _songPurchased,
  //热门
  "/top/album": _topAlbum,
  "/top/artists": _topArtists,
  "/top/list": _topList,
  "/top/mv": _topMv,
  "/top/playlist/highquality": _topPlaylistHighquality,
  "/top/playlist": _topPlaylist,
  "/top/song": _topSong,
  //话题
  "/topic/detail/event/hot": _topicDetailEventHot,
  "/topic/detail": _topicDetail,
  "/topic/sublist": _topicSubList,
  //榜单
  "/toplist/artist": _toplistArtist,
  "/toplist/detail": _toplistDetail,
  "/toplist": _toplist,
  //用户
  "/user/account": _userAccount,
  "/user/audio": _userAudio,
  "/user/bindingCellphone": _userBindingCellphone,
  "/user/binding": _userBinding,
  "/user/cloud/del": _userCloudDel,
  "/user/cloud/detail": _userCloudDetail,
  "/user/cloud": _userCloud,
  "/user/detail": _userDetail,
  "/user/dj": _userDj,
  "/user/event": _userEvent,
  "/follow": _userFollow,
  "/user/followeds": _userFolloweds,
  "/user/follows": _userFollows,
  "/user/level": _userLevel,
  "/user/playlist": _userPlaylist,
  "/user/record": _userRecord,
  "/user/replacephone": _userReplaceCellphone,
  "/user/subcount": _userSubcount,
  "/user/update": _userUpdate,
  "/user/comment/history": _userCommentHistory,
  //视频
  "/video/detail/info": _videoDetailInfo,
  "/video/detail": _videoDetail,
  "/video/group/list": _videoGroupList,
  "/video/group": _videoGroup,
  "/video/sub": _videoSub,
  "/video/timeline/all": _videoTimelineAll,
  "/video/timeline/recommend": _videoTimelineRecommend,
  "/video/url": _videoUrl,
  //VIP
  "vip/growthpoint": _vipGrowthpoint,
  "vip/growthpoint/detail": _vipGrowthpointDetail,
  "vip/growthpoint/get": _vipGrowthpointGet,
  "vip/task": _vipTasks,
  "vip/info": _vipInfo,

  "/weblog": _weblog,
  //云贝
  "/yunbei/tasks/expense": _yunbeiExpense,
  "/yunbei/info": _yunbeiInfo,
  "/yunbei/tasks/receipt": _yunbeiReceipt,
  "/yunbei/sign": _yunbeiSign,
  "/yunbei/task/finish": _yunbeiTaskFinish,
  "/yunbei/tasks/todo": _yunbeiTaskTodo,
  "/yunbei/tasks": _yunbeiTask,
  "/yunbei/today": _yunbeiToday,
  "/yunbei": _yunbei,
  "/yunbei/rcmd/song": _yunbeiRcmdSong,
  "/yunbei/rcmd/song/hhistory": _yunbeiRcmdSongHistory,

  // 乐签信息接口
  "/sign/happy/info": _signHappyInfo,

  ///最近播放
  "/record/recent/album": _recordRecentAlbum,
  "/record/recent/dj": _recordRecentDj,
  "/record/recent/song": _recordRecentSong,
  "/record/recent/playlist": _recordRecentPlaylist,
  "/record/recent/voice": _recordRecentVoice,
  "/record/recent/cideo": _recordRecentVideo,
};
