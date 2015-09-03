//
//  LoginVC.swift
//  HDYAdmin
//
//  Created by haha on 15/9/1.
//  Copyright (c) 2015年 HuoDongYou. All rights reserved.
//

import UIKit


class LoginVC: RootVC  {
    
    
    @IBOutlet weak var txtPWD: UITextField!
    @IBOutlet weak var txtUID: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
          self.IsNeedDoneButton = true
        super.viewDidLoad()
        
        
        // self.navigationController.navigationBar.translucent = true
        
        UIHelper.buildButtonFilletStyle(btnLogin, borderColor: UIHelper.mainColor)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
      
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func RenderDetail() {
         UIHelper.SetNaviBarRightItemWithName(self, action: "toggleRightMenu:", strName: "注册")
    }
    
    
    
    func toggleRightMenu(sender: AnyObject)
    {
        self.navigationController?.pushViewController(UIHelper.GetVCWithIDFromStoryBoard(.Account, viewControllerIdentity: "RegisterVC"), animated: true)
    }
    
    
    
    
    
    
    //MARK: 按钮及网络调用
    @IBAction func btnLoginTapped(sender: AnyObject) {
        
        var tag = (sender as! UIButton).tag
        if (tag==10)
        {
            if (self.txtUID.text.length  == 0 || self.txtPWD.text.isNullOrEmpty())
            {
                return
            }
            self.view.endEditing(true)
            SVProgressHUD.showWithStatusWithBlack("请稍候")
            
            
            let postBody=[
                "NickName": self.txtUID.text,
                "Password": self.txtPWD.text,
                "Device":"iPhone"
            ]
            self.httpPostApi(AppConfig.Url_NewOrgLogin, body: postBody, tag: 10)
            
            
        } else if (tag == 13)
        {
            var vc = UIHelper.GetVCWithIDFromStoryBoard(.Account, viewControllerIdentity: "FindPwdStep1")
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        }
        
        
        
        
    }
    
    override func requestDataComplete(response:AnyObject,tag:Int)
    {
        if (tag == 10) {
            
            if (response is NSDictionary)
            {
                
                var jsonData=JSON(response)
                
                AppConfig.sharedAppConfig.AccessToken = jsonData["token"].string!
                AppConfig.sharedAppConfig.IsCreator  = jsonData["IsCreator"].boolValue
                AppConfig.sharedAppConfig.NickName = jsonData["NickName"].string!
                AppConfig.sharedAppConfig.Portrait = jsonData["Portrait"].string!
                
                
                AppConfig.sharedAppConfig.save()
                SVProgressHUD.showSuccessWithStatusWithBlack("登录成功");
                
                var storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                self.view.window!.rootViewController = storyboard.instantiateInitialViewController() as? UIViewController
                
            }
            
        }
        else if (tag == 11) {
            var dic = response as! NSDictionary
            
            //            var   currUserItem:UserModel! = UserModel(dict: dic);
            //            if(currUserItem != nil && currUserItem.ItemID > 0)
            //            {
            //                dataMgr.saveUserInfo(dic)
            //            }
            //            self.toggleLeftMenu(self);
            //            NSNotificationCenter.defaultCenter().postNotificationName(self.userStatusChangeKey, object: nil)
        }
    }
    
    
    
    
    
}
