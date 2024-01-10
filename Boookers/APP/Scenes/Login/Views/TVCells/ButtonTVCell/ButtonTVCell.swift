//
//  ButtonTVCell.swift
//  BabSafar
//
//  Created by MA673 on 21/07/22.
//

import UIKit

protocol ButtonTVCellDelegate {
    func btnAction(cell: ButtonTVCell)
    
}

class ButtonTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var btnImg: UIImageView!
    @IBOutlet weak var btnLeftConstraint: NSLayoutConstraint!
    
    var key = String()
    var delegate:ButtonTVCellDelegate?
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
        self.key = cellInfo?.key ?? ""
        switch self.key {
        case "addroom":
            btnLeftConstraint.constant = 300
            btnView.backgroundColor = .WhiteColor
            titlelbl.textColor = .AppNavBackColor
            break
        default:
            break
        }
    }
    
    func setupUI(){
        
        btnLeftConstraint.constant = 16
        holderView.backgroundColor = .WhiteColor
        btnView.backgroundColor = .AppNavBackColor
        btnView.layer.cornerRadius = 4
        btnView.clipsToBounds = true
        titlelbl.textColor = .WhiteColor
        titlelbl.font = UIFont.OpenSansMedium(size: 16)
        btnImg.image = UIImage(named: "download")?.withRenderingMode(.alwaysOriginal)
        btnImg.isHidden = true
        btn.setTitle("", for: .normal)
        btnView.isHidden = false
        
    }
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.clear.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    @IBAction func btnAction(_ sender: Any) {
        delegate?.btnAction(cell: self)
    }
    
  
}
