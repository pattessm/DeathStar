//
//  DetailHeaderView.swift
//  PhunApp
//
//  Created by Sam Patteson on 7/27/18.
//  Copyright © 2018 Sam Patteson. All rights reserved.
//

import UIKit

class DetailHeaderView: UIView {

    @IBOutlet weak var backgroundImage: UIImageView!

    public var image: UIImage? {
        didSet {
            backgroundImage.image = image
        }
    }
    
    public class func create() -> DetailHeaderView {
        let bundle = Bundle(for: DetailHeaderView.self)
        guard let view = UINib(nibName: "DetailHeaderView", bundle: bundle)
            .instantiate(withOwner: nil, options: nil)[0] as? DetailHeaderView else { preconditionFailure() }
        view.frame = CGRect(x: 0, y: TableConstants.imageOffset, width: UIScreen.main.bounds.size.width, height: TableConstants.imageHeight)
        return view
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
    }
}
