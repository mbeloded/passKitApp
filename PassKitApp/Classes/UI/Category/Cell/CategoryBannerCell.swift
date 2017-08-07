//
//  CategoryBannerCell.swift
//  PassKitApp
//
//  Created by Michael Bielodied on 10/9/14.
//  Copyright (c) 2014 Michael Bielodied. All rights reserved.
//

import UIKit

class CategoryBannerCell: UITableViewCell {

    @IBOutlet weak var bannerView: PFImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
