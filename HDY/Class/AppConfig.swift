//
//  AppConfig.swift
//  HDYAdmin
//
//  Created by haha on 15/9/1.
//  Copyright (c) 2015年 HuoDongYou. All rights reserved.
//

import UIKit





class AppConfig: NSObject {
    
    //对个人版本和组织号版本，各不一样
    static var  IsUserVersion  = true
    
    
    ////////////////////////////访问字符串
    //MARK: 一些基本的配置
    static var SERVICE_ROOT_PATH = "http://192.168.1.26:47897/"
    
    //MARK: 访问服务地址的配置
    //手机号登录
    static var  Url_NewOrgLogin = "api/Login/OrgLogin"
    
    //发送短信
    static var Url_SendSMS = "api/General/SendSMS"
    
    //获得用户档案
    static var Url_getProfile="api/Login/getProfile"
    
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
    
    static var Url_ChangeRealName = "api/Login/ChangeRealName"
    
    static var Url_ChangeSex = "api/Login/ChangeSex"
    
    static var Url_ChangeHDYName = "api/Login/ChangeHDYName"
    
    static var Url_ActivityList = "api/Activity/ActivityList"
    
    static var Url_LocationList = "api/Activity/LocationList"
    
    static var Url_AlbumList = "api/Activity/AlbumList"
    
    static var Url_PersonList = "api/Contact/PersonList"
    
    static var Url_OrgList = "api/Contact/OrgList"
    
    static var Url_MyFollwerAndLocation = "api/Contact/MyFollowingAndLocation"
    
    static var Url_MakeFavLocation = "api/Contact/MakeFavLocation"
    
    static var Url_MakeFollow = "api/Contact/MakeFollow"
    
    
    ////////////////////////////=== Notification
    static var NF_SelectAlbum = "SelectAlbum"
    static var NF_SelectLocation = "SelectLocation"
    static var NF_ChangeUerProfile = "ChangeUerProfile"
    
    
    
    
    
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
    var HDYName = ""
    var Portrait = ""
    var RealName = ""
    var IsTest = false
    var MySex:Int?
    
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
        
        AppConfig.sharedAppConfig.HDYName = dataDir.objectForKey("HDYName") as! String
        AppConfig.sharedAppConfig.Portrait = dataDir.objectForKey("Portrait") as! String
        AppConfig.sharedAppConfig.RealName = dataDir.objectForKey("RealName") as! String
        AppConfig.sharedAppConfig.IsTest = dataDir.objectForKey("IsTest") as! Bool
        AppConfig.sharedAppConfig.MySex = dataDir.objectForKey("MySex") as! Int
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
        
        
        if(self.MySex != nil)
        {
            ud.setInteger(MySex!, forKey: "Configuration_MySex")
        }
        else
        {
            ud.removeObjectForKey("Configuration_MySex")
        }
        
        
        ud.setBool(IsCreator, forKey: "Configuration_CurrentIsCreator")
        ud.setBool(IsTest, forKey: "Configuration_CurrentIsTest")
        
        if(!self.Portrait.isNullOrEmpty())
        {
            ud.setObject(self.Portrait, forKey: "Configuration_Portrait")
        }
        else
        {
            ud.removeObjectForKey("Configuration_Portrait")
        }
        
        if(!self.HDYName.isNullOrEmpty())
        {
            ud.setObject(self.HDYName, forKey: "Configuration_HDYName")
        }
        else
        {
            ud.removeObjectForKey("Configuration_HDYName")
        }
        
        if(!self.RealName.isNullOrEmpty())
        {
            ud.setObject(self.RealName, forKey: "Configuration_RealName")
        }
        else
        {
            ud.removeObjectForKey("Configuration_RealName")
        }
        ud.synchronize()
        
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
      
        if(ud.objectForKey("Configuration_HDYName") != nil)
        {
            self.HDYName = ud.objectForKey("Configuration_HDYName") as! String;
        }
        if(ud.objectForKey("Configuration_RealName") != nil)
        {
            self.RealName = ud.objectForKey("Configuration_RealName") as! String;
        }
        
        if(ud.objectForKey("Configuration_Portrait") != nil)
        {
            self.Portrait = ud.objectForKey("Configuration_Portrait") as! String;
        }
        
        if(ud.objectForKey("Configuration_CurrentIsTest") != nil)
        {
            self.IsCreator = ud.boolForKey("Configuration_CurrentIsCreator")
        }
        
        if(ud.objectForKey("Configuration_CurrentIsTest") != nil)
        {
            self.IsTest = ud.boolForKey("Configuration_CurrentIsTest")
        }
        
        if(ud.objectForKey("Configuration_MySex") != nil)
        {
            self.MySex = ud.integerForKey("Configuration_MySex")
        }
        
    }
    
    
    
    
    
    
}
