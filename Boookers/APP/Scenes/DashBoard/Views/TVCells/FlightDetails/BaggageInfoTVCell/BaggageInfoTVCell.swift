//
//  BaggageInfoTVCell.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit

class BaggageInfoTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    
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
      
        
    }
    
    func setupUI() {
        holderView.backgroundColor = .AppHolderViewColor
    }
   
    
}
