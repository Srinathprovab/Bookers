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
    
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var oneWayView: UIView!
    @IBOutlet weak var oneWaylbl: UILabel!
    @IBOutlet weak var oneWayBtn: UIButton!
    @IBOutlet weak var roundTripView: UIView!
    @IBOutlet weak var roundTriplbl: UILabel!
    @IBOutlet weak var roundTripBtn: UIButton!
    @IBOutlet weak var multicityView: UIView!
    @IBOutlet weak var multicitylbl: UILabel!
    @IBOutlet weak var multicityBtn: UIButton!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    @IBOutlet weak var btnsHolderiew: UIStackView!
    
    
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var payload2 = [String:Any]()
    var isVcFrom = String()
    var tablerow = [TableRow]()
   
    
    static var newInstance: BookFlightVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BookFlightVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
       
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: NSNotification.Name("calreloadTV"), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: NSNotification.Name("AdvancedSearchTVCellreload"), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("addcity"), object: nil)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() {
        
        
        self.holderView.backgroundColor = .WhiteColor
        nav.titlelbl.text = "Book Flight"
        nav.backBtn.addTarget(self, action: #selector(backbtnAction(_:)), for: .touchUpInside)
        nav.contentView.backgroundColor = .WhiteColor
        nav.titlelbl.textColor = .AppLabelColor
        nav.backBtn.tintColor = UIColor.AppLabelColor
        
        if screenHeight > 835 {
            navHeight.constant = 140
        }else {
            navHeight.constant = 110
        }
        
        
        btnsHolderiew.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 20)
        buttonsView.backgroundColor = .WhiteColor
        //  setupViews(v: buttonsView, radius: 20, color: .WhiteColor)
        setupViews(v: oneWayView, radius: 18, color: .AppJournyTabSelectColor)
        setupViews(v: roundTripView, radius: 18, color: .WhiteColor)
        setupViews(v: multicityView, radius: 18, color: .WhiteColor)
        //  multicityView.isHidden = true
        
        setupLabels(lbl: oneWaylbl, text: "One Way", textcolor: .WhiteColor, font: .OpenSansRegular(size: 16))
        setupLabels(lbl: roundTriplbl, text: "Round Trip", textcolor: .SubTitleColor, font: .OpenSansRegular(size: 16))
        setupLabels(lbl: multicitylbl, text: "Multicity", textcolor: .SubTitleColor, font: .OpenSansRegular(size: 16))
        
        
        oneWayBtn.setTitle("", for: .normal)
        roundTripBtn.setTitle("", for: .normal)
        multicityBtn.setTitle("", for: .normal)
        
        commonTableView.registerTVCells(["EmptyTVCell",
                                         "SearchFlightTVCell",
                                         "LabelTVCell",
                                         "HotelDealsTVCell",
                                         "AddCityTVCell"])
        
        appendTvcells(str: "oneway")
        if let selectedJourneyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if selectedJourneyType == "multicity" {
                setupMulticity()
            }else if selectedJourneyType == "circle" {
                setupRoundTrip()
            }else {
                setupOneWay()
            }
        }
        
        
        
    }
    
    
    func appendTvcells(str:String) {
        
        tablerow.removeAll()
        commonTableView.isScrollEnabled = false
        tablerow.append(TableRow(key:str,cellType:.SearchFlightTVCell))
        //   tablerow.append(TableRow(height:10,bgColor: .AppBGcolor,cellType:.EmptyTVCell))
        //        tablerow.append(TableRow(title:"Best Deals Flights",key: "deals",cellType:.LabelTVCell))
        //        tablerow.append(TableRow(height:10,bgColor: .AppBGcolor,cellType:.EmptyTVCell))
        //        tablerow.append(TableRow(key1:"flight",cellType:.HotelDealsTVCell))
        //        tablerow.append(TableRow(height:30,bgColor: .AppBGcolor,cellType:.EmptyTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    
    func appendMulticityTvcells() {
        tablerow.removeAll()
        
        //   tablerow.append(TableRow(cellType:.NewMulticityTVCell))
        tablerow.append(TableRow(cellType:.AddCityTVCell))
        //    tablerow.append(TableRow(height:10,bgColor: .AppBGcolor,cellType:.EmptyTVCell))
        //        tablerow.append(TableRow(title:"Flight ",subTitle: "Popular International Flights From Kuwait",key: "deals",cellType:.LabelTVCell))
        //        tablerow.append(TableRow(height:18,bgColor: .AppBGcolor,cellType:.EmptyTVCell))
        //        tablerow.append(TableRow(key1:"flight",cellType:.HotelDealsTVCell))
        //        tablerow.append(TableRow(height:30,bgColor: .AppBGcolor,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    
    @objc func backbtnAction(_ sender:UIButton) {
        callapibool = true
        guard let vc = DBTabbarController.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        present(vc, animated: false)
        
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.2
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    @IBAction func didTapOnOneWayBtn(_ sender: Any) {
        setupOneWay()
    }
    
    @IBAction func didTapOnRoundTripBtn(_ sender: Any) {
        setupRoundTrip()
    }
    
    
    @IBAction func didTapOnMulticityBtn(_ sender: Any) {
        setupMulticity()
    }
    
    func setupOneWay() {
        oneWaylbl.textColor = .WhiteColor
        roundTriplbl.textColor = .SubTitleColor
        multicitylbl.textColor = .SubTitleColor
        
        oneWayView.backgroundColor = .AppJournyTabSelectColor
        roundTripView.backgroundColor = .WhiteColor
        multicityView.backgroundColor = .WhiteColor
        
        defaults.set("oneway", forKey: UserDefaultsKeys.journeyType)
        appendTvcells(str: "oneway")
    }
    
    
    func setupRoundTrip() {
        oneWaylbl.textColor = .SubTitleColor
        roundTriplbl.textColor = .WhiteColor
        multicitylbl.textColor = .SubTitleColor
        
        oneWayView.backgroundColor = .WhiteColor
        roundTripView.backgroundColor = .AppJournyTabSelectColor
        multicityView.backgroundColor = .WhiteColor
        
        defaults.set("circle", forKey: UserDefaultsKeys.journeyType)
        NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
        appendTvcells(str: "roundtrip")
    }
    
    
    func setupMulticity() {
        oneWaylbl.textColor = .SubTitleColor
        roundTriplbl.textColor = .SubTitleColor
        multicitylbl.textColor = .WhiteColor
        
        oneWayView.backgroundColor = .WhiteColor
        roundTripView.backgroundColor = .WhiteColor
        multicityView.backgroundColor = .AppJournyTabSelectColor
        
        defaults.set("multicity", forKey: UserDefaultsKeys.journeyType)
        appendMulticityTvcells()
    }
    
    
    
    override func didTapOnAddTravellerEconomy(cell: AddCityTVCell) {
        gotoAddTravelerVC()
    }
    
    
    override func didTapOnFromCity(cell: HolderViewTVCell) {
        gotoSelectCityVC(str: "From", tokey: "Tooo")
    }
    
    override func didTapOnToCity(cell: HolderViewTVCell) {
        gotoSelectCityVC(str: "To", tokey: "frommm")
    }
    
    override func didTapOnSelectDepDateBtn(cell: DualViewTVCell) {
        gotoCalenderVC()
    }
    override func didTapOnSelectRepDateBtn(cell: DualViewTVCell) {
        gotoCalenderVC()
    }
    
    
    override func didTapOnSelectAirlines(){
        gotoNationalityVC()
    }
    
    
    override func didTapOnAddRooms(cell:HolderViewTVCell){
        
    }
    
    
    override func didTapOnSearchFlightsBtn(cell:SearchFlightTVCell) {
        
        payload.removeAll()
        payload["trip_type"] = defaults.string(forKey: UserDefaultsKeys.journeyType)
        payload["adult"] = defaults.string(forKey: UserDefaultsKeys.adultCount)
        payload["child"] = defaults.string(forKey: UserDefaultsKeys.childCount)
        payload["infant"] = defaults.string(forKey: UserDefaultsKeys.infantsCount)
        payload["sector_type"] = "international"
        payload["from"] = defaults.string(forKey: UserDefaultsKeys.fromCity)
        payload["from_loc_id"] = defaults.string(forKey: UserDefaultsKeys.fromlocid)
        payload["to"] = defaults.string(forKey: UserDefaultsKeys.toCity)
        payload["to_loc_id"] = defaults.string(forKey: UserDefaultsKeys.tolocid)
        payload["depature"] = defaults.string(forKey: UserDefaultsKeys.calDepDate)
        payload["carrier"] = ""
        payload["psscarrier"] = defaults.string(forKey: UserDefaultsKeys.airlinescode)
        payload["v_class"] = defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "Economy"
        payload["search_flight"] = "Search"
        payload["search_source"] = "Mobile(I)"
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        payload["currency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD"
        
        
        let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
        if journyType == "oneway" {
            payload["return"] = ""
            
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
            }else if checkDepartureAndReturnDates1(payload, p1: "depature") == false {
                showToast(message: "Invalid Date")
            }else{
                gotoSearchFlightResultVC(input: payload)
            }
            
        }else if journyType == "circle"{
            
            payload["return"] = defaults.string(forKey: UserDefaultsKeys.calRetDate)
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
                gotoSearchFlightResultVC(input: payload)
            }
            
        }
        
        
        
        
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
        gotoSearchFlightResultVC(input: payload)
    }
    
    override func didTapOnAddTravelerEconomy(){
        gotoAddTravelerVC()
    }
    
    
    
    override func didTapOnMultiCityTripSearchFlight(cell: AddCityTVCell) {
        
        payload.removeAll()
        payload1.removeAll()
        payload2.removeAll()
        finalInputArray.removeAll()
        for (index,_) in fromCityNameArray.enumerated() {
            
            payload2["from"] = fromCityNameArray[index]
            payload2["from_loc_id"] = fromlocidArray[index]
            payload2["to"] = toCityNameArray[index]
            payload2["to_loc_id"] = tolocidArray[index]
            payload2["depature"] = depatureDatesArray[index]
            
            finalInputArray.append(payload2)
            
        }
        
        payload["sector_type"] = "international"
        payload["trip_type"] = defaults.string(forKey:UserDefaultsKeys.journeyType)
        payload["adult"] = defaults.string(forKey: UserDefaultsKeys.adultCount)
        payload["child"] = defaults.string(forKey: UserDefaultsKeys.childCount)
        payload["infant"] = defaults.string(forKey: UserDefaultsKeys.infantsCount)
        payload["checkbox-group"] = "on"
        payload["search_flight"] = "Search"
        payload["anNonstopflight"] = "1"
        payload["carrier"] = ""
        payload["psscarrier"] = defaults.string(forKey: UserDefaultsKeys.airlinescode)
        payload["remngwd"] = defaults.string(forKey: UserDefaultsKeys.selectClass)
        payload["v_class"] = defaults.string(forKey: UserDefaultsKeys.selectClass)
        payload["user_id"] =  defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        payload["currency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD"
        payload["placeDetails"] = finalInputArray
        
        
        
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
            gotoSearchFlightResultVC(input: payload)
        }
        
        
    }
    
    func stringToDate(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.date(from: dateString)
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
    
    
    
    func gotoNationalityVC(){
        guard let vc = NationalityVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    override func donedatePicker(cell:SearchFlightTVCell){
        
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
    
    override func cancelDatePicker(cell:SearchFlightTVCell){
        self.view.endEditing(true)
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
    
    
    
    
}
