//
//  AllOrganiztionVC.swift
//  HDY
//
//  Created by Sky on 15/9/4.
//  Copyright (c) 2015年 edonesoft. All rights reserved.
//


import UIKit




class AllOrganizationVC: RootVC ,UITableViewDelegate,UITableViewDataSource,MGSwipeTableCellDelegate {
    
    
    //MARK: 页面变量
    var listData:Array<PersonDetail> = []
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
        
        self.httpGetApi(AppConfig.Url_OrgList , body: nil, tag: 11)
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
                        var data=PersonDetail(dict: itemDic)
                        listData.append(data)
                    }
                }
                self.tableView.reloadData()
            }
        }else if(tag == 12)
        {
            self.httpGetApi(AppConfig.Url_OrgList , body: nil, tag: 11)
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
        
        cell.textLabel?.text = obj.HDYName
        
        cell.imageView!.sd_setImageWithURL(NSURL(string:obj.Portrait)!, placeholderImage: UIImage(named: "placeholder.png"))
        
        cell.tag = indexPath.row
        
        
        cell.rightButtons = [MGSwipeButton(title: "关注", backgroundColor: UIColor.grayColor())]
        
        cell.rightSwipeSettings.transition = MGSwipeTransition.Rotate3D;
        cell.delegate = self;
        
        return cell;
    }
    
    func swipeTableCell(cell: MGSwipeTableCell!, tappedButtonAtIndex index: Int, direction: MGSwipeDirection, fromExpansion: Bool) -> Bool {
        // println("\(cell.textLabel?.text)")
        let parameter = [
            "UserName" : listData[cell.tag].UserName
            
        ]
        
        self.httpGetApi(AppConfig.Url_MakeFollow, body: parameter, tag: 12)
        return true
    }
    
    
}
