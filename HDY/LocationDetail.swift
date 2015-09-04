//
//  LocationDetail.swift
//  HDYAdmin
//
//  Created by Sky on 15/9/1.
//  Copyright (c) 2015年 HuoDongYou. All rights reserved.
//

import UIKit

class LocationDetail: NSObject {
    
    var LocationName:String!
    var LocationAddress:String!
    var Description:String!
    var Latitude:Double!
    var Longitude:Double!
    var LocationLevel:Int!
    var Id:String!
    
    init(dict:NSDictionary) {
        super.init()
        self.OrderDetail(dict);
    }
    
    func OrderDetail(dict:NSDictionary)
    {
        self.Id = dict.objectForKey("Id") as! String
        self.LocationName=dict.objectForKey("LocationName") as! String
        self.LocationAddress=dict.objectForKey("LocationAddress") as! String
        self.Description=dict.objectForKey("Description") as? String
        self.Latitude=dict.objectForKey("Latitude") as! Double
        self.Longitude=dict.objectForKey("Longitude") as! Double
        self.LocationLevel=dict.objectForKey("LocationLevel") as? Int
    }
    
    
    
}
