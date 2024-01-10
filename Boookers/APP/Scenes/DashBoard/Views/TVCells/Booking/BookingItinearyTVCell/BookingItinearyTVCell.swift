//
//  BookingItinearyTVCell.swift
//  BestFares365App
//
//  Created by FCI on 25/05/23.
//

import UIKit

class BookingItinearyTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var airlinesnamelbl: UILabel!
    @IBOutlet weak var airlinescodelbl: UILabel!
    //    @IBOutlet weak var kwdlbl: UILabel!
    //    @IBOutlet weak var perpersonlbl: UILabel!
    @IBOutlet weak var fromtimelbl: UILabel!
    @IBOutlet weak var fromcitylbl: UILabel!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var totimelbl: UILabel!
    @IBOutlet weak var tocitylbl: UILabel!
    @IBOutlet weak var todatelbl: UILabel!
    @IBOutlet weak var durationlbl: UILabel!
    @IBOutlet weak var noofstopslbl: UILabel!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    
    
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
        //    logoImg.image = cellInfo?.airlineslogo
        airlinesnamelbl.text = cellInfo?.airlinesname
        airlinescodelbl.text = cellInfo?.airlinesCode
        //        kwdlbl.text = cellInfo?.price
        //        perpersonlbl.text = "Total Price"
        fromtimelbl.text = cellInfo?.fromTime
        fromcitylbl.text = cellInfo?.fromCity
        datelbl.text = cellInfo?.title
        totimelbl.text = cellInfo?.toTime
        tocitylbl.text = cellInfo?.toCity
        todatelbl.text = cellInfo?.subTitle
        
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
    }
    
}
