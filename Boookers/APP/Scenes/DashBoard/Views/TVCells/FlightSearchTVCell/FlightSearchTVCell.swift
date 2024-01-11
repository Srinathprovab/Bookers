//
//  FlightSearchTVCell.swift
//  Boookers
//
//  Created by FCI on 11/01/24.
//

import UIKit
import DropDown

protocol FlightSearchTVCellDelegate {
    
    func didTapOnAdvanceOption(cell:FlightSearchTVCell)
    func didTapOnClassBtnAction(cell:FlightSearchTVCell)
    func donedatePicker(cell:FlightSearchTVCell)
    func cancelDatePicker(cell:FlightSearchTVCell)
    func didTapOnFlightSearchBtnAction(cell:FlightSearchTVCell)
    func didTapOnFromCityBtnAction(cell:FlightSearchTVCell)
    func didTapOnToCityBtnAction(cell:FlightSearchTVCell)
    func didTapOnSelectAirlineBtnAction(cell:FlightSearchTVCell)
    func didTapOnCloseModifysearch(cell:FlightSearchTVCell)
}

class FlightSearchTVCell: TableViewCell {
    
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var closebtn: UIButton!
    @IBOutlet weak var onewayBtn: UIButton!
    @IBOutlet weak var roundtripBtn: UIButton!
    @IBOutlet weak var multicityBtn: UIButton!
    @IBOutlet weak var fromTF: UITextField!
    @IBOutlet weak var toTF: UITextField!
    @IBOutlet weak var depView: UIView!
    @IBOutlet weak var depTF: UITextField!
    @IBOutlet weak var retView: UIView!
    @IBOutlet weak var retTF: UITextField!
    @IBOutlet weak var classlbl: UILabel!
    @IBOutlet weak var advanceSearchlbl: UILabel!
    @IBOutlet weak var airlineView: UIView!
    @IBOutlet weak var aitlinelbl: UILabel!
    @IBOutlet weak var adultDecBtn: UIButton!
    @IBOutlet weak var adultCountlbl: UILabel!
    @IBOutlet weak var adultIncBtn: UIButton!
    @IBOutlet weak var childDecBtn: UIButton!
    @IBOutlet weak var childCountlbl: UILabel!
    @IBOutlet weak var childIncBtn: UIButton!
    @IBOutlet weak var infantDecBtn: UIButton!
    @IBOutlet weak var infantCountlbl: UILabel!
    @IBOutlet weak var infantIncBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var onewayclassView: UIView!
    
    let onewayclassDropdown = DropDown()
    var selectClassArray = ["Economy","Premium","First","Business"]
    var infoViewbool = false
    var delegate:FlightSearchTVCellDelegate?
    let depDatePicker = UIDatePicker()
    let retdepDatePicker = UIDatePicker()
    let retDatePicker = UIDatePicker()
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
        
        titlelbl.text = cellInfo?.title
        adultCountlbl.text = defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "0"
        childCountlbl.text = defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0"
        infantCountlbl.text = defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0"
        
        MySingleton.shared.adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "") ?? 0
        MySingleton.shared.childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "") ?? 0
        MySingleton.shared.infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "") ?? 0
        
        
        aitlinelbl.text = defaults.string(forKey: UserDefaultsKeys.nationality) ?? "ALL"
        
        
        if defaults.string(forKey: UserDefaultsKeys.journeyType) == "oneway" {
           
            
            fromTF.text = defaults.string(forKey: UserDefaultsKeys.fromcityname) ?? "Origin"
            toTF.text = defaults.string(forKey: UserDefaultsKeys.tocityname) ?? "Destination"
            
            self.depTF.text = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "Add Date"
            retView.alpha = 0.5
            retTF.text = "Add Date"
            defaults.set("Add Date", forKey: UserDefaultsKeys.calRetDate)
            self.depTF.isHidden = false
            self.retTF.isHidden = true
            showdepDatePicker()
            classlbl.text = defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "Economy"
            
            onewayBtntap()
        }else {
           
            classlbl.text = defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "Economy"
            
            fromTF.text = defaults.string(forKey: UserDefaultsKeys.fromcityname) ?? "Origin"
            toTF.text = defaults.string(forKey: UserDefaultsKeys.tocityname) ?? "Destination"
            
            self.depTF.text = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "Add Date"
            self.retTF.text = defaults.string(forKey: UserDefaultsKeys.calRetDate) ?? "Add Date"
            retView.alpha = 1
            self.depTF.isHidden = false
            self.retTF.isHidden = false
            showreturndepDatePicker()
            showretDatePicker()
            
            roundtripBtntap()
            
        }
        
        
        if cellInfo?.key == "modify" {
            closebtn.isHidden = false
        }
    }
    
    
    func setupUI() {
        
        closebtn.isHidden = true
        setAttributedString(str1: "Advanced search options")
        airlineView.isHidden = true
        multicityBtn.isHidden = true
        fromTF.setLeftPaddingPoints(15)
        toTF.setLeftPaddingPoints(15)
        depTF.setLeftPaddingPoints(15)
        retTF.setLeftPaddingPoints(15)
        
        adultIncBtn.addTarget(self, action: #selector(didTapOnAdultIncrementBtnAction(_:)), for: .touchUpInside)
        adultDecBtn.addTarget(self, action: #selector(didTapOnAdultDecrementBtnAction(_:)), for: .touchUpInside)
        childIncBtn.addTarget(self, action: #selector(didTapOnChildIncrementBtnAction(_:)), for: .touchUpInside)
        childDecBtn.addTarget(self, action: #selector(didTapOnChildDecrementBtnAction(_:)), for: .touchUpInside)
        infantIncBtn.addTarget(self, action: #selector(didTapOnInfantIncrementBtnAction(_:)), for: .touchUpInside)
        infantDecBtn.addTarget(self, action: #selector(didTapOnInfantDecrementBtnAction(_:)), for: .touchUpInside)
        closebtn.addTarget(self, action: #selector(didTapOnCloseModifysearch), for: .touchUpInside)

    
        searchBtn.layer.cornerRadius = 4
        searchBtn.clipsToBounds = true
        
        setupOnewayClassDropDown()
    }
    
    
    
    
    func onewayBtntap() {
        onewayBtn.setTitleColor(.WhiteColor, for: .normal)
        onewayBtn.backgroundColor = .AppBtnColor
        
        roundtripBtn.setTitleColor(.SubTitleColor, for: .normal)
        roundtripBtn.backgroundColor = .PlaceHolderBGColor
        
        multicityBtn.setTitleColor(.SubTitleColor, for: .normal)
        multicityBtn.backgroundColor = .PlaceHolderBGColor
        
        retView.isHidden = true
        onewayBtn.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        onewayBtn.layer.cornerRadius = 20
        onewayBtn.clipsToBounds = true
        
        defaults.set("oneway", forKey: UserDefaultsKeys.journeyType)
    }
    
    func roundtripBtntap() {
        onewayBtn.setTitleColor(.SubTitleColor, for: .normal)
        onewayBtn.backgroundColor = .PlaceHolderBGColor
        roundtripBtn.setTitleColor(.WhiteColor, for: .normal)
        roundtripBtn.backgroundColor = .AppBtnColor
        multicityBtn.setTitleColor(.SubTitleColor, for: .normal)
        multicityBtn.backgroundColor = .PlaceHolderBGColor
        
        retView.isHidden = false
        
        roundtripBtn.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        roundtripBtn.layer.cornerRadius = 20
        roundtripBtn.clipsToBounds = true
        
        defaults.set("circle", forKey: UserDefaultsKeys.journeyType)
    }
    
    func multicityBtntap() {
        onewayBtn.setTitleColor(.SubTitleColor, for: .normal)
        onewayBtn.backgroundColor = .PlaceHolderBGColor
        
        roundtripBtn.setTitleColor(.SubTitleColor, for: .normal)
        roundtripBtn.backgroundColor = .PlaceHolderBGColor
        
        multicityBtn.setTitleColor(.WhiteColor, for: .normal)
        multicityBtn.backgroundColor = .AppBtnColor
        
        defaults.set("multicity", forKey: UserDefaultsKeys.journeyType)
    }
    
    
    
    @objc func didTapOnCloseModifysearch() {
        delegate?.didTapOnCloseModifysearch(cell: self)
    }
    
    
    @IBAction func didTapOnOnewayBtnAction(_ sender: Any) {
        onewayBtntap()
        NotificationCenter.default.post(name: NSNotification.Name("tripreload"), object: nil)
    }
    
    @IBAction func didTapOnRoundtripBtnAction(_ sender: Any) {
        roundtripBtntap()
        NotificationCenter.default.post(name: NSNotification.Name("tripreload"), object: nil)
    }
    
    
    @IBAction func didTapOnMulticityBtnAction(_ sender: Any) {
        multicityBtntap()
        NotificationCenter.default.post(name: NSNotification.Name("tripreload"), object: nil)
    }
    
    @IBAction func didTapOnSelectClassBtnAction(_ sender: Any) {
        //delegate?.didTapOnClassBtnAction(cell: self)
        onewayclassDropdown.show()
    }
    
    @IBAction func didTapOnSearchFlightBtnAction(_ sender: Any) {
        delegate?.didTapOnFlightSearchBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnSelectAirlineBtnAction(_ sender: Any) {
        delegate?.didTapOnSelectAirlineBtnAction(cell: self)
    }
    
    @IBAction func didTapOnFromCityBtnAction(_ sender: Any) {
        delegate?.didTapOnFromCityBtnAction(cell: self)
    }
    
    @IBAction func didTapOnToCityBtnAction(_ sender: Any) {
        delegate?.didTapOnToCityBtnAction(cell: self)
    }
    
    
   
    
}



//MARK: - Adult
extension FlightSearchTVCell {
    
    
    func setupOnewayClassDropDown() {
        onewayclassDropdown.dataSource = selectClassArray
        onewayclassDropdown.direction = .bottom
        onewayclassDropdown.backgroundColor = .WhiteColor
        onewayclassDropdown.anchorView = self.onewayclassView
        onewayclassDropdown.bottomOffset = CGPoint(x: 0, y: onewayclassView.frame.size.height + 10)
        onewayclassDropdown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.classlbl.text = item
            defaults.set(item, forKey: UserDefaultsKeys.selectClass)
            //self?.delegate?.didTapOnClassBtnAction(cell: self!)
        }
    }
    
    
    @objc func didTapOnAdultIncrementBtnAction(_ sender:UIButton) {
        
        // Increment adults, but don't exceed 9 travelers in total
        if (MySingleton.shared.adultsCount + MySingleton.shared.childCount) < 9 {
            MySingleton.shared.adultsCount += 1
            self.adultCountlbl.text = "\(MySingleton.shared.adultsCount)"
        }
        
        updateTotalTravelerCount()
    }
    
    @objc func didTapOnAdultDecrementBtnAction(_ sender:UIButton) {
        
        // Ensure child count doesn't go below 1
        if MySingleton.shared.adultsCount > 1 {
            MySingleton.shared.adultsCount -= 1
            adultCountlbl.text = "\(MySingleton.shared.adultsCount)"
            
            MySingleton.shared.infantsCount = 0
            infantCountlbl.text = "0"
        }
        
        updateTotalTravelerCount()
    }
    
    //MARK: - Child
    @objc func didTapOnChildIncrementBtnAction(_ sender:UIButton) {
        
        // Increment adults and children, but don't exceed 9 travelers in total
        if (MySingleton.shared.adultsCount + MySingleton.shared.childCount) < 9 {
            MySingleton.shared.childCount += 1
            self.childCountlbl.text = "\(MySingleton.shared.childCount)"
        }
        
        updateTotalTravelerCount()
    }
    
    @objc func didTapOnChildDecrementBtnAction(_ sender:UIButton) {
        
        // Ensure adult count doesn't go below 1
        if MySingleton.shared.childCount >= 1 {
            MySingleton.shared.childCount -= 1
            childCountlbl.text = "\(MySingleton.shared.childCount)"
        }
        
        updateTotalTravelerCount()
    }
    
    //MARK: - Infant
    @objc func didTapOnInfantIncrementBtnAction(_ sender:UIButton) {
        
        // Increment infants based on the selected adult count, but don't exceed the selected adult count
        if MySingleton.shared.adultsCount > MySingleton.shared.infantsCount {
            MySingleton.shared.infantsCount += 1
            self.infantCountlbl.text = "\(MySingleton.shared.infantsCount)"
        }
        
        updateTotalTravelerCount()
    }
    
    @objc func didTapOnInfantDecrementBtnAction(_ sender:UIButton) {
        
        // Ensure infant count doesn't go below 1
        if MySingleton.shared.infantsCount >= 1 {
            MySingleton.shared.infantsCount -= 1
            infantCountlbl.text = "\(MySingleton.shared.infantsCount)"
        }
        
        updateTotalTravelerCount()
    }
    
    
    
    
    func updateTotalTravelerCount() {
        
        let totalTravelers = MySingleton.shared.adultsCount + MySingleton.shared.childCount + MySingleton.shared.infantsCount
        print("Total Count === \(totalTravelers)")
        
        defaults.set(totalTravelers, forKey: UserDefaultsKeys.totalTravellerCount)
        defaults.set(MySingleton.shared.adultsCount, forKey: UserDefaultsKeys.adultCount)
        defaults.set(MySingleton.shared.childCount, forKey: UserDefaultsKeys.childCount)
        defaults.set(MySingleton.shared.infantsCount, forKey: UserDefaultsKeys.infantsCount)
        
    }
}


//MARK: - showdepDatePicker   showreturndepDatePicker   showretDatePicker
extension FlightSearchTVCell {
    
    
    
    func showdepDatePicker(){
        //Formate Date
        depDatePicker.datePickerMode = .date
        depDatePicker.minimumDate = Date()
        depDatePicker.preferredDatePickerStyle = .wheels
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        if let calDepDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "") {
            depDatePicker.date = calDepDate
            
            if self.retTF.text == "Select Date" {
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
        
        self.depTF.inputAccessoryView = toolbar
        self.depTF.inputView = depDatePicker
        
    }
    
    
    
    func showreturndepDatePicker(){
        //Formate Date
        retdepDatePicker.datePickerMode = .date
        retdepDatePicker.minimumDate = Date()
        retdepDatePicker.preferredDatePickerStyle = .wheels
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        
        if let rcalDepDate = formter.date(from: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "")  {
            retdepDatePicker.date = rcalDepDate
            
            
            if defaults.string(forKey: UserDefaultsKeys.calRetDate) == nil || self.retTF.text == "Select Date" {
                retdepDatePicker.date = rcalDepDate
            }
        }
        
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        self.depTF.inputAccessoryView = toolbar
        self.depTF.inputView = retdepDatePicker
        
    }
    
    
    
    func showretDatePicker(){
        //Formate Date
        retDatePicker.datePickerMode = .date
        //        retDatePicker.minimumDate = Date()
        // Set minimumDate for retDatePicker based on depDatePicker or retdepDatePicker
        let selectedDate = self.depTF.isFirstResponder ? depDatePicker.date : retdepDatePicker.date
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
                
                if self.retTF.text == "Select Date" {
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
        
        self.retTF.inputAccessoryView = toolbar
        self.retTF.inputView = retDatePicker
        
        
    }
    
    
    @objc func donedatePicker(){
        delegate?.donedatePicker(cell:self)
    }
    
    
    @objc func cancelDatePicker(){
        delegate?.cancelDatePicker(cell:self)
    }
    
}



//MARK: - setAttributedString
extension FlightSearchTVCell {
    
    
    func setAttributedString(str1:String) {
        
        
        let atter1 : [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor:UIColor.AppLabelColor,
                                                      NSAttributedString.Key.font:UIFont.OpenSansMedium(size: 14),
                                                      .underlineStyle: NSUnderlineStyle.single.rawValue]
        
        
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        advanceSearchlbl.attributedText = combination
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        advanceSearchlbl.addGestureRecognizer(tapGesture)
        advanceSearchlbl.isUserInteractionEnabled = true
        
        
    }
    
    @objc func labelTapped(gesture:UITapGestureRecognizer) {
        if gesture.didTapAttributedString("Advanced search options", in: advanceSearchlbl) {
            infoViewbool.toggle()
            if infoViewbool {
                airlineView.isHidden = false
                advanceSearchlbl.textColor = .AppBtnColor
            }else {
                airlineView.isHidden = true
                advanceSearchlbl.textColor = .AppLabelColor
            }
            
            delegate?.didTapOnAdvanceOption(cell: self)
        }
    }
    
    
    
   
    
}
