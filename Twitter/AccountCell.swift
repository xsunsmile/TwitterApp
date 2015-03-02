//
//  AccountCell.swift
//  Twitter
//
//  Created by Hao Sun on 3/1/15.
//  Copyright (c) 2015 Hao Sun. All rights reserved.
//

import UIKit

class AccountCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    var user: User? {
        didSet {
            let imageUrl = user?.largeImageUrl()
            if imageUrl != nil {
                userImageView.setImageWithURL(imageUrl!)
            }
            userName.text = user?.name()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
