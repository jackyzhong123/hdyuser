//
//  AlbumDetail.swift
//  HDYAdmin
//
//  Created by Sky on 15/9/1.
//  Copyright (c) 2015年 HuoDongYou. All rights reserved.
//

import UIKit

class AlbumDetail: NSObject {
    
    var AlbumIcon:String!
    var AlbumId:String!
    var AlbumName:String!
    
    init(dict:NSDictionary) {
        super.init()
        self.OrderDetail(dict);
    }
    
    func OrderDetail(dict:NSDictionary)
    {
        self.AlbumIcon=dict.objectForKey("AlbumIcon") as! String
        self.AlbumId=dict.objectForKey("AlbumId") as! String
        self.AlbumName=dict.objectForKey("AlbumName") as! String
    }
}
