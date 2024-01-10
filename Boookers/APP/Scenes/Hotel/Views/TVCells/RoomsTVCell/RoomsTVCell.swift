







//
//  RoomsTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 22/08/22.
//


import UIKit
protocol RoomsTVCellDelegate {
    func didTapOnCancellationPolicyBtn(cell:TwinSuperiorRoomTVCell)
    func didTapOnRoomTvcell(cell:TwinSuperiorRoomTVCell)
}

class RoomsTVCell: TableViewCell, TwinSuperiorRoomTVCellDelegate {
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var roomsTV: UITableView!
    
    var rooms = [[Rooms]]()
    var delegate:RoomsTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupTV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title
        rooms = cellInfo?.moreData as! [[Rooms]]
        roomsTV.reloadData()
    }
    
    
    
    func setupTV() {
        roomsTV.register(UINib(nibName: "TwinSuperiorRoomTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        roomsTV.delegate = self
        roomsTV.dataSource = self
        roomsTV.tableFooterView = UIView()
        roomsTV.separatorStyle = .none
        roomsTV.backgroundColor = .WhiteColor
        roomsTV.isScrollEnabled = true
        roomsTV.layer.cornerRadius = 6
        roomsTV.clipsToBounds = true
        roomsTV.layer.borderWidth = 1
        roomsTV.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
    }
    
    func didTapOnCancellationPolicyBtn(cell:TwinSuperiorRoomTVCell) {
        delegate?.didTapOnCancellationPolicyBtn(cell: cell)
    }
    
    
}



extension RoomsTVCell:UITableViewDataSource,UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return rooms.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TwinSuperiorRoomTVCell {
            cell.selectionStyle = .none
            cell.delegate = self
            
            
            if indexPath.section < rooms.count && indexPath.row < rooms[indexPath.section].count {
                
                let section = indexPath.section
                let row = indexPath.row
                let data = rooms[section][row]
                
                cell.titlelbl.text = data.name
                cell.subtitlelbl.text = "\(data.adults ?? 0) Adults"
                cell.noOfRoomslbl.text = "No Of Rooms: \(data.rooms ?? 0)"
                cell.kwdlbl.text = data.currency
                cell.kwdPricelbl.text = data.net
                cell.ratekey = data.rateKey ?? ""
                
                
                // Access the cancellationPolicies array
                if let cancellationPolicies1 = data.cancellationPolicies {
                    
                    
                    
                    // Iterate over the cancellationPolicies array
                    for policy in cancellationPolicies1 {
                        let amount = policy.amount
                        let fromDate = policy.from
                        cell.CancellationPolicyAmount = amount ?? ""
                        cell.CancellationPolicyFromDate = fromDate ?? ""
                        
                    }
                }
                
                
                if data.refund == true {
                    cell.nonRefundablelbl.text = "Refundable"
                    cell.nonRefundablelbl.textColor = .Refundcolor
                }else {
                    cell.nonRefundablelbl.text = "Non Refundable"
                    cell.nonRefundablelbl.textColor = HexColor("#FF0808")
                }
                
                
                
            } else {
                print("Index out of range error: indexPath = \(indexPath)")
            }
            
            c = cell
        }
        return c
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? TwinSuperiorRoomTVCell {
            cell.radioImg.image = UIImage(named: "radioSelected")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBackgroundColor)
            delegate?.didTapOnRoomTvcell(cell: cell)
            defaults.set(cell.titlelbl.text, forKey: UserDefaultsKeys.roomType)
            defaults.set(cell.nonRefundablelbl.text, forKey: UserDefaultsKeys.refundtype)
            
            print(cell.CancellationPolicyFromDate)
        }
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? TwinSuperiorRoomTVCell {
            cell.radioImg.image = UIImage(named: "radioUnselected")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBackgroundColor)
        }
    }
    
}
