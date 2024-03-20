//
//  SelectedFlightInfoVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 18/08/22.
//

import UIKit

class SelectedFlightInfoVC: BaseTableVC, FlightDetailsViewModelDelegate, TimerManagerDelegate {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var cvHolderView: UIView!
    @IBOutlet weak var itineraryCV: UICollectionView!
    @IBOutlet weak var bookNowHolderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var bookNowView: UIView!
    @IBOutlet weak var bookNowlbl: UILabel!
    @IBOutlet weak var bookNowBtn: UIButton!
    
    static var newInstance: SelectedFlightInfoVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SelectedFlightInfoVC
        return vc
    }
    
    
    var journysummery  = [Summary]()
    var adult_sub_total = Double()
    var child_sub_total = Double()
    var infant_sub_total = Double()
    
    var adult_total = Double()
    var child_total = Double()
    var infant_total = Double()
    
    var currency = String()
    var totaltripcost = String()
    var isVcFrom = String()
    var itineraryArray = ["Itinerary","Fare Breakdown","Fare Rules","Baggage Info"]
    var city = String()
    var date = String()
    var tablerow = [TableRow]()
    var cellIndex = Int()
    var paxwise_price:Paxwise_price?
  
    var payload = [String:Any]()
    var vm:FlightDetailsViewModel?
    override func viewWillAppear(_ animated: Bool) {
        
        addObserver()
        
        if  callapibool == true {
            
            holderView.isHidden = true
            callAPI()
            
        }
        
    }
    
    
    
    func callAPI() {
        payload.removeAll()
       
        payload["access_key"] = accesskey
        payload["booking_source"] = bookingsource
        payload["search_id"] = searchid
        
        vm?.CALL_GET_FLIGHT_DETAILS_API(dictParam: payload)
    }
    
    
    
    func flightDetails(response: FlightDetailsModel) {
        
        holderView.isHidden = false
        fd = response.flight_details
        journysummery = response.flight_details?.summary ?? []
        let doubleStr = String(format: "%.2f", response.price?.api_total_display_fare ?? 0.0)
        grandTotal = "\(response.price?.api_currency ?? ""):\(doubleStr)"
        newGrandTotal = "\(response.price?.api_currency ?? ""):\(doubleStr)"
        self.bookNowlbl.text = grandTotal
        paxwise_price = response.paxwise_price
        currency = response.price?.api_currency ?? ""
        totaltripcost = doubleStr
        

        
        accesskey = response.access_key ?? ""
        bookingsource = response.booking_source ?? ""
        searchid = response.search_id ?? ""
        
        
        DispatchQueue.main.async {
            self.setupUI()
        }
       
        
    }
    
    func addPaxValues(v1:Double,v2:Double) -> Double {
        return v1 + v2
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .WhiteColor
        TimerManager.shared.delegate = self
        vm = FlightDetailsViewModel(self)
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .AppHolderViewColor
        cvHolderView.backgroundColor = .clear
        commonTableView.backgroundColor = .AppHolderViewColor
        
        setupCV()
        cellIndex = Int(defaults.string(forKey: UserDefaultsKeys.itinerarySelectedIndex) ?? "0") ?? 0
        print("cellIndex \(cellIndex)")
        itineraryCV.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .left)
        setupViews(v: bookNowView, radius: 6, color: .AppNavBackColor)
        titlelbl.text = grandTotal
        setupLabels(lbl: bookNowlbl, text: "BOOK NOW", textcolor: .WhiteColor, font: .OpenSansRegular(size: 16))
        bookNowBtn.setTitle("", for: .normal)
        
        commonTableView.registerTVCells(["AddItineraryTVCell",
                                         "EmptyTVCell",
                                         "TitleLblTVCell",
                                         "FareBreakdownTVCell",
                                         "BaggageInfoTVCell",
                                         "FareRulesTVCell",
                                         "RadioButtonTVCell"])
        
        
        
        setupItineraryTVCells()
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
    
    func setupCV() {
        let nib = UINib(nibName: "ItineraryCVCell", bundle: nil)
        itineraryCV.register(nib, forCellWithReuseIdentifier: "cell")
        itineraryCV.delegate = self
        itineraryCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        // layout.itemSize = CGSize(width: 100, height: 40)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        itineraryCV.collectionViewLayout = layout
        itineraryCV.backgroundColor = .clear
        itineraryCV.layer.cornerRadius = 4
        itineraryCV.clipsToBounds = true
        itineraryCV.showsHorizontalScrollIndicator = false
        itineraryCV.bounces = false
        
    }
    
    @objc func gotoBackScreen() {
        NotificationCenter.default.post(name: NSNotification.Name("reloadTimer"), object: nil)
        callapibool = false
        dismiss(animated: true)
        
        // searchFlightAgain()
        
    }
    
    func setupItineraryTVCells() {
        tablerow.removeAll()
        
        
        fd?.details?.enumerated().forEach { (index, element) in
            tablerow.append(TableRow(title:"\(index)",moreData: element, cellType: .AddItineraryTVCell))
        }
        
        
        
        tablerow.append(TableRow(height:50,bgColor: .AppHolderViewColor,cellType:.EmptyTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    @IBAction func didTapOnBookNowBtn(_ sender: Any) {
//        guard let vc = PayNowVC.newInstance.self else {return}
//        vc.modalPresentationStyle = .overCurrentContext
//        self.present(vc, animated: true)
        
        
        showToast(message: "Still Work Is Going On...")
    }
    
    
    
    func setupFareBreakdownTVCells() {
        
        tablerow.removeAll()
        
        
        
        if (paxwise_price?.adult_pax_count ?? 0) > 0 && (paxwise_price?.child_pax_count ?? 0) == 0 && (paxwise_price?.infant_pax_count ?? 0) == 0 {
            tablerow.append(TableRow(title:"Adult",
                                     subTitle: "X\(String(paxwise_price?.adult_pax_count ?? 0))",
                                     key:currency,
                                     text: "\(String(format: "%.2f", paxwise_price?.adult_base_fare ?? 0.0))",
                                     headerText: "\(String(format: "%.2f", paxwise_price?.adult_total_fare ?? 0.0))",
                                     buttonTitle:"\(String(format: "%.2f", paxwise_price?.adult_sub_fare ?? 0.0))",
                                     tempText: "\(String(format: "%.2f", paxwise_price?.adult_tax_fare ?? 0.0))",
                                     cellType:.FareBreakdownTVCell))
            
        }else  if (paxwise_price?.adult_pax_count ?? 0) > 0 && (paxwise_price?.child_pax_count ?? 0) > 0 && (paxwise_price?.infant_pax_count ?? 0) == 0 {
            tablerow.append(TableRow(title:"Adult",
                                     subTitle: "X\(String(paxwise_price?.adult_pax_count ?? 0))",
                                     key:currency,
                                     text: "\(String(format: "%.2f", paxwise_price?.adult_base_fare ?? 0.0))",
                                     headerText: "\(String(format: "%.2f", paxwise_price?.adult_total_fare ?? 0.0))",
                                     buttonTitle:"\(String(format: "%.2f", paxwise_price?.adult_sub_fare ?? 0.0))",
                                     tempText: "\(String(format: "%.2f", paxwise_price?.adult_tax_fare ?? 0.0))",
                                     cellType:.FareBreakdownTVCell))
            
            tablerow.append(TableRow(title:"Child",
                                     subTitle: "X\(String(paxwise_price?.child_pax_count ?? 0))",
                                     key:currency,
                                     text: "\(String(format: "%.2f", paxwise_price?.child_base_fare ?? 0.0))",
                                     headerText: "\(String(format: "%.2f", paxwise_price?.child_total_fare ?? 0.0))",
                                     buttonTitle:"\(String(format: "%.2f", paxwise_price?.child_sub_fare ?? 0.0))",
                                     tempText: "\(String(format: "%.2f", paxwise_price?.child_tax_fare ?? 0.0))",
                                     cellType:.FareBreakdownTVCell))
            
        }else if (paxwise_price?.adult_pax_count ?? 0) > 0 && (paxwise_price?.child_pax_count ?? 0) == 0 && (paxwise_price?.infant_pax_count ?? 0) > 0 {
            tablerow.append(TableRow(title:"Adult",
                                     subTitle: "X\(String(paxwise_price?.adult_pax_count ?? 0))",
                                     key:currency,
                                     text: "\(String(format: "%.2f", paxwise_price?.adult_base_fare ?? 0.0))",
                                     headerText: "\(String(format: "%.2f", paxwise_price?.adult_total_fare ?? 0.0))",
                                     buttonTitle:"\(String(format: "%.2f", paxwise_price?.adult_sub_fare ?? 0.0))",
                                     tempText: "\(String(format: "%.2f", paxwise_price?.adult_tax_fare ?? 0.0))",
                                     cellType:.FareBreakdownTVCell))
            
            tablerow.append(TableRow(title:"Infanta",
                                     subTitle: "X\(String(paxwise_price?.infant_pax_count ?? 0))",
                                     key:currency,
                                     text: "\(String(format: "%.2f", paxwise_price?.infant_base_fare ?? 0.0))",
                                     headerText: "\(String(format: "%.2f", paxwise_price?.infant_total_fare ?? 0.0))",
                                     buttonTitle:"\(String(format: "%.2f", paxwise_price?.infant_sub_fare ?? 0.0))",
                                     tempText: "\(String(format: "%.2f", paxwise_price?.infant_tax_fare ?? 0.0))",
                                     cellType:.FareBreakdownTVCell))
        }else {
            tablerow.append(TableRow(title:"Adult",
                                     subTitle: "X\(String(paxwise_price?.adult_pax_count ?? 0))",
                                     key:currency,
                                     text: "\(String(format: "%.2f", paxwise_price?.adult_base_fare ?? 0.0))",
                                     headerText: "\(String(format: "%.2f", paxwise_price?.adult_total_fare ?? 0.0))",
                                     buttonTitle:"\(String(format: "%.2f", paxwise_price?.adult_sub_fare ?? 0.0))",
                                     tempText: "\(String(format: "%.2f", paxwise_price?.adult_tax_fare ?? 0.0))",
                                     cellType:.FareBreakdownTVCell))
            
            tablerow.append(TableRow(title:"Child",
                                     subTitle: "X\(String(paxwise_price?.child_pax_count ?? 0))",
                                     key:currency,
                                     text: "\(String(format: "%.2f", paxwise_price?.child_base_fare ?? 0.0))",
                                     headerText: "\(String(format: "%.2f", paxwise_price?.child_total_fare ?? 0.0))",
                                     buttonTitle:"\(String(format: "%.2f", paxwise_price?.child_sub_fare ?? 0.0))",
                                     tempText: "\(String(format: "%.2f", paxwise_price?.child_tax_fare ?? 0.0))",
                                     cellType:.FareBreakdownTVCell))
            
            tablerow.append(TableRow(title:"Infanta",
                                     subTitle: "X\(String(paxwise_price?.infant_pax_count ?? 0))",
                                     key:currency,
                                     text: "\(String(format: "%.2f", paxwise_price?.infant_base_fare ?? 0.0))",
                                     headerText: "\(String(format: "%.2f", paxwise_price?.infant_total_fare ?? 0.0))",
                                     buttonTitle:"\(String(format: "%.2f", paxwise_price?.infant_sub_fare ?? 0.0))",
                                     tempText: "\(String(format: "%.2f", paxwise_price?.infant_tax_fare ?? 0.0))",
                                     cellType:.FareBreakdownTVCell))
        }
        
        
        tablerow.append(TableRow(title:"Total Trip Cost",subTitle: totaltripcost,key: "totalcost",cellType:.TitleLblTVCell))
        tablerow.append(TableRow(height:50,bgColor: .AppHolderViewColor,cellType:.EmptyTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    func setupFareRulesTVCells() {
        self.commonTableView.estimatedRowHeight = 500
        self.commonTableView.rowHeight = 40
        
        tablerow.removeAll()
        
//        if fareRulesData.count == 0 {
//            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
//        }else {
//            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
//            
//            self.fareRulesData.forEach { i in
//                tablerow.append(TableRow(title:i.rule_heading,subTitle: i.rule_content?.htmlToString,cellType:.FareRulesTVCell))
//            }
//        }
        
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    
    func setupBaggageInfoTVCells() {
        tablerow.removeAll()
        
            tablerow.append(TableRow(cellType:.BaggageInfoTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        callapibool = false
        dismiss(animated: true)
    }
    
    
    
}



extension SelectedFlightInfoVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itineraryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ItineraryCVCell {
            cell.titlelbl.text = itineraryArray[indexPath.row]
            if indexPath.row == 0 {
                cell.holderView.backgroundColor = .WhiteColor
                cell.titlelbl.textColor = .AppLabelColor
            }
            commonCell = cell
        }
        return commonCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ItineraryCVCell {
            cell.holderView.backgroundColor = .WhiteColor
            cell.titlelbl.textColor = .AppLabelColor
            defaults.set(indexPath.row, forKey: UserDefaultsKeys.itinerarySelectedIndex)
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
            
            switch cell.titlelbl.text {
            case "Itinerary":
                setupItineraryTVCells()
                break
                
            case "Fare Breakdown":
                setupFareBreakdownTVCells()
                break
                
            case "Fare Rules":
                setupFareRulesTVCells()
                break
                
            case "Baggage Info":
                setupBaggageInfoTVCells()
                break
                
            default:
                break
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ItineraryCVCell {
            cell.holderView.backgroundColor = .WhiteColor.withAlphaComponent(0.50)
            cell.titlelbl.textColor = .WhiteColor
        }
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: itineraryArray[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]).width + 25, height: 40)
    }
    
}

extension SelectedFlightInfoVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FareRulesTVCell {
            if cell.showBool == true {
                cell.show()
                cell.showBool = false
            }else {
                cell.hide()
                cell.showBool = true
            }
        }
        
        commonTableView.beginUpdates()
        commonTableView.endUpdates()
    }
    
}




extension SelectedFlightInfoVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name("reloadTV"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTimer), name: NSNotification.Name("reloadTimer"), object: nil)
        
    }
    
    
    @objc func reloadTimer(){
        // TimerManager.shared.delegate = self
    }
    
    @objc func nointernet(){
        gotoNoInternetConnectionVC(key: "nointernet", titleStr: "")
    }
    
    @objc func resultnil(){
        gotoNoInternetConnectionVC(key: "noresult", titleStr: "NO AVAILABILITY FOR THIS REQUEST")
    }
    
    @objc func reload(){
        callAPI()
    }
    
    
    func gotoNoInternetConnectionVC(key:String,titleStr:String) {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = key
        vc.titleStr = titleStr
        self.present(vc, animated: false)
    }
    
    
    func timerDidFinish() {
        guard let vc = PopupVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    func updateTimer() {
        
    }
    
    
    
    
    
}


extension SelectedFlightInfoVC {
    
    
    func searchFlightAgain() {
        
        
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
        payload["search_source"] = "search"
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        payload["currency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD"
        let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
        if journyType == "oneway" {
            payload["return"] = ""
            
        }else if journyType == "circle"{
            payload["return"] = defaults.string(forKey: UserDefaultsKeys.calRetDate)
        }
        
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
        
        
        
    }
    
    func gotoSearchFlightResultVC(input:[String:Any]) {
        defaults.set(false, forKey: "flightfilteronce")
        guard let vc = SearchFlightResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        loderBool = true
        callapibool = true
        vc.payload = input
       // self.present(vc, animated: false)
    }
    
    
    
    
}

