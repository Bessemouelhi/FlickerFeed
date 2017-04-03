//
//  ImageCollectionViewCell.swift
//  FlikrFeed
//
//  Created by Apple on 24/03/2017.
//  Copyright © 2017 me. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var url: String?
    
}
