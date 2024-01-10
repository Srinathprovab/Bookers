//
//  ItineraryCVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 18/08/22.
//

import UIKit

class ItineraryCVCell: UICollectionViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        holderView.backgroundColor = .WhiteColor.withAlphaComponent(0.50)
        holderView.layer.cornerRadius = 20
        holderView.clipsToBounds = true
        
        titlelbl.textColor = .WhiteColor
        titlelbl.font = UIFont.OpenSansRegular(size: 16)
    }

}
