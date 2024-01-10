//
//  HotelDealsCVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 16/08/22.
//

import UIKit

class HotelDealsCVCell: UICollectionViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var imgHolderView: UIView!
    @IBOutlet weak var dealsImg: UIImageView!
    @IBOutlet weak var citylbl: UILabel!
    @IBOutlet weak var countrylbl: UILabel!
    @IBOutlet weak var kwdlbl: UILabel!
    @IBOutlet weak var kwdView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    
    func setupUI() {
        contentView.backgroundColor = .AppBGcolor
        holderView.backgroundColor = .AppBGcolor
        holderView.layer.cornerRadius = 5
        holderView.clipsToBounds = true
        holderView.layer.borderWidth = 0.4
        holderView.layer.borderColor = UIColor.lightGray.cgColor
        
        dealsImg.image = UIImage(named: "flight1")
        setupLabels(lbl: citylbl, text: "", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 12))
        setupLabels(lbl: countrylbl, text: "", textcolor: .SubTitleColor, font: .OpenSansRegular(size: 10))
        setupLabels(lbl: kwdlbl, text: "", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 10))
        kwdView.addCornerRadiusWithShadow(color: .lightGray, borderColor: .AppBorderColor, cornerRadius: 10)
        kwdView.backgroundColor = .WhiteColor
    }
    
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
}
