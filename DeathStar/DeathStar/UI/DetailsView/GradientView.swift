//
//  GradientView.swift
//  PhunApp
//
//  Created by Sam Patteson on 7/26/18.
//  Copyright © 2018 Sam Patteson. All rights reserved.
//

import UIKit

class GradientView: UIView {
    override open class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gradientLayer = self.layer as! CAGradientLayer
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.white.cgColor
        ]
        gradientLayer.locations = [0.2, 1.0]
        backgroundColor = UIColor.clear
    }
}
