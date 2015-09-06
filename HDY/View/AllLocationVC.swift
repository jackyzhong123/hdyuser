//
//  AllLocationVC.swift
//  HDY
//
//  Created by Sky on 15/9/5.
//  Copyright (c) 2015年 edonesoft. All rights reserved.
//

import UIKit






class AllLocationVC: RootVC ,UITableViewDelegate,UITableViewDataSource,MGSwipeTableCellDelegate {
    
    
    //MARK: 页面变量
    var listData:Array<LocationDetail> = []
    let cellIdentifier:String = "Cell"
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: 页面生存周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    //MARK: 渲染详细
    override func RenderDetail()
    {
        self.title="活动列表";
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.httpGetApi(AppConfig.Url_LocationList , body: nil, tag: 11)
    }
    
    //MARK: 按钮点击事件
    override func ButtonTap(tag: Int) {
        
    }
    
    
    //MARK: 网络调用返回
    override func requestDataComplete(response:AnyObject,tag:Int)
    {
        if (tag == 11)
        {
            if let dataArray = response as? NSArray{
                listData.removeAll(keepCapacity: false)
                
                for itemObj in dataArray
                {
                    if let itemDic = itemObj as? NSDictionary{
                        var data=LocationDetail(dict: itemDic)
                        listData.append(data)
                    }
                }
                self.tableView.reloadData()
            }
        }
        
    }
    
    
    //MARK: 表格选项
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:MGSwipeTableCell =  tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! MGSwipeTableCell
        var obj = listData[indexPath.row]
        
        cell.textLabel?.text = obj.LocationName
        cell.detailTextLabel?.text = obj.LocationAddress
        
          cell.imageView?.image =  UIImage(named: "setting_placeSearch")
        
        
        cell.tag = indexPath.row
        
        
        cell.rightButtons = [MGSwipeButton(title: "收藏", backgroundColor: UIColor.grayColor())]
        
        cell.rightSwipeSettings.transition = MGSwipeTransition.Rotate3D;
        cell.delegate = self;
        
        
        return cell;
    }
    
    func swipeTableCell(cell: MGSwipeTableCell!, tappedButtonAtIndex index: Int, direction: MGSwipeDirection, fromExpansion: Bool) -> Bool {
        // println("\(cell.textLabel?.text)")
        let parameter = [
            "LocationId" : listData[cell.tag].Id
            
        ]
        
        self.httpGetApi(AppConfig.Url_MakeFavLocation, body: parameter, tag: 12)
        return true
    }
    
    
}
