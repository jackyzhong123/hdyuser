import Foundation


extension String{
//    //分割字符
//    func split(s:String)->String[]{
//        if s.isEmpty{
//            var x=String[]()
//            for y in self{
//                x.append(String(y))
//            }
//            return x
//        }
//        return self.componentsSeparatedByString(s)
//    }
    func isNullOrEmpty()->Bool
    {
        if(self.isEmpty)
        {
            return true;
        }
        else
        {
            if(self.length>0)
            {
                 return false;
            }
            else
            {
                return true;
            }
        }
    
    }
    //去掉左右空格
    func trim()->String{
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    //是否包含字符串
//    func has(s:String)->Bool{
//        if self.rangeOfString(s) {
//            return true
//        }else{
//            return false
//        }
//    }
    //是否包含前缀
    func hasBegin(s:String)->Bool{
        if self.hasPrefix(s) {
            return true
        }else{
            return false
        }
    }
    //是否包含后缀
    func hasEnd(s:String)->Bool{
        if self.hasSuffix(s) {
            return true
        }else{
            return false
        }
    }
    //统计长度
//    func length()->Int{
//        return countElements(self)
//    }
    var length: Int {
        return count(self)
    }
    //统计长度(别名)
    func size()->Int{
        return count(self)
    }
//    //截取字符串
//    func substr(range:Int...)->String{
//        if range[0]==0{
//            return self.substringToIndex(range[1])
//        }else{
//            return self.substringFromIndex(range[0])
//        }
//    }
//    //重复字符串
//    func repeat(times: Int) -> String{
//        var result = ""
//        for i in 0..times {
//            result += self
//        }
//        return result
//    }
//    //反转
//    func reverse()-> String{
//        var s=self.split("").reverse()
//        var x=""
//        for y in s{
//            x+=y
//        }
//        return x
//    }
    
    /// Percent escape value to be added to a URL query value as specified in RFC 3986
    ///
    /// This percent-escapes all characters besize the alphanumeric character set and "-", ".", "_", and "~".
    ///
    /// http://www.ietf.org/rfc/rfc3986.txt
    ///
    /// :returns: Return precent escaped string.
    
    func stringByAddingPercentEncodingForURLQueryValue() -> String? {
        let characterSet = NSMutableCharacterSet.alphanumericCharacterSet()
        characterSet.addCharactersInString("-._~")
        
        return self.stringByAddingPercentEncodingWithAllowedCharacters(characterSet)
    }
}