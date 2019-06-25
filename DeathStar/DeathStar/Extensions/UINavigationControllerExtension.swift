//
//  UINavigationControllerExtension.swift
//  PhunApp
//
//  Created by Sam Patteson on 7/26/18.
//  Copyright © 2018 Sam Patteson. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
    
    func updateNavbarAppearence(isClear: Bool) {
        
        if isClear {
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
            navigationBar.isTranslucent = true
            navigationBar.backgroundColor = .clear
            navigationBar.tintColor = .white
        }
        else {
            navigationBar.setBackgroundImage(nil, for: .default)
            navigationBar.shadowImage = nil
            navigationBar.isTranslucent = false
            navigationBar.backgroundColor = .lightGray
        }
    }
}
