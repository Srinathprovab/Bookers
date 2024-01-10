//
//  DualViewTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 17/08/22.
//

import UIKit
protocol DualViewTVCellDelegate {
    func didTapOnSelectDepDateBtn(cell:DualViewTVCell)
    func didTapOnSelectRepDateBtn(cell:DualViewTVCell)
}

class DualViewTVCell: UITableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var depView: UIView!
    @IBOutlet weak var deplbl: UILabel!
    @IBOutlet weak var cal1Img: UIImageView!
    @IBOutlet weak var depBtn: UIButton!
    
    @IBOutlet weak var returnView: UIView!
    @IBOutlet weak var cal2img: UIImageView!
    @IBOutlet weak var returnlbl: UILabel!
    @IBOutlet weak var returnBtn: UIButton!
    @IBOutlet weak var depTF: UITextField!
    @IBOutlet weak var retTF: UITextField!
    
    var delegate:DualViewTVCellDelegate?
    var key = String()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupUI() {
        holderView.backgroundColor = .AppHolderViewColor
        setupViews(v: depView, radius: 4, color: HexColor("#E6E8E7",alpha: 0.20))
        setupViews(v: returnView, radius: 4, color: HexColor("#E6E8E7",alpha: 0.20))
        // returnView.backgroundColor = .AppBGColor
        returnlbl.isHidden = true
        cal2img.isHidden = true
        returnBtn.isHidden = true
        setupLabels(lbl: deplbl, text: "Select Data", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 14))
        setupLabels(lbl: returnlbl, text: "Select Data", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 14))
        self.cal1Img.image = UIImage(named: "cal")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppJournyTabSelectColor)
        self.cal2img.image = UIImage(named: "cal")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppJournyTabSelectColor)
        
        depBtn.setTitle("", for: .normal)
        depBtn.addTarget(self, action: #selector(didTapOnSelectDepDateBtn(_:)), for: .touchUpInside)
        returnBtn.setTitle("", for: .normal)
        returnBtn.addTarget(self, action: #selector(didTapOnSelectRepDateBtn(_:)), for: .touchUpInside)
        
        deplbl.numberOfLines = 0
    }
    
    
    func showReturnView() {
        returnlbl.isHidden = false
        cal2img.isHidden = false
        returnBtn.isHidden = false
        returnView.backgroundColor = .AppBGcolor
    }
    
    
    func hideRetView() {
        returnView.backgroundColor = .AppHolderViewColor
        returnlbl.isHidden = true
        cal2img.isHidden = true
        returnBtn.isHidden = true
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
    
    
    @objc func didTapOnSelectDepDateBtn(_ sender:UIButton){
        if key == "date" {
            delegate?.didTapOnSelectDepDateBtn(cell: self)
        }
        
    }
    @objc func didTapOnSelectRepDateBtn(_ sender:UIButton){
        if key == "date" {
            delegate?.didTapOnSelectRepDateBtn(cell: self)
        }
        
    }
}
