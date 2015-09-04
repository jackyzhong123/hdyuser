//
//  ActivityDetail.swift
//  HDY
//
//  Created by Sky on 15/9/4.
//  Copyright (c) 2015年 edonesoft. All rights reserved.
//

import UIKit

class ActivityDetail: NSObject {
    
    var ActivityName:String!
    var ActivityPost:String!
    var ActivityId:String!
   
    
    init(dict:NSDictionary) {
        super.init()
        self.OrderDetail(dict)
    }

    func OrderDetail(dict:NSDictionary)
    {
        self.ActivityName = dict.objectForKey("ActivityName") as! String
        self.ActivityPost = dict.objectForKey("ActivityPost") as! String
        self.ActivityId = dict.objectForKey("ActivityId") as! String
      
    }
    
}