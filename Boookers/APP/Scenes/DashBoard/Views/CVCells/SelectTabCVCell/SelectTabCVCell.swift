//
//  SelectTabCVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 16/08/22.
//

import UIKit

class SelectTabCVCell: UICollectionViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var imgHolderView: UIView!
    @IBOutlet weak var tabImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var bgImg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        holderView.backgroundColor = .clear
        imgHolderView.backgroundColor = .WhiteColor
        imgHolderView.layer.cornerRadius = 32.5
        imgHolderView.clipsToBounds = true
        
        titlelbl.textColor = .WhiteColor
        titlelbl.font = UIFont.LatoRegular(size: 16)
        
        
        bgImg.image = UIImage(named: "f1")?.withRenderingMode(.alwaysOriginal)
    }

}
