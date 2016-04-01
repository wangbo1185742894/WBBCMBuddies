//
//  BCMURLDefineFile.h
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/16.
//  Copyright © 2016年 鲁智星. All rights reserved.
//
#define LogIn 0

#if  LogIn==0   //测试
#define BASE_URL @"http://123.57.173.34:8080/v1.1/"
#elif  LogIn ==1 //正式
#define BASE_URL @"http://192.168.4.83:8081"

#endif


//请求接口

#define CREATELIKESURL               [NSString stringWithFormat:@"%@/likes/{type}/{resid}/create",BASE_URL]  //添加喜欢（POST）
#define BYMELIKESURL               @"likes/%@/byme"  //我发出的喜欢列表 (GET)
#define BYMEWORKSURL               @"dances/works/byme"  //获取老师我的作品接口 (GET)

#define TOMELIKESURL               [NSString stringWithFormat:@"%@/likes/{type}/tome",BASE_URL]  //我收到的喜欢列表 (GET)
#define LIKESURL               [NSString stringWithFormat:@"%@/likes/{type}/{resid}",BASE_URL]  //指定资源喜欢列表 (GET)
#define DESTORYLIKESURL               [NSString stringWithFormat:@"%@/likes/{type}/{resid}/{lid}/destory",BASE_URL]  //删除喜欢 (DELETE)
#define APPLYTEACHERURL               @"teacher/apply"  //普通会员申请成为老师 (POST)
#define SENDFEEDBACKURL               @"feedback/sendFeedback"  //提交意见反馈 (POST)
#define PROFILEUSERURL               @"user/profile/"  //获取用户主页信息 (GET)
#define REGISTWITHNUMBERURL               @"create"  //手机用户注册 (POST)
#define CHECKPHONENUMBERURL               @"check_mobile"  //检查手机号码是否已经注册 (POST)
#define CHANGUSERINFOURL               @"user/edit"  //用户信息修改 (POST)
#define CHANGUSERHEADIMAGEURL               [NSString stringWithFormat:@"%@/user/avatar",BASE_URL]  //用户头像修改 (POST)
#define CHANGUSERSIGNATUREURL          @"user/signature"  //用户签名修改 (POST)
#define GETUSERINFOURL               @"users/"  //用户信息查询 (GET)
#define CREATECOMMENTSURL               @"comments"  //发布一个评论 (POST)
#define GETCOMMENTSLISTURL               [NSString stringWithFormat:@"%@/comments/{type}/{resid}",BASE_URL]  //获取评论列表 (GET)
#define REPLYCOMMENTSURL               [NSString stringWithFormat:@"%@/comments/comments/{type}/{resid}/{cid}/reply",BASE_URL]  //回复评论 (POST)
#define DELETECOMMENTSURL               [NSString stringWithFormat:@"%@/comments/comments/{type}/{resid}/{cid}/destory",BASE_URL]  //删除一条指定评论 (DELETE)
#define RESETFINDPWDURL               @"credential/findpwd/reset"  //找回密码的重设密码 (POST)
#define UPDATEPASSWORDURL               [NSString stringWithFormat:@"%@/credential/password/update",BASE_URL]  //用户修改密码 (POST)
#define ADDACCOUNTURL               [NSString stringWithFormat:@"%@/sample/addAccount",BASE_URL]  //接口描述 (POST)
#define SENDVERIFYCODEURL               @"verifycode/sendVerifycode"  //获取验证码 (POST)
#define CHECKVERIFYCODEURL               @"verifycode/checkVerifycode"  //判断验证码 (POST)
#define USERLOGINURL                  @"user/login"  //用户登录
#define GETEXERCISEROOMLISTURL         @"dances/"  //练习室列表
#define GETUSERTOKENURL               @"oauth/token"  //获取用户token
#define REFRSHUSERTOKENURL               @"oauth/token"  //刷新用户token
#define GETTOPICLISTURL               @"topic/show"  //话题列表
#define GETACTIVITYCLISTURL           @"activity/show"  //活动列表
#define GETNEWSLISTURL                @"news/show"  //新闻列表
#define GETNEWSINFOTURL               [NSString stringWithFormat:@"%@/news/details/{newsid}",BASE_URL]  //新闻详情
#define GETNORMALVIDEOINFOURL          @"dances/"  //获取单个练习室信息, 携带视频列表
#define GETCMMENTLISTURL               @"comments/"  //获取评论列表
#define CREATELIKEURL               @"likes"  //添加喜欢
#define DELETELIKEURL               @"likes"  //删除喜欢
#define USERGUIDEURL               [NSString stringWithFormat:@"%@static/guide.html",BASE_URL]  //新手规范
#define USERAGREEMENTURL               [NSString stringWithFormat:@"%@static/agreement.html",BASE_URL]  //新手规范
//#define GETQINIUTOKENURL               @"oauth/qiniu/token"  //获取七牛TOKEN
#define RELEASEACTIVITYNURL               @"activity/create"  //发布活动
#define RELEASETOPICURL               @"topic/create"  //话题发布
#define CREATESHAREURL               @"share"  //添加分享
#define GETBANNERSURL               @"banners"  //获取banners
#define SHAREURL               @"video/video.html?"  //获取banners
#define ACTIVITYSIGNUPS               @"activity/"  //活动报名相关信息
#define DELETEACTIVITY               @"activity/"  //活动删除
#define GETTEACHERSHOWLIST               @"teacher/show"  //获取广场舞蹈老师列表
#define GETTEACHERWORKSLIST               @"dances/works/"  //获取指定id老师的作品
#define CREATEFILEURL               @"file/create"  //文件上传
#define GETUSERTOPICURL               @"topic/%@/show"  //获取指定用户发出的话题
#define SEARCHVIDEOURL               @"dances/search"  //练习室搜索


