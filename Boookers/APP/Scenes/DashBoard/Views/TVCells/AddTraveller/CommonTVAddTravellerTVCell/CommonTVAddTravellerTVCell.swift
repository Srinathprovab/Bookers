//
//  CommonTVAddTravellerTVCell.swift
//  KuwaitWays
//
//  Created by FCI on 23/06/23.
//

import UIKit

protocol CommonTVAddTravellerTVCellDelegate {
    func didTapOnExpandAdultViewbtnAction(cell:AddDeatilsOfTravellerTVCell)
}

class CommonTVAddTravellerTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var addtravellertv: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    var delegate:CommonTVAddTravellerTVCellDelegate?
    var isCellExpanded = false
    var selectedIndexPath: IndexPath?
    var adultsCount = Int()
    var childCount = Int()
    var infantsCount = Int()
    var flighttotelCount = Int()
    var viewHeight = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupui()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
                flighttotelCount = (adultsCount + childCount + infantsCount)
                
            }else if journeyType == "circle"{
                
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
                flighttotelCount = (adultsCount + childCount + infantsCount)
            }else {
                
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
                flighttotelCount = (adultsCount + childCount + infantsCount)
            }
        }
        
        updateHeight()
    }
    
    func updateHeight(){
        tvHeight.constant = CGFloat(flighttotelCount * 45 + viewHeight)
        addtravellertv.reloadData()
    }
    
    
    func setupui(){
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 8)
        setupTV()
        
    }
    
    func setupTV() {
        addtravellertv.register(UINib(nibName: "AddDeatilsOfTravellerTVCell", bundle: nil), forCellReuseIdentifier: "cell1")
        addtravellertv.register(UINib(nibName: "AddDeatilsOfTravellerTVCell", bundle: nil), forCellReuseIdentifier: "cell2")
        addtravellertv.register(UINib(nibName: "AddDeatilsOfTravellerTVCell", bundle: nil), forCellReuseIdentifier: "cell3")
        
        
        addtravellertv.delegate = self
        addtravellertv.dataSource = self
        addtravellertv.tableFooterView = UIView()
        addtravellertv.separatorStyle = .none
        addtravellertv.backgroundColor = .AppHolderViewColor
    }
    
    

}


extension CommonTVAddTravellerTVCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flighttotelCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if indexPath.row < adultsCount { // Display adult details
            if let adultCell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? AddDeatilsOfTravellerTVCell {
                adultCell.titlelbl.text = "Adult \(indexPath.row + 1)"
                if indexPath == selectedIndexPath {
                    adultCell.expandView()
                } else {
                    adultCell.collapsView()
                }
                
                
                cell = adultCell
            }
        } else if indexPath.row < adultsCount + childCount { // Display child details
            if let childCell = tableView.dequeueReusableCell(withIdentifier: "cell2") as? AddDeatilsOfTravellerTVCell {
                childCell.titlelbl.text = "Child \(indexPath.row - adultsCount + 1)"
                if indexPath == selectedIndexPath {
                    childCell.expandView()
                } else {
                    childCell.collapsView()
                }
                
                
                cell = childCell
            }
        } else { // Display infant details
            if let infantCell = tableView.dequeueReusableCell(withIdentifier: "cell3") as? AddDeatilsOfTravellerTVCell {
                infantCell.titlelbl.text = "Infant \(indexPath.row - adultsCount - childCount + 1)"
                if indexPath == selectedIndexPath {
                    infantCell.expandView()
                } else {
                    infantCell.collapsView()
                }
                
             
                
                cell = infantCell
            }
        }
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedIndexPath == indexPath {
            selectedIndexPath = nil // Deselect the cell if it was already selected
            viewHeight = 0
        } else {
            viewHeight = 100
            selectedIndexPath = indexPath // Select the clicked cell
        }
        
        
//        if let cell = tableView.cellForRow(at: indexPath) as? AddDeatilsOfTravellerTVCell {
//            tableView.reloadData() // Reload the table view to update cell heights and appearance
//            delegate?.didTapOnExpandAdultViewbtnAction(cell: cell)
//        }
        
       updateHeight()
       
    }
    
}

