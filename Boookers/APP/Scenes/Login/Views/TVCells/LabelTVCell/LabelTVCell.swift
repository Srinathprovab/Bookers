//
//  LabelTVCell.swift
//  BabSafar
//
//  Created by MA673 on 20/07/22.
//

import UIKit


class LabelTVCell: TableViewCell {
    
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
        
        titlelbl.textColor = .AppLabelColor
        titlelbl.font = UIFont.LatoSemibold(size: 20)
        titlelbl.numberOfLines = 0
        
        subTitlelbl.textColor = .SubTitleColor
        subTitlelbl.font = UIFont.OpenSansRegular(size: 14)
        subTitlelbl.numberOfLines = 0
        subTitlelbl.textAlignment = .center
        subTitlelbl.isHidden = true
        
    }
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title
        subTitlelbl.text = cellInfo?.subTitle
        self.titleKey = cellInfo?.key1 ?? ""
        
        key = cellInfo?.key ?? ""
        switch cellInfo?.key {
        case "login":
            subTitlelbl.isHidden = false
            break
            
        case "resetpass":
            img.isHidden = true
            break
            
        case "bc":
            img.isHidden = true
            break
            
        case "booked":
            img.isHidden = true
            titlelbl.font = UIFont.OpenSansMedium(size: 12)
            break
            
            
        case "backlogin":
            img.isHidden = true
            titlelbl.font = UIFont.LatoRegular(size: 18)
            titlelbl.textColor = .SubTitleColor
            break
            
            
        case "deals":
            img.isHidden = true
            titlelbl.font = UIFont.OpenSansBold(size: 18)
            titlelbl.textColor = .AppLabelColor
            holderView.backgroundColor = .AppBGcolor
           // titlelbl.attributedText = setAttributedText(str1: cellInfo?.title ?? "", str2: "Hot  Deals")
            
            subTitlelbl.font = UIFont.oswaldRegular(size: 16)
            subTitlelbl.textColor = .AppHolderViewColor
            break
            
        default:
            break
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    func setAttributedText(str1:String,str2:String) -> NSAttributedString {
        
        let atter1 = [NSAttributedString.Key.foregroundColor:UIColor.AppLabelColor,NSAttributedString.Key.font:UIFont.oswaldRegular(size: 28)] as [NSAttributedString.Key : Any]
        let atter2 = [NSAttributedString.Key.foregroundColor:UIColor.AppNavBackColor,NSAttributedString.Key.font:UIFont.oswaldRegular(size: 28)] as [NSAttributedString.Key : Any]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
        
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        combination.append(atterStr2)
        
        
        return combination
    }
    
}
