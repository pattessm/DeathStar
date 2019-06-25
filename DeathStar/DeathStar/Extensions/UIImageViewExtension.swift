//
//  UIImageViewExtension.swift
//  PhunApp
//
//  Created by Sam Patteson on 7/26/18.
//  Copyright © 2018 Sam Patteson. All rights reserved.
//

import Foundation
import UIKit

// Lazy fetching the images so I don't have to
public extension UIImageView {
    func imageFromURL(urlString: String, defaultImage : String?) {
        if let defaultImage = defaultImage {
            self.image = UIImage(named: defaultImage)
        }
        
        // Don't try fetching anything that isn't there
        if urlString == "" { return }
        
        let task = URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            guard let data = data else { return }
            
            DispatchQueue.main.async(execute: { () -> Void in
                guard let image = UIImage(data: data) else { return }
                self.image = image
            })
        })
        task.resume()
    }
}
