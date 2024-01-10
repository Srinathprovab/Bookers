//
//  MulticityFromToTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 19/08/22.
//

import UIKit
protocol MulticityFromToTVCellDelegate {
    
    func didTapOnFromBtn(cell:MulticityFromToTVCell)
    func didTapOnToBtn(cell:MulticityFromToTVCell)
    func didTapOndateBtn(cell:MulticityFromToTVCell)
    func didTapOnCloseBtn(cell:MulticityFromToTVCell)
}

class MulticityFromToTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var fromView: UIView!
    @IBOutlet weak var fromlbl: UILabel!
    @IBOutlet weak var fromBtn: UIButton!
    @IBOutlet weak var toView: UIView!
    @IBOutlet weak var tolbl: UILabel!
    @IBOutlet weak var toBtn: UIButton!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var dateBtn: UIButton!
    @IBOutlet weak var closeView: UIView!
    @IBOutlet weak var closeImg: UIImageView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var fromimg: UIImageView!
    @IBOutlet weak var toimg: UIImageView!
    @IBOutlet weak var calimg: UIImageView!
    var dateString = String()
    var delegate:MulticityFromToTVCellDelegate?
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
       
        fromimg.image = UIImage(named: "from")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppJournyTabSelectColor)
        toimg.image = UIImage(named: "to")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppJournyTabSelectColor)
        calimg.image = UIImage(named: "cal")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppJournyTabSelectColor)
        
//        fromBtn.setTitle("", for: .normal)
//        toBtn.setTitle("", for: .normal)
//        dateBtn.setTitle("", for: .normal)
//        closeBtn.setTitle("", for: .normal)
        closeImg.image = UIImage(named: "close")
    }
    
    
    
    @IBAction func didTapOnFromBtn(_ sender: Any) {
        delegate?.didTapOnFromBtn(cell: self)
    }
    
    
    @IBAction func didTapOnToBtn(_ sender: Any) {
        delegate?.didTapOnToBtn(cell: self)
    }
    
    
    @IBAction func didTapOndateBtn(_ sender: Any) {
        delegate?.didTapOndateBtn(cell: self)
    }
    
    @IBAction func didTapOnCloseBtn(_ sender: Any) {
        delegate?.didTapOnCloseBtn(cell: self)
    }
    
    
}
