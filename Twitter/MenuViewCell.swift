//
//  MenuViewCell.swift
//  Twitter
//
//  Created by Hao Sun on 2/28/15.
//  Copyright (c) 2015 Hao Sun. All rights reserved.
//

import UIKit

class MenuViewCell: UITableViewCell {
    
    @IBOutlet weak var menuIcon: UIImageView!
    @IBOutlet weak var menuTitle: UILabel!
    
    var details: NSDictionary? {
        didSet {
            menuTitle.text = details!["title"] as NSString
            menuIcon.image = UIImage(named: details!["icon"] as NSString)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
