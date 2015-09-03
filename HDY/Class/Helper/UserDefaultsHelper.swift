//
//  UserDefaultsHelper.swift
//  HDYAdmin
//
//  Created by haha on 15/9/1.
//  Copyright (c) 2015年 HuoDongYou. All rights reserved.
//

import UIKit

class UserDefaultsHelper: NSObject {
    static func getStringForKey(key:String)->String
    {
        var val=""
        var standardUserDefaults=NSUserDefaults.standardUserDefaults()
        val=standardUserDefaults.stringForKey(key)!
        return val;
    }
    
    static func getIntForkey(key:String)->Int
    {
        var val=0
        var standardUserDefaults=NSUserDefaults.standardUserDefaults()
        val = standardUserDefaults.integerForKey(key)
        return val;
    }
    
    static func getDoubleForkey(key:String)->Double
    {
        var val:Double=0
        var standardUserDefaults=NSUserDefaults.standardUserDefaults()
        val = standardUserDefaults.doubleForKey(key)
        return val;
    }
    
    static func getDictForKey(key:String)->NSDictionary
    {
        var val:NSDictionary! = nil
        var standardUserDefaults=NSUserDefaults.standardUserDefaults()
        val = standardUserDefaults.dictionaryForKey(key)
        return val;
    }
    
    static func getBoolForKey(key:String)->Bool
    {
        var val=false
        var standardUserDefaults=NSUserDefaults.standardUserDefaults()
        val = standardUserDefaults.boolForKey(key)
        return val;
    }
    
    static func getArrayForKey(key:String)->NSArray
    {
        var val:NSArray =  NSArray()
        var standardUserDefaults=NSUserDefaults.standardUserDefaults()
        val = standardUserDefaults.arrayForKey(key)!
        return val;
    }
    
    
    static func setStringForKey(value:String,key:String)
    {
        var standardUserDefaults=NSUserDefaults.standardUserDefaults()
        standardUserDefaults.setObject(value, forKey: key)
        standardUserDefaults.synchronize()
    }
    
    static func setIntForKey(value:Int,key:String)
    {
        var standardUserDefaults=NSUserDefaults.standardUserDefaults()
        standardUserDefaults.setInteger(value, forKey: key)
        standardUserDefaults.synchronize()
    }
    
    static func setDictForKey(value:NSDictionary,key:String)
    {
        var standardUserDefaults=NSUserDefaults.standardUserDefaults()
        standardUserDefaults.setObject(value, forKey: key)
        standardUserDefaults.synchronize()
    }
    
    static func setArrayForKey(value:NSArray,key:String)
    {
        var standardUserDefaults=NSUserDefaults.standardUserDefaults()
        standardUserDefaults.setObject(value, forKey: key)
        standardUserDefaults.synchronize()
    }
    
    static func setBoolForKey(value:Bool,key:String)
    {
        var standardUserDefaults=NSUserDefaults.standardUserDefaults()
        standardUserDefaults.setBool(value, forKey: key)
        standardUserDefaults.synchronize()
    }
    
    static func setDoubleForKey(value:Double,key:String)
    {
        var standardUserDefaults=NSUserDefaults.standardUserDefaults()
        standardUserDefaults.setDouble(value, forKey: key)
        standardUserDefaults.synchronize()
    }

   
}
