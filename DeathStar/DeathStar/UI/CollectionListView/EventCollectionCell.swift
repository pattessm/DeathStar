//
//  EventCollectionCell.swift
//  PhunApp
//
//  Created by Sam Patteson on 7/30/18.
//  Copyright © 2018 Sam Patteson. All rights reserved.
//

import UIKit

class EventCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public class func reuseId() -> String {
        return "eventCell"
    }
    
    public func update(event: Event) {
        let imgStr = event.imageString ?? ""
        backgroundImageView.imageFromURL(urlString: imgStr, defaultImage: "noMoon")
        titleLabel.text = event.title
        locationLabel.text = event.loc2
        dateLabel.text = event.formattedDate()
        descriptionLabel.text = event.desc
    }
    
}
