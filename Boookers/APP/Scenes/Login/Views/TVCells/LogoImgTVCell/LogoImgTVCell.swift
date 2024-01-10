//
//  LogoImgTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 16/08/22.
//

import UIKit

class LogoImgTVCell: TableViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var logoImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        logoImg.image = UIImage(named: "logoname")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
