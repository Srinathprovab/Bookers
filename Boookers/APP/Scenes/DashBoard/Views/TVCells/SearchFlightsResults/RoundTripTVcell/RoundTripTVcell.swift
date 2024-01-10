//
//  RoundTripTVcell.swift
//  QBBYTravelApp
//
//  Created by FCI on 10/01/23.
//

import UIKit


protocol RoundTripTVcellDelegate {
    func didTaponRoundTripCell(cell:RoundTripTVcell)
}

class RoundTripTVcell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var flightDetailsTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    @IBOutlet weak var refundView: UIView!
    @IBOutlet weak var refundlbl: UILabel!
    @IBOutlet weak var kwdPricelbl: UILabel!
    
    
    var delegate:RoundTripTVcellDelegate?
    var count = Int()
    var summery1 = [Summary]()
    var msummery = [MSummary]()
    var access_key1 = String()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setuUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        
        access_key1 = cellInfo?.title ?? ""
        count = cellInfo?.characterLimit ?? 0
        kwdPricelbl.text = cellInfo?.kwdprice
        refundlbl.text = cellInfo?.refundable
        
        summery1 = cellInfo?.moreData as! [Summary]
        tvHeight.constant = CGFloat((summery1.count * 115))
        flightDetailsTV.reloadData()
    }
    
    
    
    func setuUI() {
        
        contentView.backgroundColor = .AppHolderViewColor
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 6)
        setupTV()
        refundView.backgroundColor = .AppBackgroundColor
        refundView.layer.cornerRadius = 6
        refundView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        refundView.clipsToBounds = true
        setuplabels(lbl: kwdPricelbl, text: "", textcolor: .WhiteColor, font: .oswaldRegular(size: 16), align: .right)
        setuplabels(lbl: refundlbl, text: "", textcolor: .WhiteColor, font: .oswaldRegular(size: 13), align: .left)
    }
    
    
    
    func setupTV() {
        flightDetailsTV.register(UINib(nibName: "RoundTripInfoTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        flightDetailsTV.delegate = self
        flightDetailsTV.dataSource = self
        flightDetailsTV.tableFooterView = UIView()
        flightDetailsTV.showsHorizontalScrollIndicator = false
        flightDetailsTV.separatorStyle = .singleLine
        flightDetailsTV.isScrollEnabled = false
    }
    
}


extension RoundTripTVcell:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return summery1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? RoundTripInfoTVCell {
            
            cell.selectionStyle = .none
            
            
            let data = summery1[indexPath.row]
            cell.fromCityTimelbl.text = data.origin?.time
            cell.fromCityNamelbl.text = data.origin?.city
            cell.toCityTimelbl.text = data.destination?.time
            cell.toCityNamelbl.text = data.destination?.city
            cell.hourslbl.text = data.duration
            cell.noOfStopslbl.text = "\(data.no_of_stops ?? 0) Stops"
            cell.inNolbl.text = "\(data.operator_name ?? "") (\(data.operator_code ?? "")-\(data.flight_number ?? ""))"
            cell.logoImg.sd_setImage(with: URL(string: data.operator_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            switch data.no_of_stops {
            case 0:
                cell.round1.isHidden = true
                cell.round2.isHidden = true
                break
            case 1:
                cell.round1.isHidden = false
                break
            case 2:
                cell.round1.isHidden = false
                cell.round2.isHidden = false
                break
            default:
                break
            }
            
            c = cell
            
        }
        return c
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didTaponRoundTripCell(cell: self)
    }
    
}
