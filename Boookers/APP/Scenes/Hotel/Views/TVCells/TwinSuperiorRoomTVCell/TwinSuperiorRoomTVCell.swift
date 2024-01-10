//
//  TwinSuperiorRoomTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 22/08/22.
//

import UIKit

protocol TwinSuperiorRoomTVCellDelegate {
    func didTapOnCancellationPolicyBtn(cell:TwinSuperiorRoomTVCell)
}

class TwinSuperiorRoomTVCell: UITableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var roomImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var cancellationPoloicyBtn: UIButton!
    @IBOutlet weak var adultsImg: UIImageView!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var noOfRoomslbl: UILabel!
    @IBOutlet weak var nonRefundablelbl: UILabel!
    @IBOutlet weak var kwdlbl: UILabel!
    @IBOutlet weak var kwdPricelbl: UILabel!
    @IBOutlet weak var radioImg: UIImageView!
    @IBOutlet weak var ulView: UIView!
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var cancellationlbl: UILabel!
    @IBOutlet weak var cancelationBtn: UIButton!
    
    var CancellationPolicyAmount = String()
    var CancellationPolicyFromDate = String()
    var ratekey = String()
    var refundValue = String()
    var delegate:TwinSuperiorRoomTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        if isSelected == true {
            self.radioImg.image = UIImage(named: "radioSelected")
            
        }else {
            self.radioImg.image = UIImage(named: "radioUnselected")
        }
    }
    
    override func prepareForReuse() {
        self.radioImg.image = UIImage(named: "radioUnselected")
    }
    
    
    func setupUI() {
        
        contentView.backgroundColor = .WhiteColor
        holderView.backgroundColor = .WhiteColor
        roomImg.image = UIImage(named: "hotel1")
        radioImg.image = UIImage(named: "radioUnselected")
        adultsImg.image = UIImage(named: "adult")
        
        setupLabels(lbl: titlelbl, text: "1 x Double Or Twin Superior", textcolor: .AppLabelColor, font: .OpenSansBold(size: 14))
        setupLabels(lbl: subtitlelbl, text: "2 Adults", textcolor: .SubTitleColor, font: .OpenSansRegular(size: 10))
        setupLabels(lbl: noOfRoomslbl, text: "No Of Rooms:1", textcolor: .SubTitleColor, font: .OpenSansRegular(size: 10))
        setupLabels(lbl: nonRefundablelbl, text: "Non-Refundable", textcolor: .red, font: .OpenSansRegular(size: 10))
        setupLabels(lbl: kwdlbl, text: "KWD", textcolor: .AppNavBackColor, font: .poppinsSemiBold(size: 10))
        setupLabels(lbl: kwdPricelbl, text: "180.00", textcolor: .AppNavBackColor, font: .poppinsSemiBold(size: 12))
        
        ulView.backgroundColor = .lightGray.withAlphaComponent(0.4)
        
        setupLabels(lbl: cancellationlbl, text: "View Cancellation Policy", textcolor: HexColor("#5F5F5F"), font: .poppinsRegular(size: 10))
        //    btnView.addBottomBorderWithColor(color: HexColor("#5F5F5F"), width: 1)
        cancelationBtn.setTitle("", for: .normal)
        cancelationBtn.addTarget(self, action: #selector(cancelationBtnAction(_:)), for: .touchUpInside)
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
        lbl.numberOfLines = 0
    }
    
    
    @objc func cancelationBtnAction(_ sender:UIButton) {
        delegate?.didTapOnCancellationPolicyBtn(cell: self)
    }
    
    
    
}
