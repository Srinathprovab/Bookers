//
//  FlightDealsCVCell.swift
//  Boookers
//
//  Created by FCI on 15/02/24.
//

import UIKit



class FlightDealsCVCell: UICollectionViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var fromlbl: UILabel!
    @IBOutlet weak var tolbl: UILabel!
    @IBOutlet weak var viewDetailsBtn: UIButton!
    
    var hit_url = String()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    
    func setupUI() {
        holderView.layer.cornerRadius = 4
        img.layer.cornerRadius = 4
        img.clipsToBounds = true
        viewDetailsBtn.layer.cornerRadius = 4
        viewDetailsBtn.addTarget(self, action: #selector(didTapOnViewFlightTopDetailsBtnAction(_:)), for: .touchUpInside)
    }
    
    
   
    @objc func didTapOnViewFlightTopDetailsBtnAction(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name("flighttopdetails"), object: hit_url)
    }
    
}
