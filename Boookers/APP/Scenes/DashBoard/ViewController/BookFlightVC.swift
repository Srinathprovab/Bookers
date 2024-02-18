//
//  BookFlightVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 17/08/22.
//

import UIKit

enum SelectCityCategory {
    case from
    case to
    case none
}


class BookFlightVC: BaseTableVC {
    
    
    @IBOutlet weak var holderView: UIView!
    
    
    static var newInstance: BookFlightVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BookFlightVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() {
        
        commonTableView.registerTVCells(["EmptyTVCell",
                                         "SelectTabTVCell",
                                         "LabelTVCell",
                                         "HotelDealsTVCell",
                                         "FlightSearchTVCell",
                                         "AddCityTVCell"])
        
        appendTvcells(str: "oneway")
        
        
    }
    
    
    func appendTvcells(str:String) {
        
        MySingleton.shared.tablerow.removeAll()
        commonTableView.isScrollEnabled = true
        MySingleton.shared.tablerow.append(TableRow(key:"search",cellType:.SelectTabTVCell))
        MySingleton.shared.tablerow.append(TableRow(title:"Book your Flight",
                                                    key:"search",
                                                    cellType:.FlightSearchTVCell))
        MySingleton.shared.tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        commonTVData =  MySingleton.shared.tablerow
        commonTableView.reloadData()
        
    }
    
    
    
    
    @objc func backbtnAction(_ sender:UIButton) {
        callapibool = true
        guard let vc = DBTabbarController.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        present(vc, animated: false)
        
    }
    
    
    override func didTapOnAddTravellerEconomy(cell: AddCityTVCell) {
        gotoAddTravelerVC()
    }
    
    override func didTapOnAddRooms(cell:HolderViewTVCell){
        
    }
    
    
    
    override func didTapOnFromBtn(cell:MulticityFromToTVCell){
        selectCityCategory = SelectCityCategory.from
        gotoSelectCityVC(str: "From", tokey: "Tooo")
    }
    override func didTapOnToBtn(cell:MulticityFromToTVCell){
        selectCityCategory = SelectCityCategory.to
        gotoSelectCityVC(str: "To", tokey: "frommm")
    }
    
    override func didTapOndateBtn(cell:MulticityFromToTVCell){
        // gotoCalenderVC()
        commonTableView.reloadData()
    }
    override func didTapOnCloseBtn(cell:MulticityFromToTVCell){
        print("didTapOnCloseBtn")
    }
    override func didTapOnAddTravellerEconomy(cell:HolderViewTVCell){
        gotoAddTravelerVC()
    }
    
    override func didTapOnMultiCityTripSearchFlight(cell:ButtonTVCell){
        gotoSearchFlightResultVC(input: MySingleton.shared.payload)
    }
    
    override func didTapOnAddTravelerEconomy(){
        gotoAddTravelerVC()
    }
    
    
    
    override func didTapOnMultiCityTripSearchFlight(cell: AddCityTVCell) {
    
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload1.removeAll()
        MySingleton.shared.payload2.removeAll()
        finalInputArray.removeAll()
        for (index,_) in fromCityNameArray.enumerated() {
            
            MySingleton.shared.payload2["from"] = fromCityNameArray[index]
            MySingleton.shared.payload2["from_loc_id"] = fromlocidArray[index]
            MySingleton.shared.payload2["to"] = toCityNameArray[index]
            MySingleton.shared.payload2["to_loc_id"] = tolocidArray[index]
            MySingleton.shared.payload2["depature"] = depatureDatesArray[index]
            
            finalInputArray.append(MySingleton.shared.payload2)
            
        }
        
        MySingleton.shared.payload["sector_type"] = "international"
        MySingleton.shared.payload["trip_type"] = defaults.string(forKey:UserDefaultsKeys.journeyType)
        MySingleton.shared.payload["adult"] = defaults.string(forKey: UserDefaultsKeys.adultCount)
        MySingleton.shared.payload["child"] = defaults.string(forKey: UserDefaultsKeys.childCount)
        MySingleton.shared.payload["infant"] = defaults.string(forKey: UserDefaultsKeys.infantsCount)
        MySingleton.shared.payload["checkbox-group"] = "on"
        MySingleton.shared.payload["search_flight"] = "Search"
        MySingleton.shared.payload["anNonstopflight"] = "1"
        MySingleton.shared.payload["carrier"] = ""
        MySingleton.shared.payload["psscarrier"] = defaults.string(forKey: UserDefaultsKeys.airlinescode)
        MySingleton.shared.payload["remngwd"] = defaults.string(forKey: UserDefaultsKeys.selectClass)
        MySingleton.shared.payload["v_class"] = defaults.string(forKey: UserDefaultsKeys.selectClass)
        MySingleton.shared.payload["user_id"] =  defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        MySingleton.shared.payload["currency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD"
        MySingleton.shared.payload["placeDetails"] = finalInputArray
        
        
        
        var showToastMessage: String? = nil
        
        for cityName in fromCityNameArray {
            if cityName == "From" {
                showToastMessage = "Please Select Origin"
                break
            }
        }
        
        if showToastMessage == nil {
            for cityName in toCityNameArray {
                if cityName == "To" {
                    showToastMessage = "Please Select Destination"
                    break
                }
            }
        }
        
        if showToastMessage == nil {
            for date in depatureDatesArray {
                if date == "Date" {
                    showToastMessage = "Please Select Date"
                    break
                }
            }
        }
        
        
        
        if showToastMessage == nil {
            // Convert date strings to Date objects
            let dateObjects = depatureDatesArray.compactMap { stringToDate($0) }
            
            // Check if dateObjects is in ascending order
            if dateObjects != dateObjects.sorted() {
                showToastMessage = "Please Select Dates in Ascending Order"
            } else if depatureDatesArray.count > 1 && Set(depatureDatesArray).count != depatureDatesArray.count {
                showToastMessage = "Please Select Different Dates"
            }
        }
        
        
        
        if let message = showToastMessage {
            showToast(message: message)
        } else {
            gotoSearchFlightResultVC(input: MySingleton.shared.payload)
        }
        
        
    }
    
    func stringToDate(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.date(from: dateString)
    }
    
    
    
    override func donedatePicker(cell:AddCityTVCell){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy" // Adjust the format as needed
        
        let index = Int(defaults.string(forKey: UserDefaultsKeys.cellTag) ?? "0") ?? 0
        depatureDatesArray[index] = dateFormatter.string(from: cell.depDatePicker.date)
        
        
        NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
        
        
        self.view.endEditing(true)
        
    }
    
    
    
    override func cancelDatePicker(cell:AddCityTVCell){
        self.view.endEditing(true)
    }
    
    
    override func didTapOnSelectAirlineBtnAction(cell:AddCityTVCell){
        gotoNationalityVC()
    }
    
    
    //MARK: - FlightSearchTVCell Delegate Methods
    
    override func donedatePicker(cell: FlightSearchTVCell) {
        
        let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
        if journyType == "oneway" {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            defaults.set(formatter.string(from: cell.depDatePicker.date), forKey: UserDefaultsKeys.calDepDate)
            
        }else {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            defaults.set(formatter.string(from: cell.retdepDatePicker.date), forKey: UserDefaultsKeys.calDepDate)
            defaults.set(formatter.string(from: cell.retDatePicker.date), forKey: UserDefaultsKeys.calRetDate)
        }
        
        commonTableView.reloadData()
        self.view.endEditing(true)
    }
    override func cancelDatePicker(cell: FlightSearchTVCell) {
        self.view.endEditing(true)
    }
    
    
    override func didTapOnFlightSearchBtnAction(cell: FlightSearchTVCell) {
        flightSearchTap()
    }
    
    override func didTapOnFromCityBtnAction(cell:FlightSearchTVCell){
        gotoSelectCityVC(str: "From", tokey: "Tooo")
    }
    override func didTapOnToCityBtnAction(cell:FlightSearchTVCell){
        gotoSelectCityVC(str: "To", tokey: "frommm")
    }
    
    override func didTapOnSelectAirlineBtnAction(cell:FlightSearchTVCell){
        gotoNationalityVC()
    }
    
    
    override func didTapOnClassBtnAction(cell:FlightSearchTVCell){
        gotoAddTravelerVC()
    }
    
    
    override func didTapOnAdvanceOption(cell:FlightSearchTVCell){
        commonTableView.reloadData()
    }
    
    
    
    override func didTapOnBackBtnAction(cell:SelectTabTVCell){
        callapibool = true
        guard let vc = DBTabbarController.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        self.present(vc, animated: false)
    }
}




extension BookFlightVC {
    
    func flightSearchTap() {
        
 
        
        MySingleton.shared.payload.removeAll()
        MySingleton.shared.payload["trip_type"] = defaults.string(forKey: UserDefaultsKeys.journeyType)
        MySingleton.shared.payload["adult"] = defaults.string(forKey: UserDefaultsKeys.adultCount)
        MySingleton.shared.payload["child"] = defaults.string(forKey: UserDefaultsKeys.childCount)
        MySingleton.shared.payload["infant"] = defaults.string(forKey: UserDefaultsKeys.infantsCount)
        MySingleton.shared.payload["from"] = defaults.string(forKey: UserDefaultsKeys.fromCityCode)
        MySingleton.shared.payload["to"] = defaults.string(forKey: UserDefaultsKeys.toCityCode)
        MySingleton.shared.payload["depature"] = defaults.string(forKey: UserDefaultsKeys.calDepDate)
        MySingleton.shared.payload["carrier"] = "ALL"
        MySingleton.shared.payload["v_class"] = defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "Economy"
        MySingleton.shared.payload["search_flight"] = "Search"
//        MySingleton.shared.payload["search_source"] = "Mobile(I)"
//        MySingleton.shared.payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
//        MySingleton.shared.payload["currency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD"
        
        
        let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
        if journyType == "oneway" {
          //  MySingleton.shared.payload["return"] = ""
            
            if defaults.string(forKey:UserDefaultsKeys.fromCity) == "" {
                showToast(message: "Please Select From City")
            }else if defaults.string(forKey:UserDefaultsKeys.toCity) == "" {
                showToast(message: "Please Select To City")
            }else if defaults.string(forKey:UserDefaultsKeys.toCity) == defaults.string(forKey:UserDefaultsKeys.fromCity) {
                showToast(message: "Please Select Different Citys")
            }else if defaults.string(forKey:UserDefaultsKeys.calDepDate) == "" {
                showToast(message: "Please Select Departure Date")
            }else if defaults.string(forKey:UserDefaultsKeys.travellerDetails) == "Add Details" {
                showToast(message: "Add Traveller")
            }else if defaults.string(forKey:UserDefaultsKeys.selectClass) == "Add Details" {
                showToast(message: "Add Class")
            }else if checkDepartureAndReturnDates1(MySingleton.shared.payload, p1: "depature") == false {
                showToast(message: "Invalid Date")
            }else{
                gotoSearchFlightResultVC(input: MySingleton.shared.payload)
            }
            
        }else if journyType == "circle"{
            
          //  MySingleton.shared.payload["return"] = defaults.string(forKey: UserDefaultsKeys.calRetDate)
            let departureDate = defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? ""
            let returnDate = defaults.string(forKey: UserDefaultsKeys.calRetDate) ?? ""
            
            let isDepartureBeforeOrEqual = isDepartureBeforeOrEqualReturn(departureDateString: departureDate, returnDateString: returnDate)
            
            
            if defaults.string(forKey:UserDefaultsKeys.fromCity) == "" {
                showToast(message: "Please Select From City")
            }else if defaults.string(forKey:UserDefaultsKeys.toCity) == "" {
                showToast(message: "Please Select To City")
            }
            //            else if defaults.string(forKey:UserDefaultsKeys.toCity) == defaults.string(forKey:UserDefaultsKeys.fromCity) {
            //                showToast(message: "Please Select Different Citys")
            //            }
            else if defaults.string(forKey:UserDefaultsKeys.calDepDate) == "" {
                showToast(message: "Please Select Departure Date")
            }else if defaults.string(forKey:UserDefaultsKeys.calRetDate) == "" {
                showToast(message: "Please Select Return Date")
            }else if defaults.string(forKey:UserDefaultsKeys.travellerDetails) == "Add Details" {
                showToast(message: "Add Traveller")
            }else if defaults.string(forKey:UserDefaultsKeys.selectClass) == "Add Details" {
                showToast(message: "Add Class")
            }else if isDepartureBeforeOrEqual == false {
                showToast(message: "Invalid Date")
            }else{
                gotoSearchFlightResultVC(input: MySingleton.shared.payload)
            }
            
        }
        
    }
    
    
    
    func gotoNationalityVC(){
        guard let vc = NationalityVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    func gotoSearchFlightResultVC(input:[String:Any]) {
        defaults.set(false, forKey: "flightfilteronce")
        guard let vc = SearchFlightResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        loderBool = true
        callapibool = true
        vc.payload = input
        self.present(vc, animated: true)
    }
    
    
    func gotoSelectCityVC(str:String,tokey:String) {
        guard let vc = SelectFromCityVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.titleStr = str
        vc.keyStr = "flight"
        vc.tokey = tokey
        self.present(vc, animated: true)
    }
    
    func gotoCalenderVC() {
        guard let vc = Calvc.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    func gotoAddTravelerVC() {
        
        guard let vc = TravellerEconomyVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
}



extension BookFlightVC {
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: NSNotification.Name("reload"), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: NSNotification.Name("AdvancedSearchTVCellreload"), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("addcity"), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(tripreload), name: Notification.Name("tripreload"), object: nil)
        
    }
    
    
    
    @objc func tripreload() {
        commonTableView.reloadData()
    }
    
    
    @objc func offline(notificatio:UNNotification) {
        callapibool = true
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    
    @objc func reload(notification: NSNotification){
        commonTableView.reloadData()
    }
}
