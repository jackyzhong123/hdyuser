//
//  FindPwdStep1.swift
//  HDY
//
//  Created by Sky on 15/9/7.
//  Copyright (c) 2015年 edonesoft. All rights reserved.
//

import UIKit

class FindPwdStep1: RootVC,UIAlertViewDelegate {

    
     @IBOutlet weak var txtInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func RenderDetail() {
        txtInput.frame = CGRectMake(txtInput.frame.origin.x, txtInput.frame.origin.y, txtInput.frame.width,44)
    }
    
    override func ButtonTap(tag: Int) {
        
        if (self.txtInput.text.length != 11) {
            return;
        }
        
        self.view.endEditing(true)
        var alert = UIAlertView()
        alert.title = "确认手机号码"
        alert.message = "我们将发送验证码短信到这个号码:\r\n" + self.txtInput.text
        alert.addButtonWithTitle("取消")
        alert.addButtonWithTitle("确定")
        alert.delegate = self;
        alert.show()

        
    }
    
    
    override func requestDataComplete(response:AnyObject,tag:Int)
    {
        if(tag == 11)
        {
            SVProgressHUD.showSuccessWithStatusWithBlack("验证码已发送成功");
            var vc:RegisterStep2VC = UIHelper.GetVCWithIDFromStoryBoard(.Account, viewControllerIdentity: "RegisterStep2VC") as! RegisterStep2VC
            vc.strPhone = txtInput.text.trim();
            vc.isFromFindPwd = true;
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    override func requestDataFailed(error:String)
    {
        SVProgressHUD.showErrorWithStatusWithBlack(error);
    }
    
    //MARK alertView Delegate
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if(buttonIndex == 0)//cancel
        {
            
        }
        else
        {
            SVProgressHUD.showWithStatusWithBlack("验证码短信发送中...")
            
            let parameters = ["mobile": self.txtInput.text ]
            
            
            
            self.httpGetApi(AppConfig.Url_SendSMS, body:parameters, tag: 11)
            
           
        }
    }
    
    


}
