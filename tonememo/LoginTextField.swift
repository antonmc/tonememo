//
//  LoginTextField.swift
//  tonememo
//
//  Created by Richard Martin on 2017-05-22.
//  Copyright © 2017 Anton McConville. All rights reserved.
//

import UIKit

class LoginTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.3).cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 6.0
        
    }

    // adjust inset for background text
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 0)
    }
    
    // adjust inset for text when user edits inside box
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 0)
    }
}
