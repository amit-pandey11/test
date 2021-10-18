//
//  ColorCell.swift
//  13Oct202
//
//  Created by Amit Pandey on 19/10/21.
//

import UIKit

class ColorCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor.white.cgColor
    }

}
