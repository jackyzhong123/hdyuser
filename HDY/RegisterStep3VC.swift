//
//  RegisterStep3VC.swift
//  HDYAdmin
//
//  Created by Sky on 15/9/1.
//  Copyright (c) 2015年 HuoDongYou. All rights reserved.
//

import UIKit

class RegisterStep3VC: RootVC {
    
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var txtConfrimPwd: UITextField!
    @IBOutlet weak var txtPwd: UITextField!
    @IBOutlet weak var lbMsg: UILabel!
    var strPhone:String!;
    var countryID:Int!;
    var strVcode:String!;
    var isFromFindPwd = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func RenderDetail() {
        btnDone.layer.cornerRadius = 8;
        btnDone.layer.masksToBounds=true
        btnDone.layer.borderWidth = 1;
        btnDone.layer.borderColor = UIHelper.mainColor.CGColor;
        
        if(isFromFindPwd)
        {
            self.title = "忘记密码";
        }
        else
        {
            self.title = "注册";
        }
        
        lbMsg.text = "";
    }
 
    @IBAction func btnActionTapped(sender: AnyObject) {
        
        lbMsg.text = "";
        if(txtPwd.text.trim().length>=6 && txtPwd.text ==  txtConfrimPwd.text.trim())
        {
            
            
            SVProgressHUD.showWithStatusWithBlack("请稍后...");
            if(!isFromFindPwd)
            {
                let parameters = [
                    "Mobile": strPhone,
                    "Password": txtPwd.text,
                    "Code":strVcode
                ]
                self.httpPostApi(AppConfig.Url_PersonRegister, body: parameters, tag: 11)
            }
            else
            {
                let parameters = [
                    "Mobile": strPhone,
                    "Password": txtPwd.text,
                    "Code":strVcode
                ]
                self.httpPostApi(AppConfig.Url_ResetPwd, body: parameters, tag: 12)
            }
        }
        else
        {
            if(txtPwd.text.trim().length<6)
            {
                lbMsg.text = "密码长度不得少于6位"
            }
            if(txtPwd.text.trim() != txtConfrimPwd.text.trim())
            {
                lbMsg.text = "两次输入的密码不一致，请检查"
            }
        }
        
    }
    
    
    
    override func requestDataComplete(response:AnyObject,tag:Int)
    {
        
        if (response is NSDictionary)
        {
            var jsonData=JSON(response)
            if (tag == 11)
            {
                AppConfig.sharedAppConfig.AccessToken = jsonData["token"].string!
                AppConfig.sharedAppConfig.IsCreator  = true
                AppConfig.sharedAppConfig.HDYName = jsonData["HDYName"].string!
                AppConfig.sharedAppConfig.Portrait = jsonData["Portrait"].string!       
                
                AppConfig.sharedAppConfig.save()
                SVProgressHUD.showSuccessWithStatusWithBlack("登录成功");
                
                var storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                self.view.window!.rootViewController = storyboard.instantiateInitialViewController() as? UIViewController
                
                
            }else if (tag == 12)
            {
                
                if (jsonData["code"] == 1)
                {
                    SVProgressHUD.showSuccessWithStatusWithBlack("设置成功");
                    var vc:LoginVC = UIHelper.GetVCWithIDFromStoryBoard(.Account, viewControllerIdentity: "LoginVC") as! LoginVC
                    //  vc.isBackToHome = true;
                    self.view.window?.rootViewController = vc
                }else if jsonData["code"] == 2
                {
                    SVProgressHUD.showErrorWithStatusWithBlack("不存在该手机号");
                    
                }else if jsonData["code"] == 3
                {
                    SVProgressHUD.showErrorWithStatusWithBlack("修改失败");
                }
                
                
                
            }
            
            
            
            
            
        }
        SVProgressHUD.showSuccessWithStatusWithBlack("验证成功");
        var vc:RegisterStep3VC = UIHelper.GetVCWithIDFromStoryBoard(.Account, viewControllerIdentity: "RegisterStep3VC") as! RegisterStep3VC
        
        //        vc.strPhone = self.txtPhone.text.trim();
        //        vc.countryID = 0;
        //        vc.strVcode = self.txtVerifyCode.text
        //        vc.isFromFindPwd = self.isFromFindPwd
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
