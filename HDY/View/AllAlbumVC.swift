//
//  AllActivityVC.swift
//  HDY
//
//  Created by Sky on 15/9/4.
//  Copyright (c) 2015年 edonesoft. All rights reserved.
//

import UIKit




class AllAlbumVC: RootVC ,UITableViewDelegate,UITableViewDataSource {
    
    
    //MARK: 页面变量
    var listData:Array<AlbumDetail> = []
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
        
        self.httpGetApi(AppConfig.Url_AlbumList , body: nil, tag: 11)
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
                        var data=AlbumDetail(dict: itemDic)
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
        var cell:UITableViewCell =  tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! UITableViewCell
        var obj = listData[indexPath.row]
        
        cell.textLabel?.text = obj.AlbumName
        
        cell.imageView!.sd_setImageWithURL(NSURL(string:obj.AlbumIcon)!, placeholderImage: UIImage(named: "placeholder.png"))
        
        return cell;
    }
    
    
}
