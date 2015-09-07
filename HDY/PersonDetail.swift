//
//  PersonDetail.swift
//  HDY
//
//  Created by Sky on 15/9/4.
//  Copyright (c) 2015年 edonesoft. All rights reserved.
//


import UIKit

class PersonDetail: NSObject {
    
    var HDYName:String!
    var Portrait:String!
    var UserName:String!
    var RealName:String!
    
    
    init(dict:NSDictionary) {
        super.init()
        self.OrderDetail(dict)
    }
    
    func OrderDetail(dict:NSDictionary)
    {
        self.HDYName = dict.objectForKey("HDYName") as! String
        self.Portrait = dict.objectForKey("Portrait") as! String
        self.UserName = dict.objectForKey("UserName") as! String
        self.RealName = dict.objectForKey("RealName") as! String
        
    }
    
}