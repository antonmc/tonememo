//
//  LoginButton.swift
//  tonememo
//
//  Created by Richard Martin on 2017-05-22.
//  Copyright © 2017 Anton McConville. All rights reserved.
//

import UIKit

class LoginButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.cornerRadius = 6.0
        layer.borderWidth = 0.25
        layer.borderColor = UIColor(red: 0, green: 0, blue: 80/255, alpha: 1).cgColor
    }

}
