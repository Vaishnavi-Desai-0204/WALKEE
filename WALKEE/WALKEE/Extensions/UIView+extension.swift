//
//  UIView+extension.swift
//  WALKEE
//
//  Created by Vikas desai  on 09/04/22.
//  Copyright © 2022 Vaishnavi desai. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return cornerRadius }
        set{
            self.layer.cornerRadius = newValue
        }
    }
    
}
