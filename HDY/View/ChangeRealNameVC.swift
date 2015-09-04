//
//  ChangeRealNameVC.swift
//  HDY
//
//  Created by Sky on 15/9/4.
//  Copyright (c) 2015年 edonesoft. All rights reserved.
//

import UIKit


class ChangeRealNameVC: RootVC   {
    
    
    //MARK: 页面变量
    
    @IBOutlet var txtName: UITextField!
    
    
    //MARK: 页面生存周期
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func toggleRightMenu(sender: AnyObject)
    {
        let parameter = ["name": self.txtName.text ]
        self.httpPostApi(AppConfig.Url_ChangeRealName, body: parameter, tag: 11)
    }
    
    
    
    
    //MARK: 渲染详细
    override func RenderDetail()
    {
        self.title="更换姓名";
        self.txtName.text = AppConfig.sharedAppConfig.RealName
        
        UIHelper.SetNaviBarRightItemWithName(self, action: "toggleRightMenu:", strName: "保存")
        
    }
    
    //MARK: 按钮点击事件
    override func ButtonTap(tag: Int) {
        
    }
    
    
    //MARK: 网络调用返回
    override func requestDataComplete(response:AnyObject,tag:Int)
    {
        if (tag == 11)
        {
            AppConfig.sharedAppConfig.RealName = response as! String
            AppConfig.sharedAppConfig.save()
             NSNotificationCenter.defaultCenter().postNotificationName(AppConfig.NF_ChangeUerProfile, object: nil, userInfo: nil)
            self.navigationController?.popViewControllerAnimated(true)
            return
        }
        
        if (response is NSDictionary)
        {
            
            var jsonData=JSON(response)
            
        }
    }
    
    
    
    
}
