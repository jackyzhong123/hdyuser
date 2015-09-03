//
//  TextBoxView.swift
//  landi-app
//
//  Created by Andy Chen on 6/24/15.
//  Copyright (c) 2015 edonesoft. All rights reserved.
//

import UIKit

class TextBoxView: UITextField {

    var insetX:CGFloat = 0.0
    var insetY:CGFloat = 0.0
    
    func setRoundedAndLineType()
    {
        self.layer.borderWidth = 1.0;
        self.layer.cornerRadius = 6.0;
    }
    
    

     override func drawRect(rect:CGRect) {
        super.drawRect(rect);
    }
    
//    - (CGRect)textRectForBounds:(CGRect)bounds {
//    return CGRectInset(bounds, self.insetX, self.insetY);
//    }
    
     override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, self.insetX, self.insetY);
    }
    
//    - (CGRect)editingRectForBounds:(CGRect)bounds {
//    return CGRectInset( bounds , self.insetX, self.insetY);
//    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset( bounds , self.insetX, self.insetY);

    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
