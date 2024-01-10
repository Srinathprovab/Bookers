//
//  SearchFlightTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 17/08/22.
//

import UIKit


protocol SearchFlightTVCellDelegate {
    
    func didTapOnFromCity(cell:HolderViewTVCell)
    func didTapOnToCity(cell:HolderViewTVCell)
    func didTapOnSelectDepDateBtn(cell:DualViewTVCell)
    func didTapOnSelectRepDateBtn(cell:DualViewTVCell)
    func didTapOnAddTravelerEconomy()
    func didTapOnSearchFlightsBtn(cell:SearchFlightTVCell)
    func didTapOnLocationOrCityBtn(cell:HolderViewTVCell)
    func didTapOnAddRooms(cell:HolderViewTVCell)
    func didtapOnCheckInBtn(cell:DualViewTVCell)
    func didtapOnCheckOutBtn(cell:DualViewTVCell)
    func didTapOnSearchHotelsBtn(cell:ButtonTVCell)
    func didTapOnAirlinesSelectBtnAction(cell:AdvancedSearchTVCell)
    
    func didTapOnSelectAirlines()
    func didTapOnSelectNationality()
    
    
    func donedatePicker(cell:SearchFlightTVCell)
    func cancelDatePicker(cell:SearchFlightTVCell)
    
    
}

class SearchFlightTVCell: TableViewCell,DualViewTVCellDelegate,ButtonTVCellDelegate, AdvancedSearchTVCellDelegate {
    
    
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var searchFlightTV: UITableView!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    
    
    let formter = DateFormatter()
    
    let depDatePicker = UIDatePicker()
    let retdepDatePicker = UIDatePicker()
    let retDatePicker = UIDatePicker()
    var countryNameArray = [String]()
    var key = String()
    var delegate:SearchFlightTVCellDelegate?
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
        formter.dateFormat = "dd-MM-yyyy"
        self.key = cellInfo?.key ?? ""
        
        countrylist.forEach { i in
            countryNameArray.append(i.name ?? "")
        }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name("reload"), object: nil)
        searchFlightTV.reloadData()
        
        
    }
    
    @objc func reload(){
        searchFlightTV.reloadData()
    }
    
    
    
    func setupTV() {
        
        holderView.backgroundColor = .WhiteColor
        searchFlightTV.layer.cornerRadius = 10
        searchFlightTV.clipsToBounds = true
        searchFlightTV.layer.borderWidth = 1
        searchFlightTV.layer.borderColor = UIColor.AppBorderColor.cgColor
        searchFlightTV.backgroundColor = .AppBGcolor
        searchFlightTV.register(UINib(nibName: "HolderViewTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        searchFlightTV.register(UINib(nibName: "HolderViewTVCell", bundle: nil), forCellReuseIdentifier: "cell1")
        searchFlightTV.register(UINib(nibName: "DualViewTVCell", bundle: nil), forCellReuseIdentifier: "cell2")
        searchFlightTV.register(UINib(nibName: "DualViewTVCell", bundle: nil), forCellReuseIdentifier: "cell3")
        searchFlightTV.register(UINib(nibName: "HolderViewTVCell", bundle: nil), forCellReuseIdentifier: "cell333")
        searchFlightTV.register(UINib(nibName: "HolderViewTVCell", bundle: nil), forCellReuseIdentifier: "cell5")
        searchFlightTV.register(UINib(nibName: "ButtonTVCell", bundle: nil), forCellReuseIdentifier: "cell4")
        searchFlightTV.register(UINib(nibName: "AdvancedSearchTVCell", bundle: nil), forCellReuseIdentifier: "cell66")
        
        searchFlightTV.separatorStyle = .none
        searchFlightTV.delegate = self
        searchFlightTV.dataSource = self
        searchFlightTV.tableFooterView = UIView()
        searchFlightTV.showsHorizontalScrollIndicator = false
        searchFlightTV.isScrollEnabled = false
        
    }
    
    func didTapOnSelectDepDateBtn(cell: DualViewTVCell) {
        delegate?.didTapOnSelectDepDateBtn(cell: cell)
    }
    
    func didTapOnSelectRepDateBtn(cell: DualViewTVCell) {
        delegate?.didTapOnSelectRepDateBtn(cell: cell)
    }
    
    @objc func didTapOnFromCity(cell:HolderViewTVCell){
        delegate?.didTapOnFromCity(cell: cell)
    }
    @objc func didTapOnToCity(cell:HolderViewTVCell){
        delegate?.didTapOnToCity(cell: cell)
    }
    
    func btnAction(cell: ButtonTVCell) {
        delegate?.didTapOnSearchFlightsBtn(cell: self)
    }
    
    @objc func didTapOnLocationOrCityBtn(cell:HolderViewTVCell){
        delegate?.didTapOnLocationOrCityBtn(cell: cell)
    }
    
    @objc func didtapOnCheckInBtn(cell:DualViewTVCell){
        delegate?.didtapOnCheckInBtn(cell: cell)
    }
    
    @objc func didtapOnCheckOutBtn(cell:DualViewTVCell){
        delegate?.didtapOnCheckOutBtn(cell: cell)
    }
    
    @objc func didTapOnAddTravelerEconomy(){
        delegate?.didTapOnAddTravelerEconomy()
    }
    
    
    @objc func didTapOnSelectAirlines(){
        delegate?.didTapOnSelectAirlines()
    }
    
    
    @objc func didTapOnAddRooms(cell:HolderViewTVCell){
        delegate?.didTapOnAddRooms(cell: cell)
    }
    
    @objc func didTapOnSelectNationality(cell:HolderViewTVCell){
        delegate?.didTapOnSelectNationality()
    }
    
    
    @objc func didTapOnSearchHotelsBtn(cell:ButtonTVCell){
        delegate?.didTapOnSearchHotelsBtn(cell: cell)
    }
    
    
    
    //MARK: - AdvancedSearchTVCell
    func didTapOnAdvancedSearchBtnAction(cell: AdvancedSearchTVCell) {
        
        if cell.showbool == true {
            viewHeight.constant = 460
            cell.btnsView.isHidden = false
            cell.showbool = false
        }else {
            viewHeight.constant = 403
            cell.btnsView.isHidden = true
            cell.showbool = true
        }
        NotificationCenter.default.post(name: NSNotification.Name("AdvancedSearchTVCellreload"), object: nil)
        
        searchFlightTV.beginUpdates()
        searchFlightTV.endUpdates()
    }
    
    func didTapOnAirlinesSelectBtnAction(cell: AdvancedSearchTVCell) {
        delegate?.didTapOnAirlinesSelectBtnAction(cell: cell)
    }
    
}


extension SearchFlightTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.key == "hotel" {
            return 5
        }else {
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        
        if self.key == "hotel" {
            
            if indexPath.row == 0 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? HolderViewTVCell {
                    cell.selectionStyle = .none
                    cell.titlelbl.text = "\(defaults.string(forKey: UserDefaultsKeys.locationcity) ?? "City/Location")"
                    cell.locImg.image = UIImage(named: "loc")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppJournyTabSelectColor)
                    cell.dropdownimg.isHidden = true
                    cell.fromBtn.addTarget(self, action: #selector(didTapOnLocationOrCityBtn(cell:)), for: .touchUpInside)
                    cell.tag = 1
                    cell.swipeView.isHidden = true
                    c = cell
                }
            }else  if indexPath.row == 1 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as? DualViewTVCell {
                    cell.selectionStyle = .none
                    cell.delegate = self
                    cell.deplbl.text = defaults.string(forKey: UserDefaultsKeys.checkin) ?? "Check In"
                    cell.returnlbl.text = defaults.string(forKey: UserDefaultsKeys.checkout) ?? "Check Out"
                    cell.depBtn.addTarget(self, action: #selector(didtapOnCheckInBtn(cell:)), for: .touchUpInside)
                    cell.returnBtn.addTarget(self, action: #selector(didtapOnCheckOutBtn(cell:)), for: .touchUpInside)
                    
                    cell.showReturnView()
                    
                    //                    cell.depTF.isHidden = false
                    //                    cell.retTF.isHidden = false
                    showreturndepDatePicker(cell: cell)
                    showretDatePicker(cell: cell)
                    
                    c = cell
                }
            }else  if indexPath.row == 2 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "cell333") as? HolderViewTVCell {
                    cell.selectionStyle = .none
                    cell.titlelbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectPersons) ?? "+ Add Rooms")"
                    cell.locImg.image = UIImage(named: "traveler")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppJournyTabSelectColor)
                    cell.dropdownimg.isHidden = false
                    cell.fromBtn.addTarget(self, action: #selector(didTapOnAddRooms(cell:)), for: .touchUpInside)
                    cell.tag = 3
                    cell.swipeView.isHidden = true
                    c = cell
                }
            }else  if indexPath.row == 3 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "cell5") as? HolderViewTVCell {
                    cell.selectionStyle = .none
                    cell.titlelbl.text = defaults.string(forKey: UserDefaultsKeys.hnationality) ?? "Nationality"
                    cell.dropdownimg.isHidden = false
                    cell.fromBtn.addTarget(self, action: #selector(didTapOnSelectNationality(cell:)), for: .touchUpInside)
                    cell.swipeView.isHidden = true
                    cell.locImg.image = UIImage(named: "na")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppJournyTabSelectColor)
                    
                    c = cell
                }
            }else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "cell4") as? ButtonTVCell {
                    cell.selectionStyle = .none
                    cell.titlelbl.text = "Search Hotels"
                    cell.holderView.backgroundColor = .AppHolderViewColor
                    cell.btnLeftConstraint.constant = 16
                    cell.delegate = self
                    cell.btn.addTarget(self, action: #selector(didTapOnSearchHotelsBtn(cell:)), for: .touchUpInside)
                    c = cell
                }
            }
            
        }else {
            
            if indexPath.row == 0 {
                
                if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? HolderViewTVCell {
                    cell.selectionStyle = .none
                    cell.toView.isHidden = false
                    cell.swipeView.isHidden = false
                    cell.fromBtn.addTarget(self, action: #selector(didTapOnFromCity(cell:)), for: .touchUpInside)
                    cell.toBtn.addTarget(self, action: #selector(didTapOnToCity(cell:)), for: .touchUpInside)
                    cell.locImg.image = UIImage(named: "from")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppJournyTabSelectColor)
                    cell.locImg1.image = UIImage(named: "to")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppJournyTabSelectColor)
                    if self.key == "roundtrip" {
                        
                        
                        if let fromstr = defaults.string(forKey: UserDefaultsKeys.fromCity) {
                            if fromstr.isEmpty == true {
                                cell.titlelbl.text = "From"
                                cell.tolabel.text =  "To"
                                
                            }else {
                                cell.titlelbl.text = defaults.string(forKey: UserDefaultsKeys.fromCity) ?? "From"
                                cell.tolabel.text = defaults.string(forKey: UserDefaultsKeys.toCity) ?? "To"
                            }
                        }
                        
                    }else {
                        
                        if let fromstr = defaults.string(forKey: UserDefaultsKeys.fromCity) {
                            if fromstr.isEmpty == true {
                                cell.titlelbl.text = "From"
                                cell.tolabel.text =  "To"
                            }else {
                                cell.titlelbl.text = defaults.string(forKey: UserDefaultsKeys.fromCity) ?? "From"
                                cell.tolabel.text = defaults.string(forKey: UserDefaultsKeys.toCity) ?? "To"
                            }
                        }
                    }
                    
                    
                    cell.tag = 1
                    c = cell
                }
            }else  if indexPath.row == 1 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as? DualViewTVCell {
                    cell.selectionStyle = .none
                    cell.delegate = self
                    cell.key = "date"
                    
                    if self.key == "roundtrip" {
                        cell.showReturnView()
                        cell.returnView.isHidden = false
                        
                        if let datestr1 = defaults.string(forKey: UserDefaultsKeys.calDepDate), let datestr2 = defaults.string(forKey: UserDefaultsKeys.calRetDate){
                            
                            cell.returnView.isHidden = false
                            if datestr1.isEmpty == true {
                                cell.deplbl.text =  "Select Date"
                            }
                            
                            
                            
                            if datestr2.isEmpty == true{
                                cell.returnlbl.text =  "Select Date"
                            }
                            
                            
                            if datestr1.isEmpty == false &&  datestr2.isEmpty == false{
                                
                                cell.deplbl.text = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "Select Date"
                                cell.returnlbl.text = defaults.string(forKey: UserDefaultsKeys.calRetDate) ?? "Select Date"
                            }
                        }
                        
                        cell.depTF.isHidden = false
                        cell.retTF.isHidden = false
                        showreturndepDatePicker(cell: cell)
                        showretDatePicker(cell: cell)
                    }else {
                        cell.hideRetView()
                        cell.returnView.isHidden = true
                        if let datestr1 = defaults.string(forKey: UserDefaultsKeys.calDepDate){
                            if datestr1.isEmpty == true {
                                cell.deplbl.text =  "Select Date"
                            }
                            if datestr1.isEmpty == false {
                                cell.deplbl.text = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "Select Date"
                                
                            }
                        }
                        
                        
                        cell.retTF.isHidden = true
                        cell.depTF.isHidden = false
                        showdepDatePicker(cell: cell)
                    }
                    
                    c = cell
                }
            }else  if indexPath.row == 2 {
                
                if let cell = tableView.dequeueReusableCell(withIdentifier: "cell3") as? DualViewTVCell {
                    cell.selectionStyle = .none
                    cell.delegate = self
                    cell.showReturnView()
                    cell.key = "airlines"
                    cell.cal1Img.image = UIImage(named: "traveler")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppJournyTabSelectColor)
                    cell.cal2img.image = UIImage(named: "airlines")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppJournyTabSelectColor)
                    
                    if self.key == "roundtrip" {
                        cell.deplbl.text = "\(defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? "+ Add Traveller")"
                    }else {
                        cell.deplbl.text = "\(defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? "+ Add Traveller")"
                        
                    }
                    
                    cell.returnlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.nationality) ?? "ALL")"
                    
                    cell.depBtn.addTarget(self, action: #selector(didTapOnAddTravelerEconomy), for: .touchUpInside)
                    cell.returnBtn.addTarget(self, action: #selector(didTapOnSelectAirlines), for: .touchUpInside)
                    
                    c = cell
                }
                
            }else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "cell4") as? ButtonTVCell {
                    cell.selectionStyle = .none
                    cell.titlelbl.text = "Search Flights"
                    cell.holderView.backgroundColor = .AppHolderViewColor
                    cell.btnLeftConstraint.constant = 16
                    cell.delegate = self
                    c = cell
                }
            }
        }
        return c
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? HolderViewTVCell {
            switch cell.tag {
            case 1:
                delegate?.didTapOnFromCity(cell: cell)
                break
                
            case 2:
                delegate?.didTapOnToCity(cell: cell)
                break
                
            case 3:
                //delegate?.didTapOnAddTravelerEconomy(cell: cell)
                break
                
            default:
                break
            }
        }
    }
    
    
    
}



extension SearchFlightTVCell {
    
    
    //MARK: - showdepDatePicker
    func showdepDatePicker(cell:DualViewTVCell){
        //Formate Date
        depDatePicker.datePickerMode = .date
        depDatePicker.minimumDate = Date()
        depDatePicker.preferredDatePickerStyle = .wheels
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        if let calDepDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "") {
            depDatePicker.date = calDepDate
            
            if cell.returnlbl.text == "Select Date" {
                retdepDatePicker.date = calDepDate
            }
        }
        
        
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        cell.depTF.inputAccessoryView = toolbar
        cell.depTF.inputView = depDatePicker
        
    }
    
    
    
    //MARK: - showreturndepDatePicker
    func showreturndepDatePicker(cell:DualViewTVCell){
        //Formate Date
        retdepDatePicker.datePickerMode = .date
        retdepDatePicker.minimumDate = Date()
        retdepDatePicker.preferredDatePickerStyle = .wheels
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        
        if key == "hotel" {
            
            if let checkinDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.checkin) ?? "")  {
                retdepDatePicker.date = checkinDate
                
                
                if defaults.string(forKey: UserDefaultsKeys.checkin) == nil {
                    retdepDatePicker.date = checkinDate
                }
            }
            
        }else {
            if let rcalDepDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "")  {
                retdepDatePicker.date = rcalDepDate
                
                
                if defaults.string(forKey: UserDefaultsKeys.calRetDate) == nil || cell.returnlbl.text == "Select Date" {
                    retdepDatePicker.date = rcalDepDate
                }
            }
        }
        
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        cell.depTF.inputAccessoryView = toolbar
        cell.depTF.inputView = retdepDatePicker
        
    }
    
    
    
    //MARK: - showretDatePicker
    func showretDatePicker(cell:DualViewTVCell){
        //Formate Date
        retDatePicker.datePickerMode = .date
        //        retDatePicker.minimumDate = Date()
        // Set minimumDate for retDatePicker based on depDatePicker or retdepDatePicker
        let selectedDate = cell.depTF.isFirstResponder ? depDatePicker.date : retdepDatePicker.date
        retDatePicker.minimumDate = selectedDate
        
        retDatePicker.preferredDatePickerStyle = .wheels
        
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        if key == "hotel" {
            if let checkoutDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.checkout) ?? "") {
                retDatePicker.date = checkoutDate
            }
        }else {
            
            
            if let calDepDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "") {
                
                if cell.returnlbl.text == "Select Date" {
                    retDatePicker.date = calDepDate
                    
                }else {
                    if let rcalRetDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.calRetDate) ?? "") {
                        retDatePicker.date = rcalRetDate
                    }
                }
            }
        }
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        cell.retTF.inputAccessoryView = toolbar
        cell.retTF.inputView = retDatePicker
        
        
    }
    
    
    @objc func donedatePicker(){
        delegate?.donedatePicker(cell:self)
    }
    
    
    @objc func cancelDatePicker(){
        delegate?.cancelDatePicker(cell:self)
    }
    
}
