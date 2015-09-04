//
//  RootVC.swift
//  HDYAdmin
//
//  Created by haha on 15/9/1.
//  Copyright (c) 2015年 HuoDongYou. All rights reserved.
//
/*
特别说明：
在访问 tag = 700 的时候为同步用户头像



*/




import UIKit

class RootVC: UIViewController {
    
    var _doneButton:UIButton!;
    var IsNeedDoneButton:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.translucent = false  //不计Controller 高度
        self.navigationController?.navigationBar.hidden = false   //显示navigationbar

        RenderDetail()
        if (IsNeedDoneButton)
        {
            //设置需要完成按钮
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "doneButtonShow:", name: UIKeyboardDidShowNotification, object: nil)
        }
        
    }
    
    //给键盘增加完成输入的按钮
    func doneButtonShow (notification:NSNotification)
    {
        _doneButton = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as! UIButton
        
        _doneButton.frame = CGRectMake(0, 228, 70, 35);
        _doneButton.setTitle("完成编辑", forState: UIControlState.Normal)
        _doneButton.addTarget(self, action: "hideKeyboard", forControlEvents: UIControlEvents.TouchUpInside);
        self.view.addSubview(_doneButton)
        
    }
    
    func hideKeyboard(){
         //_doneButton.hidden = true
        _doneButton.removeFromSuperview()
       
        self.view.endEditing(true)
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning() 
    }
    
    //绑定页面点击事件
    @IBAction func btnPageTapped(sender: AnyObject) {
        var tag = (sender as! UIButton).tag
        ButtonTap(tag)
    }
    
    func ButtonTap(tag:Int)
    {
        
    }
    
    //用于初始化页面
    func RenderDetail()
    {
        
    }
    
    
    //MARK: Table数据绑定  默认绑定一行数据
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    

    
    //用于同步头像
    func syncUserInfo()
    {
        self.httpGetApi(AppConfig.Url_getProfile,body:nil, tag: 700)
    }
    
    
    

    // MARK: - 网络访问
    func generateRequest(relative:String)->NSMutableURLRequest
    {
        var oriUrl = AppConfig.SERVICE_ROOT_PATH + relative
       // var strUrl = oriUrl.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        var url:NSURL = NSURL(string: oriUrl)!
        var token = AppConfig.sharedAppConfig.getAuthorizationString()
        
        var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        //添加请求header
        
        request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        request.addValue(token, forHTTPHeaderField: "Authorization")
        
        NSLog("Request URL: %@", url);
        NSLog("Request Authorization: %@", token);
        return request;
    }
    
    
    func httpPostApi(apiname:String,body:AnyObject?,tag:Int)
    {
        
        var request:NSMutableURLRequest = self.generateRequest(apiname);
        request.HTTPMethod = "POST";
        
        if (body != nil)
        {
            request.HTTPBody = NSJSONSerialization.dataWithJSONObject(body!, options: NSJSONWritingOptions.PrettyPrinted, error: nil)
        }
        
        
        
        
        //跳过证书认证
        var securityPolicy : AFSecurityPolicy = AFSecurityPolicy(pinningMode: AFSSLPinningMode.None)
        securityPolicy.allowInvalidCertificates = true;
        //创建请求操作
        var operation:AFHTTPRequestOperation = AFHTTPRequestOperation(request: request);
        //设置安全级别
        operation.securityPolicy = securityPolicy;
        
        operation.setCompletionBlockWithSuccess({
            (operation:AFHTTPRequestOperation! , responseObject:AnyObject!) in
            
            self.handleHttpResponse(responseObject!, tag: tag)
            
            },
            failure: {
                (operation:AFHTTPRequestOperation! , error:NSError!) in
                
                var statusCode = operation.response?.statusCode
                if statusCode==401
                {
                    AppConfig.sharedAppConfig.userLogout()
                }else
                {
                    self.requestDataFailed("服务器有错误")
                }

                
        })
        operation.start()
    }
    
    func httpGetApi(var apiname:String,body:[String : AnyObject]?,tag:Int)
    {
        
        if (body != nil)
        {
            let parameterString = body!.stringFromHttpParameters()
            if (apiname.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: "?")).count > 1)
            {
                 apiname = apiname + "&" + parameterString
            }else
            {
                apiname = apiname + "?" + parameterString
            }
        }
        var request:NSMutableURLRequest = self.generateRequest(apiname);
        
        
        request.HTTPMethod = "GET";
        
        //跳过证书认证
        var securityPolicy : AFSecurityPolicy = AFSecurityPolicy(pinningMode: AFSSLPinningMode.None)
        securityPolicy.allowInvalidCertificates = true;
        //创建请求操作
        var operation:AFHTTPRequestOperation = AFHTTPRequestOperation(request: request);
        //设置安全级别
        operation.securityPolicy = securityPolicy;
        
        operation.setCompletionBlockWithSuccess({
            (operation:AFHTTPRequestOperation! , responseObject:AnyObject!) in
            
            if (tag == 700)
            {
                
                
                AppConfig.sharedAppConfig.syncUserInfo(responseObject)
                return
            }
            
            self.handleHttpResponse(responseObject, tag: tag)
            
            },
            failure: {
                (operation:AFHTTPRequestOperation! , error:NSError!) in
                
                var statusCode = operation.response?.statusCode
                if statusCode==401
                {
                    AppConfig.sharedAppConfig.userLogout()
                }else
                {
                     self.requestDataFailed("服务器有错误")
                }
               
                
                
           //
                
        })
        operation.start()
    }

    func uploadImage(imageData:NSData,tag:Int)
    {
        
        var request:NSMutableURLRequest = self.generateRequest(AppConfig.Url_uploadImage);
        request.HTTPMethod = "POST";
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData;//NSURLRequestReloadIgnoringLocalCacheData
        request.HTTPBodyStream = NSInputStream(data: imageData);
        request.timeoutInterval = 100
        //        request.HTTPBody = imageData;
        
        //        	fileEntity.setContentType("application/octet-stream");
        
        request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
        //跳过证书认证
        var securityPolicy : AFSecurityPolicy = AFSecurityPolicy(pinningMode: AFSSLPinningMode.None)
        securityPolicy.allowInvalidCertificates = true;
        //创建请求操作
        var operation:AFHTTPRequestOperation = AFHTTPRequestOperation(request: request);
        //设置安全级别
        operation.securityPolicy = securityPolicy;
        
        operation.setCompletionBlockWithSuccess({
            (operation:AFHTTPRequestOperation! , responseObject:AnyObject!) in
            
            self.handleHttpResponse(responseObject, tag: tag)
            
            },
            failure: {
                (operation:AFHTTPRequestOperation! , error:NSError!) in
                
                var statusCode = operation.response?.statusCode
                if statusCode==401
                {
                    AppConfig.sharedAppConfig.userLogout()
                }else
                {
                    self.requestDataFailed("服务器有错误")
                }

                
        })
        operation.start()
    }

    func handleHttpResponse(body:AnyObject,tag:Int)
    {
    
        
        var varData = body as! NSData;
        let dataDir:NSDictionary =  NSJSONSerialization.JSONObjectWithData(varData, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSDictionary
        
        if(dataDir.count == 0 || dataDir.objectForKey("Code") == nil)
        {
            self.requestDataFailed("网络异常,无效的响应.")
            return ;
        }
        var strCode = dataDir.objectForKey("Code") as! Int
        if(strCode == 10000)//code为1000正常的响应
        {
            var strDetail:AnyObject = dataDir.objectForKey("Detail")!
            self.requestDataComplete(strDetail, tag: tag)
        }
        else if(strCode == 20000)//Code为20000,token令牌失效
        {
            if(AppConfig.sharedAppConfig.isUserLogin())
            {
                AppConfig.sharedAppConfig.userLogout()
            }
            return
        }
        else
        {
            var strErr = dataDir.objectForKey("Message") as! String
            self.requestDataFailed(strErr)
        }
        
    }

    //网络访问成功
    func requestDataComplete(response:AnyObject,tag:Int)
    {
        
    }
    
    //网络访问失败
    func requestDataFailed(error:String)
    {
        SVProgressHUD.showErrorWithStatusWithBlack(error)
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
