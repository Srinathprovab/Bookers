//
//  MultiCityTripTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 19/08/22.
//

import UIKit
protocol MultiCityTripTVCellDelegate {
    func didTapOnFromBtn(cell:MulticityFromToTVCell)
    func didTapOnToBtn(cell:MulticityFromToTVCell)
    func didTapOndateBtn(cell:MulticityFromToTVCell)
    func didTapOnCloseBtn(cell:MulticityFromToTVCell)
    func didTapOnMultiCityTripSearchFlight(cell:ButtonTVCell)
    func didTapOnAddTravellerEconomy(cell:HolderViewTVCell)
}

class MultiCityTripTVCell: TableViewCell, ButtonTVCellDelegate, AddCityTVCellDelegate {
    func didTapOnSelectAirlineBtnAction(cell: AddCityTVCell) {
        
    }
    
    func donedatePicker(cell: MulticityFromToTVCell) {
        
    }
    
    
    
    func didTapOnAddCityBtn(cell: AddCityTVCell) {
        
    }
    
    func didTapOnAddTravellerEconomy(cell: AddCityTVCell) {
    
    }
    
    func didTapOnMultiCityTripSearchFlight(cell: AddCityTVCell) {
        
    }
    
    func donedatePicker(cell: AddCityTVCell) {
        
    }
    
    func cancelDatePicker(cell: AddCityTVCell) {
        
    }
    
    
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var multiTripTV: UITableView!
    
    var delegate:MultiCityTripTVCellDelegate?
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
        multiTripTV.reloadData()
    }
    
    func setupUI() {
        holderView.backgroundColor = .AppBGcolor
        setupTV()
    }
    
    func setupTV() {
        multiTripTV.backgroundColor = .AppHolderViewColor
        multiTripTV.register(UINib(nibName: "AddCityTVCell", bundle: nil), forCellReuseIdentifier: "cell1")
        multiTripTV.register(UINib(nibName: "HolderViewTVCell", bundle: nil), forCellReuseIdentifier: "cell2")
        multiTripTV.register(UINib(nibName: "ButtonTVCell", bundle: nil), forCellReuseIdentifier: "cell3")
        
        multiTripTV.delegate = self
        multiTripTV.dataSource = self
        multiTripTV.tableFooterView = UIView()
        multiTripTV.separatorStyle = .none
        multiTripTV.backgroundColor = .AppHolderViewColor
        multiTripTV.layer.cornerRadius = 8
        multiTripTV.clipsToBounds = true
        
    }
    
    
    func btnAction(cell: ButtonTVCell) {
        delegate?.didTapOnMultiCityTripSearchFlight(cell: cell)
    }
    
    @objc func didTapOnAddTravellerEconomy(cell:HolderViewTVCell) {
        delegate?.didTapOnAddTravellerEconomy(cell: cell)
    }
    
    
    func didTapOnFromBtn(cell: MulticityFromToTVCell) {
        delegate?.didTapOnFromBtn(cell: cell)
    }
    
    func didTapOnToBtn(cell: MulticityFromToTVCell) {
        delegate?.didTapOnToBtn(cell: cell)
    }
    
    func didTapOndateBtn(cell: MulticityFromToTVCell) {
        delegate?.didTapOndateBtn(cell: cell)
    }
    
    func didTapOnCloseBtn(cell: MulticityFromToTVCell) {
        delegate?.didTapOnCloseBtn(cell: cell)
    }
    
    
    
}

extension MultiCityTripTVCell:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var c = UITableViewCell()
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? AddCityTVCell {
                cell.selectionStyle = .none
                cell.delegate = self
                c = cell
            }
        }else  if indexPath.row == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as? HolderViewTVCell {
                cell.titlelbl.text = "\(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "+ Add Traveller") traveller - \(defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "") "
                defaults.set(cell.titlelbl.text, forKey: UserDefaultsKeys.travellerDetails)
                cell.locImg.image = UIImage(named: "traveler")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppJournyTabSelectColor)
                cell.dropdownimg.isHidden = false
                cell.tag = 3
                //  cell.fromBtn.addTarget(self, action: #selector(didTapOnAddTravellerEconomy(cell:)), for: .touchUpInside)
                c = cell
            }
        }else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell3") as? ButtonTVCell {
                cell.titlelbl.text = "Search Flights"
                cell.holderView.backgroundColor = .AppHolderViewColor
                cell.btnLeftConstraint.constant = 16
                cell.delegate = self
                c = cell
            }
        }
        
        return c
    }
    
    
}
