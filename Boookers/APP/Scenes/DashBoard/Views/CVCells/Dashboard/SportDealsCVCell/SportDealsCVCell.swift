//
//  SportDealsCVCell.swift
//  Boookers
//
//  Created by FCI on 15/02/24.
//

import UIKit

class SportDealsCVCell: UICollectionViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subTitlelbl: UILabel!
    @IBOutlet weak var viewDetailsBtn: UIButton!
    
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
