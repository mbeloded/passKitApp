//
//  MainCollectionViewCell.swift
//  PassKitApp
//
//  Created by Michael Bielodied on 10/3/14.
//  Copyright (c) Michael Bielodied. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            print(nameLabel.text)
        }
    }
    @IBOutlet weak var imageView: PFImageView!
    
    var category:CategoryModel! {
        didSet {
            nameLabel.text = category.name
            var url:NSString  = category.icon! as NSString
            var pngPath:NSString   = NSHomeDirectory().stringByAppendingPathComponent("Documents/\(url.lastPathComponent)");
            imageView.image = UIImage(named: pngPath as String)
            imageView.backgroundColor = UIColor.black
            imageView.layer.cornerRadius = imageView.frame.size.width/2;

        
        }
    }
    override func draw(_ rect: CGRect) {
        imageView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width/1.5, height: self.frame.size.width/1.5)
        imageView.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2.8)
        imageView.layer.cornerRadius = imageView.frame.size.width/2;
    }
}
