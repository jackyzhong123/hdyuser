//
//  ContactVC.swift
//  HDY
//
//  Created by Sky on 15/9/5.
//  Copyright (c) 2015年 edonesoft. All rights reserved.
//

import UIKit

class ContactVC : RootVC ,UITableViewDelegate,UITableViewDataSource {
    
    
    //MARK: 页面变量
    var listLocationData:Array<LocationDetail> = []
    var listPersonData:Array<PersonDetail> = []
    let cellLocationIdentifier:String = "CellLocation"
    let cellOrgIdentifier:String = "CellOrg"
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var segModel: UISegmentedControl!
    
    
    @IBAction func SegmentChanged(sender: AnyObject) {
        
        self.tableView.reloadData()
    }
    
    //MARK: 页面生存周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    //MARK: 渲染详细
    override func RenderDetail()
    {
        // self.title="地点列表";
        self.tableView.delegate = self
        self.tableView.dataSource = self
        UIHelper.SetNaviBarRightItemWithIcon(self, action: "toggleRightMenu:", strName: "plus")
        
        self.httpGetApi(AppConfig.Url_MyFollwerAndLocation, body: nil, tag: 11)
        
    }
    
    
    func toggleRightMenu(sender: AnyObject)
    {
        self.navigationController?.pushViewController(UIHelper.GetVCWithIDFromStoryBoard(.Account, viewControllerIdentity: "RegisterVC"), animated: true)
    }
    
    
    
    
    //MARK: 按钮点击事件
    override func ButtonTap(tag: Int) {
        
        
    }
    
    
    //MARK: 网络调用返回
    override func requestDataComplete(response:AnyObject,tag:Int)
    {
        
        if (tag == 11)
        {
            if let dataArray = response.objectForKey("Org") as? NSArray{
                listPersonData.removeAll(keepCapacity: false)
                
                for itemObj in dataArray
                {
                    if let itemDic = itemObj as? NSDictionary{
                        var data=PersonDetail(dict: itemDic)
                        listPersonData.append(data)
                    }       
                }
                
            }
            
            if let dataArray = response.objectForKey("Location") as? NSArray{
                listLocationData.removeAll(keepCapacity: false)
                
                for itemObj in dataArray
                {
                    if let itemDic = itemObj as? NSDictionary{
                        var data=LocationDetail(dict: itemDic)
                        listLocationData.append(data)
                    }
                }
               
            }
             self.tableView.reloadData()
            
        }
        
        if (response is NSDictionary)
        {
            var jsonData=JSON(response)
            
        }
    }
    
    
    //MARK: 表格选项
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (segModel.selectedSegmentIndex == 0)
        {
            return listPersonData.count
        }else
        {
            return listLocationData.count
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
      
           var cell:UITableViewCell
        
        
        if (segModel.selectedSegmentIndex == 0)
        {
             cell  =  tableView.dequeueReusableCellWithIdentifier(cellOrgIdentifier) as! UITableViewCell

            var obj:PersonDetail = listPersonData[indexPath.row]
            cell.imageView!.sd_setImageWithURL(NSURL(string:obj.Portrait)!, placeholderImage: UIImage(named: "placeholder.png"))
            cell.textLabel?.text = obj.HDYName
            
            var layer:CALayer = cell.imageView!.layer
            layer.cornerRadius = 10
            layer.masksToBounds = true
        }else
        {
        cell =  tableView.dequeueReusableCellWithIdentifier(cellLocationIdentifier) as! UITableViewCell
            var obj:LocationDetail = listLocationData[indexPath.row] as LocationDetail
            cell.imageView?.image =  UIImage(named: "setting_placeSearch")
            cell.textLabel?.text = obj.LocationName
            cell.detailTextLabel?.text = obj.LocationAddress

            
        }
        
        
        
        
        return cell;
    }
    
    
}
