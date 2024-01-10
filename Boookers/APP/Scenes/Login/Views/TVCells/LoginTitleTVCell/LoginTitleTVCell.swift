//
//  LoginTitleTVCell.swift
//  KuwaitWays
//
//  Created by FCI on 04/08/23.
//

import UIKit

class LoginTitleTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var subTitlelbl: UILabel!
    
    var key = String()
    var titleKey = String()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        holderView.backgroundColor = .WhiteColor
        img.isHidden = false
    }
    

    override func updateUI() {
        titlelbl.text = cellInfo?.title
        subTitlelbl.text = cellInfo?.subTitle
        
       
        switch cellInfo?.key {

        case "resetpass":
            img.isHidden = true
            subTitlelbl.numberOfLines = 2
            break
            
            
        default:
            break
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    

}
