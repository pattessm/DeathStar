//
//  DescriptionCell.swift
//  PhunApp
//
//  Created by Sam Patteson on 7/26/18.
//  Copyright © 2018 Sam Patteson. All rights reserved.
//

import UIKit

class DescriptionCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var locationOneLabel: UILabel!
    @IBOutlet weak var locationTwoLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public class func reuseId() -> String {
        return "descriptionCell"
    }
    
    public func update(with event: Event) {
        dateLabel.text = event.formattedDate()
        titleTextView.text = event.title
        descriptionLabel.text = event.desc
        locationOneLabel.text = event.loc1
        locationTwoLabel.text = event.loc2
        phoneLabel.text = event.phone
    }
}


