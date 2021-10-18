//
//  ProductTableViewCell.swift
//  13Oct202
//
//  Created by Amit Pandey on 18/10/21.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var reguularPriceLabel: UILabel!
    @IBOutlet weak var salePriceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var colorsCollection: UICollectionView!
    
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func drawCell(cellData:ProductClass) {
        titleLabel.text = cellData.productName
        descriptionLabel.text = cellData.productDescription
        reguularPriceLabel.text = "\(cellData.productRegularPrice)"
        salePriceLabel.text = "\(cellData.productSalePrice)"
        
        if let imgD = cellData.productImage {
            productImage.image = UIImage(data: imgD)
        }
        if let address = cellData.storeAddress {
            addressLabel.text = "\(address["line_1"]!) \(address["city"]!)"
        }
        
    }
    
}
