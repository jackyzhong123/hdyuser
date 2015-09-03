//
//  AppConfig.swift
//  HDYAdmin
//
//  Created by haha on 15/9/1.
//  Copyright (c) 2015年 HuoDongYou. All rights reserved.
//

import UIKit





class AppConfig: NSObject {
    
    ////////////////////////////访问字符串
    //MARK: 一些基本的配置
    static let SERVICE_ROOT_PATH = "http://192.168.1.26:47897/"
    
    //MARK: 访问服务地址的配置
    //手机号登录
    static var  Url_NewOrgLogin = "api/Login/OrgLogin"
    
    //获得用户档案
    static var Url_getProfile="api/HuoDongService/getProfile"
    
    //上传头像
    static var Url_uploadImage="api/HdyUploadImageByUser"
    
    //更换头像
    static var Url_changeUserPortrait = "api/HuoDongService/changeUserPortrait"
    
    //获取我的专辑
    static var Url_getMyAlbumList="api/HuoDongService/getMyAlbumList"
    
    //增加新的专辑
    static var Url_AddNewAlbum="api/HuoDongService/AddNewAlbum"
    
    //获得我的地点
    static var Url_getMyLocationList="api/HuoDongService/getPlaceList"
    
    //短信验证
    static var Url_SMSVerify = "api/General/SMSVerify"
    
    //组织注册
    static var Url_OrgRegister = "api/Login/OrgRegister"
    
    //重置密码
    static var Url_ResetPwd = "api/Login/Reset"
    
    //获取我收藏的地址或创建的地址
    static var Url_MyLocationList = "api/HuoDongService/getPlaceList"
    
    //新增活动
    static var Url_AddActivity = "api/Activity/Create"
    
    static var Url_MyActivityList = "api/Activity/MyActivityList"
    
    static var Url_PersonRegister = "api/Login/PersonRegister"
    static var Url_PersonLogin = "api/Login/PersonLogin"
    
    
    ////////////////////////////=== Notification
    static var NF_SelectAlbum = "SelectAlbum"
    static var NF_SelectLocation = "SelectLocation"
    
    
    
    
    
    //MARK: 一些静态函数
    
    // NSData -> NSDictionary
    static func C_NSData2Dictionary(data:NSData) -> AnyObject
    {
        let dictionary:NSDictionary = NSKeyedUnarchiver.unarchiveObjectWithData(data)! as! NSDictionary
        
        return NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)!
        
        
     
    }
    
    // NSDictionary -> NSData
    static func C_Dictionary3NSData(data:NSDictionary) -> NSData
    {
        
        let dataExample : NSData = NSKeyedArchiver.archivedDataWithRootObject(data)
        return dataExample
    }
    
    

    
    
    //MARK:- 单例模式
    class var sharedAppConfig: AppConfig {
        struct Static {
            static var instance : AppConfig?
            static var token : dispatch_once_t = 0
        }
        dispatch_once(&Static.token) {
            Static.instance = AppConfig()
        }
        return Static.instance!
        
    }
    
    //MARK: 一些变量
    var AccessToken:String = ""
    var IsCreator = false
    var NickName = ""
    var Portrait = ""
    //MARK: 一些函数
    func isUserLogin()->Bool
    {
        return !self.AccessToken.isNullOrEmpty()
    }
    
    func getAuthorizationString()->String
    {
        return String(format: "Bearer %@",AppConfig.sharedAppConfig.AccessToken)
        
    }
    
    func syncUserInfo(data : AnyObject)
    {
        var varData = data as! NSData;
        let dataDir:NSDictionary =  NSJSONSerialization.JSONObjectWithData(varData, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSDictionary
        
        AppConfig.sharedAppConfig.NickName = dataDir.objectForKey("Name") as! String
        AppConfig.sharedAppConfig.Portrait = dataDir.objectForKey("Portrait") as! String
        AppConfig.sharedAppConfig.save()
    NSNotificationCenter.defaultCenter().postNotificationName("ReloadUserInfo_Notiication", object: nil)
    }
    
    
    
    func userLogout()
    {
        self.AccessToken = ""
        self.save()
        NSNotificationCenter.defaultCenter().postNotificationName("user-login-logout", object: nil, userInfo: nil)
    }
    
    func save()->Bool
    {
        var ud = NSUserDefaults.standardUserDefaults()
        if(!self.AccessToken.isNullOrEmpty())
        {
            ud.setObject(self.AccessToken, forKey: "Configuration_Token")
        }
        else
        {
            ud.removeObjectForKey("Configuration_Token")
        }
        
        ud.setBool(IsCreator, forKey: "Configuration_CurrentIsCreator")
        
        if(!self.Portrait.isNullOrEmpty())
        {
            ud.setObject(self.Portrait, forKey: "Configuration_Portrait")
        }
        else
        {
            ud.removeObjectForKey("Configuration_Portrait")
        }
        
        if(!self.NickName.isNullOrEmpty())
        {
            ud.setObject(self.NickName, forKey: "Configuration_NickName")
        }
        else
        {
            ud.removeObjectForKey("Configuration_NickName")
        }
        
        
        
        return true
    }
    
    
    
    
    //MARK:其他
    override init()
    {
        super.init();
        self.load()
    }
    
    
    func load()
    {
        var ud = NSUserDefaults.standardUserDefaults()
        if(ud.objectForKey("Configuration_Token") != nil)
        {
            self.AccessToken = ud.objectForKey("Configuration_Token") as! String;
        }
      
        if(ud.objectForKey("Configuration_NickName") != nil)
        {
            self.NickName = ud.objectForKey("Configuration_NickName") as! String;
        }
        if(ud.objectForKey("Configuration_Portrait") != nil)
        {
            self.Portrait = ud.objectForKey("Configuration_Portrait") as! String;
        }
        
        if(ud.boolForKey("Configuration_CurrentIsCreator"))
        {
            self.IsCreator = ud.boolForKey("Configuration_CurrentIsCreator")
        }
    }
    
    
    
    
    
    
}