//
//  ProfileVC.swift
//  HDY
//
//  Created by Sky on 15/9/4.
//  Copyright (c) 2015年 edonesoft. All rights reserved.
//

import UIKit



class ProfileVC: RootVC ,UITableViewDelegate,UITableViewDataSource ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
    //MARK: 页面变量
    let headCell = "MeHeaderCell"
    let generalCell = "Cell"
    let logoutCell = "logoutCell"
    let CellArray1 =   [
        ["name":"名字","icon":"","targetVC":"ChangeRealNameVC"],
        ["name":"活动邮号","icon":"","targetVC":"ChangeHDYNameVC"],
      //  ["name":"性别","icon":"","targetVC":"MyAlbumListVC"],
       // ["name":"更换手机","icon":"","targetVC":"MyLocationVC"],
        //["name":"更换密码","icon":"","targetVC":"MyPeopleVC"]
    ]
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: 页面生存周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    //MARK: 渲染详细
    override func RenderDetail()
    {
        self.title="我的资料";
        self.tableView.delegate = self
        self.tableView.dataSource = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("changeUserStatus:"), name: AppConfig.NF_ChangeUerProfile, object: nil)
    }
    
    func changeUserStatus(notification:NSNotification)
    {
        tableView.reloadData();
    }

    
    //MARK: 按钮点击事件
    override func ButtonTap(tag: Int) {
        
    }
    
    
    //MARK: 网络调用返回
    override func requestDataComplete(response:AnyObject,tag:Int)
    {
        SVProgressHUD.dismiss()
        if (tag == 99)
        {
            AppConfig.sharedAppConfig.Portrait = response as! String
            AppConfig.sharedAppConfig.save()
            tableView.reloadData()
             NSNotificationCenter.defaultCenter().postNotificationName(AppConfig.NF_ChangeUerProfile, object: nil, userInfo: nil)
            
        }
        if (response is NSDictionary)
        {
            var jsonData=JSON(response)
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    
    
    
    
    //MARK: 表格选项
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0
        {
            //上传头像
            imgHeadChange()
        }else if (indexPath.section == 1)
        {
            var index = indexPath.row;
            var photoItem:NSDictionary! = CellArray1[index] as NSDictionary
            var vc:UIViewController  = UIHelper.GetVCWithIDFromStoryBoard(.Account, viewControllerIdentity: photoItem["targetVC"] as! String)
            
            self.navigationController?.pushViewController(vc, animated: true)
            
            
            //其他选项
        }else if (indexPath.section == 2)
        {
            AppConfig.sharedAppConfig.userLogout()
            var vc = UIHelper.GetVCWithIDFromStoryBoard(.Account, viewControllerIdentity: "loginNavigation")
            
            self.view.window?.rootViewController = vc
        }
        
    }
    
    //MARK: 数据绑定
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.section == 0)
        {
            return 88
        }
        return 44
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (section == 0)
        {
            return 1
        }else if (section == 1)
        {
            return CellArray1.count
        }else if (section == 2)
        {
            return 1;
        }else
        {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (indexPath.section == 0 && indexPath.row == 0)
        {
            var cell:MeHeaderCell =  tableView.dequeueReusableCellWithIdentifier(headCell) as! MeHeaderCell
        
            cell.imgCover!.sd_setImageWithURL(NSURL(string:AppConfig.sharedAppConfig.Portrait)!, placeholderImage: UIImage(named: "placeholder.png"))
            cell.lbName.text = "头像"
            var layer:CALayer = cell.imgCover.layer
            layer.cornerRadius = 10
            layer.masksToBounds = true
            return cell;
        } else if (indexPath.section == 1)
        {
            
            
            var cell:UITableViewCell =  tableView.dequeueReusableCellWithIdentifier(generalCell) as! UITableViewCell
           
            var photoItem:NSDictionary! = CellArray1[indexPath.row] as NSDictionary
            cell.textLabel?.text =  photoItem.objectForKey("name") as? String
            switch(indexPath.row)
            {
            case 0:
                cell.detailTextLabel?.text = AppConfig.sharedAppConfig.RealName
                break;
            case 1:
                cell.detailTextLabel?.text = AppConfig.sharedAppConfig.HDYName

                break;
            default:
                break;
            }
            
   
           
            //  cell.imageView?.image = UIImage(named: iconArr[indexPath.row])
            return cell
            
        }else if (indexPath.section == 2)
        {
            var cell:UITableViewCell =  tableView.dequeueReusableCellWithIdentifier(logoutCell) as! UITableViewCell
            
            UIScreen.mainScreen().bounds.size.width
            
            var v = UIView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, cell.frame.height));
            var label = UILabel(frame: v.frame);
            label.text = "注销";
            label.textColor = UIColor.redColor();
            label.font = UIHelper.mainFont14;
            label.textAlignment = NSTextAlignment.Center;
            
            v.addSubview(label);
            cell.addSubview(v);
            
            
            return cell
        }else
        {
            return UITableViewCell()
        }
        
        
    }
    
    
    //MARK:修改用户头像
    func imgHeadChange()
    {
        var alertController = UIAlertController(title: "修改图像", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        var cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler:  {
            (action: UIAlertAction!) -> Void in
            
        })
        var deleteAction = UIAlertAction(title: "拍照上传", style: UIAlertActionStyle.Default, handler: {
            (action: UIAlertAction!) -> Void in
            
            var imagePicker = UIImagePickerController()
            if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera))
            {
                imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
                imagePicker.delegate = self;
                imagePicker.allowsEditing = true;
                self.presentViewController(imagePicker, animated: true, completion: nil);
            }
        })
        var archiveAction = UIAlertAction(title: "从相册中选择", style: UIAlertActionStyle.Default, handler: {
            (action: UIAlertAction!) -> Void in
            
            var imagePicker = UIImagePickerController()
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            imagePicker.delegate = self;
            imagePicker.allowsEditing = true;
            self.presentViewController(imagePicker, animated: true, completion: nil);
            
        })
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        alertController.addAction(archiveAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    
    
    //MARK: UIImagePickerController delegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        NSLog("count:%d", info);
        //编辑过后的图片
        let gotImage:UIImage! = info[UIImagePickerControllerEditedImage] as! UIImage
        picker.dismissViewControllerAnimated(true, completion: {
            () -> Void in
            if(gotImage != nil)
            {
                
                var imgData =  UIImageJPEGRepresentation(gotImage, 1.0)
                SVProgressHUD.showWithStatusWithBlack("请稍候，正在上传图片");
                self.uploadImage(imgData, tag: 99)
            }
        })
        
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
