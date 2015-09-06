//
//  RegisterVC.swift
//  HDYAdmin
//
//  Created by Sky on 15/9/1.
//  Copyright (c) 2015年 HuoDongYou. All rights reserved.
///

import UIKit

class RegisterVC: RootVC ,UIAlertViewDelegate {
    
    @IBOutlet weak var btnRegister: UIButton!

    @IBOutlet weak var txtPhone: TextBoxView!
    @IBOutlet weak var txtControyID:TextBoxView!
    @IBOutlet weak var btnSelectCID: UIButton!
    var strKeyNote = "CountryCode"
    
    var strControyInfo = "+86中国";


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "注册"
        UIHelper.buildButtonFilletStyle(btnRegister, borderColor: UIHelper.mainColor)
        
         txtControyID.enabled = false;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnActionTapped(sender: AnyObject) {
        
        var tag = (sender as! UIButton).tag
        if(tag == 10)
        {//选择国家
            // var vc = UIHelper.GetVCWithIDFromStoryBoard(.Account, viewControllerIdentity: "CountrySelectVC")
            // self.navigationController?.pushViewController(vc, animated: true);
        }
        else if(tag == 11)
        {//确定提交
            
            if (self.txtPhone.text.length != 11) {
                return;
            }
            
            self.view.endEditing(true)
            var alert = UIAlertView()
            alert.title = "确认手机号码"
            alert.message = "我们将发送验证码短信到这个号码:\r\n" + self.txtPhone.text
            alert.addButtonWithTitle("取消")
            alert.addButtonWithTitle("确定")
            alert.delegate = self;
            alert.show()
        }
        
    }
    
    
    //MARK alertView Delegate
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if(buttonIndex == 0)//cancel
        {
            
        }
        else
        {
            SVProgressHUD.showWithStatusWithBlack("验证码短信发送中...")
            // var strapiName = "system/vcode/send/sms?mp="+self.txtPhone.text
            
            
            
            //SVProgressHUD.showWithStatusWithBlack("请稍候...");
            let parameters = ["mobile": self.txtPhone.text ]
            
            
            
            self.httpGetApi(AppConfig.Url_SendSMS, body:parameters, tag: 11)
            
       }
        
      }
    
    override func requestDataComplete(response:AnyObject,tag:Int)
    {
        if(tag == 11)
        {
            SVProgressHUD.showSuccessWithStatusWithBlack("验证码已发送成功");
            
            
            var jsonData = JSON(response);
            if(jsonData==1)
            {
                SVProgressHUD.showSuccessWithStatusWithBlack("验证码已发送成功");
                var vc:RegisterStep2VC = UIHelper.GetVCWithIDFromStoryBoard(.Account, viewControllerIdentity: "RegisterStep2VC") as! RegisterStep2VC
               vc.strPhone = self.txtPhone.text.trim();
               vc.countryID = 0;
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }
        
    }

    
    
    
}
