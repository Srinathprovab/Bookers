//
//  HotelDealsCVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 16/08/22.
//

import UIKit

class HotelDealsCVCell: UICollectionViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subTitlelbl: UILabel!
    @IBOutlet weak var viewDetailsBtn: UIButton!
    @IBOutlet weak var nightslbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    
    func setupUI() {
        holderView.layer.cornerRadius = 6
        img.layer.cornerRadius = 4
        viewDetailsBtn.layer.cornerRadius = 4
    }
    
}
