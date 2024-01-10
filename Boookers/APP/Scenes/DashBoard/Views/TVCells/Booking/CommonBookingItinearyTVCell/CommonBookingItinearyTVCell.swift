//
//  CommonBookingItinearyTVCell.swift
//  BestFares365App
//
//  Created by FCI on 25/05/23.
//

import UIKit

class CommonBookingItinearyTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var bookingInfoTV: UITableView!
    @IBOutlet weak var tvheight: NSLayoutConstraint!
    
    var pricekwd = String()
    var fdetails = [Summary]()
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
        pricekwd = cellInfo?.title ?? ""
        fdetails = cellInfo?.moreData as! [Summary]
        tvheight.constant = CGFloat(fdetails.count * 130)
        bookingInfoTV.reloadData()
    }
    
    func setupUI() {
        
        holderView.backgroundColor = .WhiteColor
        bookingInfoTV.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 10)
        
        setupTV()
    }
    
    
    func setupTV() {
        
        let nib = UINib(nibName: "BookingItinearyTVCell", bundle: nil)
        bookingInfoTV.register(nib, forCellReuseIdentifier: "cell")
        bookingInfoTV.delegate = self
        bookingInfoTV.dataSource = self
        bookingInfoTV.tableFooterView = UIView()
        bookingInfoTV.separatorStyle = .none
        bookingInfoTV.isScrollEnabled = false
        
    }
    
    
}



extension CommonBookingItinearyTVCell:UITableViewDelegate,UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fdetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var commonCell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? BookingItinearyTVCell {
            
            
            let data = fdetails[indexPath.row]
            
            cell.airlinesnamelbl.text = data.operator_name
            cell.airlinescodelbl.text = "(\(data.operator_code ?? "")-\(data.flight_number ?? ""))"
            cell.logoImg.sd_setImage(with: URL(string: data.operator_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
          //  cell.kwdlbl.text = cellInfo?.title
            
            cell.fromtimelbl.text = data.origin?.time
            cell.totimelbl.text = data.destination?.time
            cell.fromcitylbl.text = data.origin?.city
            cell.tocitylbl.text = data.destination?.city
            cell.durationlbl.text = data.duration
            cell.noofstopslbl.text = "\(data.no_of_stops ?? 0) Stops"
            cell.datelbl.text = data.origin?.date
            cell.todatelbl.text = data.destination?.date
            
            cell.img1.isHidden = true
            cell.img2.isHidden = true
            cell.img3.isHidden = true
            
            if data.no_of_stops == 2 {
                cell.img1.isHidden = false
                cell.img2.isHidden = false
                cell.img3.isHidden = true
            }else if data.no_of_stops == 1 {
                cell.img1.isHidden = false
                cell.img2.isHidden = true
                cell.img3.isHidden = true
            }else {
                cell.img1.isHidden = true
                cell.img2.isHidden = true
                cell.img3.isHidden = true
            }
            

            
            commonCell = cell
        }
        return commonCell
    }
    
}
