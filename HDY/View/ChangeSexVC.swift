//
//  ChangeSexVC.swift
//  HDY
//
//  Created by haha on 15/9/6.
//  Copyright (c) 2015年 edonesoft. All rights reserved.
//

import UIKit

class ChangeSexVC: RootVC ,UITableViewDelegate,UITableViewDataSource {

 
    
    var cellChecked = "CellChecked"
    var cellUnChecked = "CellUnChecked"
    
    
    var MySex:Int?
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MySex = AppConfig.sharedAppConfig.MySex!
        
    
       
        // Do any additional setup after loading the view.
    }
    
    override func RenderDetail() {
          UIHelper.SetNaviBarRightItemWithName(self, action: "toggleRightMenu:", strName: "保存")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func toggleRightMenu(sender: AnyObject)
    {
        let parameter = ["Sex": MySex!]
        self.httpPostApi(AppConfig.Url_ChangeSex, body: parameter, tag: 11)
        
        
    }
    
    
    //MARK: 网络调用返回
    override func requestDataComplete(response:AnyObject,tag:Int)
    {
        if (tag == 11)
        {
            AppConfig.sharedAppConfig.MySex = response as! Int
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

    
    //MARK: 表格选项
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if (indexPath.row == 0 )
        {
            MySex = 0
        }else
        {
            MySex = 1
        }
        
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell!

        if (indexPath.row == 0 )
        {
            
            if (MySex! == 0)
            {
              cell =  tableView.dequeueReusableCellWithIdentifier(cellChecked) as! UITableViewCell;
                cell.selected = true
                
            }else
            {
                  cell =  tableView.dequeueReusableCellWithIdentifier(cellUnChecked) as! UITableViewCell;
                cell.selected = false

                
            }
        
            cell.textLabel?.text = "男"
        }else
        {
            
            if (MySex! == 1)
            {
                cell =  tableView.dequeueReusableCellWithIdentifier(cellChecked) as! UITableViewCell;
                   cell.selected = true
            }else
            {
                  cell =  tableView.dequeueReusableCellWithIdentifier(cellUnChecked) as! UITableViewCell;
                  cell.selected = false
            }
            cell.textLabel?.text = "女"
        }
        
        
        
        return cell;
    }

    
}
