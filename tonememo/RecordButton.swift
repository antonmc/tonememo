//
//  RecordButton.swift
//  tonememo
//
//  Created by Anton McConville on 2017-06-14.
//  Copyright © 2017 Anton McConville. All rights reserved.
//

import UIKit

@IBDesignable
class RecordButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear{
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
}
