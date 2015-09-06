//
//  RegisterStep2VC.swift
//  HDYAdmin
//
//  Created by Sky on 15/9/1.
//  Copyright (c) 2015年 HuoDongYou. All rights reserved.
//

import UIKit

class RegisterStep2VC: RootVC,UIAlertViewDelegate {
    
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtVerifyCode: UITextField!
    
    @IBOutlet weak var btnResend: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    var secondRemainResend = 1*60;
    var timer:NSTimer!
    var isFromFindPwd = false
    
    
    var isFromChangMobile = false
    var strPhone:String!;
    var countryID:Int!;
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
 
    
    override func RenderDetail() {
        btnResend.layer.cornerRadius = 6;
        btnResend.layer.masksToBounds=true
        btnResend.layer.borderWidth = 1;
        btnResend.layer.borderColor = UIHelper.mainColor.CGColor;
        btnNext.layer.cornerRadius = 6;
        btnNext.layer.masksToBounds=true
        btnNext.layer.borderWidth = 1;
        btnNext.layer.borderColor = UIHelper.mainColor.CGColor;
        txtPhone.text = strPhone;
        txtPhone.enabled = false;
        self.startTimer()
    }
    
    func startTimer()
    {
        secondRemainResend=60//1分钟内禁止重新发送
        btnResend.enabled = false;
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target:self, selector:Selector("changeResendTime"), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    
    func removeTimer()
    {
        btnResend.enabled = true
        timer.invalidate();
        timer = nil;
        btnResend.setTitle("重新获取验证码", forState: UIControlState.Normal)
    }
    
    
    func changeResendTime()
    {
        if(secondRemainResend <= 0 )
        {
            if(!btnResend.enabled)
            {
                self.removeTimer()
            }
        }
        else
        {
            secondRemainResend--;
            var msg = String(secondRemainResend) + "秒后重新获取"
            btnResend.setTitle(msg, forState: UIControlState.Normal)
        }
        
    }
    
    
 
    
    
    @IBAction func btnTapped(sender: AnyObject) {
        var tag = (sender as! UIButton).tag
        if(tag == 10)//重新发送验证码
        {
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
            startTimer()
            
        }
        else if(tag == 11)//提交验证码
        {
            if(txtVerifyCode.text.trim().length>0)
            {
                SVProgressHUD.showWithStatusWithBlack("请稍等...")
                var parameters:[String : AnyObject]
                
                if(!isFromChangMobile)
                {
                    parameters = [
                        "mp": self.txtPhone.text,
                        "vcode":self.txtVerifyCode.text.trim(),
                        "type":AppConfig.IsUserVersion ? "PersonRegister":"OrgRegister"
                    ]
                    
                    self.httpPostApi(AppConfig.Url_SMSVerify, body: parameters, tag: 11)
                    return
                }else{
                     parameters = [
                        "mp": self.txtPhone.text,
                        "vcode":self.txtVerifyCode.text.trim()
                    ]
                }
                self.httpPostApi(AppConfig.Url_SMSVerify, body: parameters, tag: 11)
            }
        }
    }
    
    override func requestDataComplete(response:AnyObject,tag:Int)
    {
        SVProgressHUD.dismiss()
        if (tag == 11) {
         
            
            SVProgressHUD.showSuccessWithStatusWithBlack("验证成功");
            if(!isFromChangMobile)
            {
                if (!isFromFindPwd)
                {
                    var flag = response as! Bool
                    if (!flag)
                    {
                        SVProgressHUD.showErrorWithStatusWithBlack("该手机号码已经注册");
                        return;
                    }
                    
                }
             
                var vc:RegisterStep3VC = UIHelper.GetVCWithIDFromStoryBoard(.Account, viewControllerIdentity: "RegisterStep3VC") as! RegisterStep3VC
                vc.strPhone = self.txtPhone.text.trim();
                vc.countryID = 0;
                vc.strVcode = self.txtVerifyCode.text
                vc.isFromFindPwd = self.isFromFindPwd
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else
            {
                
                
                let  body = [
                    "NewPhoneNumber":txtPhone.text.trim(),
                    "Vcode":txtVerifyCode.text.trim()
                ]
                
                
                
                self.httpPostApi("api/HuoDongService/mobilechange", body: body, tag: 98)
            }
            
            
 
            
            
        }else if (tag == 12)
        {
            
        }
        else if(tag == 98)
        {
            SVProgressHUD.showSuccessWithStatusWithBlack("手机号码修改成功");
            // var vc = UIHelper.GetVCWithIDFromStoryBoard(.Account, viewControllerIdentity: "ProfileVC") as! ProfileVC
            // self.navigationController?.popToViewController(vc, animated: true);
        }
        else if(tag == 99)
        {
            SVProgressHUD.showSuccessWithStatusWithBlack("验证码已发送成功");
            self.startTimer();
        }
        
        
        
        
        
        
        
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
