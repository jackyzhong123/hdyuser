//
//  FindVC.swift
//  HDY
//
//  Created by Sky on 15/9/4.
//  Copyright (c) 2015年 edonesoft. All rights reserved.
//

import UIKit


//
//  TableSampleController.swift
//  HDYAdmin
//
//  Created by Sky on 15/9/2.
//  Copyright (c) 2015年 HuoDongYou. All rights reserved.
//



class FindVC: RootVC ,UITableViewDelegate,UITableViewDataSource {
    
    
    //MARK: 页面变量
    
    let cellIdentifier:String = "Cell"
    @IBOutlet weak var tableView: UITableView!
    let CellArray1 =   [
        ["name":"活动","icon":"","targetVC":"AllActivityVC"],
        ["name":"组织号","icon":"","targetVC":"AllOrganizationVC"],
        ["name":"个人号","icon":"","targetVC":"AllPersonVC"],

        ["name":"专辑","icon":"","targetVC":"AllAlbumVC"],

        //  ["name":"性别","icon":"","targetVC":"MyAlbumListVC"],
        // ["name":"更换手机","icon":"","targetVC":"MyLocationVC"],
        //["name":"更换密码","icon":"","targetVC":"MyPeopleVC"]
    ]
    
    
    //MARK: 页面生存周期
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="发现";
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    
    //MARK: 渲染详细
    override func RenderDetail()
    {
        
    }
    
    //MARK: 按钮点击事件
    override func ButtonTap(tag: Int) {
        
    }
    
    
    //MARK: 网络调用返回
    override func requestDataComplete(response:AnyObject,tag:Int)
    {
        if (response is NSDictionary)
        {
            
            var jsonData=JSON(response)
            
        }
    }
    
    
    //MARK: 表格选项
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      
            var obj = self.CellArray1[indexPath.row] as NSDictionary
            
            var vc = UIHelper.GetVCWithIDFromStoryBoard(.Find, viewControllerIdentity: obj.objectForKey("targetVC") as! String)
            
            self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return CellArray1.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell =  tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! UITableViewCell
        
        var obj = CellArray1[indexPath.row] as NSDictionary
        cell.textLabel?.text = obj.objectForKey("name") as? String
        return cell;
    }
    
    
}
