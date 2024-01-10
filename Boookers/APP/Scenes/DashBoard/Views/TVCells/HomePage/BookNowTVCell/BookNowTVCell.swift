//
//  BookNowTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 18/08/22.
//

import UIKit
protocol BookNowTVCellDelegate {
    func didTapOnBookNowBtn(cell:BookNowTVCell)
}

class BookNowTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var bookNowView: UIView!
    @IBOutlet weak var bookNowlbl: UILabel!
    @IBOutlet weak var bookNowBtn: UIButton!
    
    var delegate:BookNowTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title
        
        
    }
    
    func setupUI() {
        setupViews(v: holderView, radius: 0, color: .AppJournyTabSelectColor)
        setupViews(v: bookNowView, radius: 6, color: .AppNavBackColor)
        setupLabels(lbl: titlelbl, text: "KWD:150.00", textcolor: .WhiteColor, font: .oswaldRegular(size: 20))
        setupLabels(lbl: bookNowlbl, text: "BOOK NOW", textcolor: .WhiteColor, font: .oswaldRegular(size: 16))
        bookNowBtn.setTitle("", for: .normal)
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.2
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    @IBAction func didTapOnBookNowBtn(_ sender: Any) {
        delegate?.didTapOnBookNowBtn(cell: self)
    }
    
}
