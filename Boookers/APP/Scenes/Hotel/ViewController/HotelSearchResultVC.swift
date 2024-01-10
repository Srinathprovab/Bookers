//
//  HotelSearchResultVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 22/08/22.
//

import UIKit



class HotelSearchResultVC: BaseTableVC,HotelListViewModelDelegate, TimerManagerDelegate {
    
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var mapImg: UIImageView!
    @IBOutlet weak var mapBtn: UIButton!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterImg: UIImageView!
    @IBOutlet weak var filterpBtn: UIButton!
    
    
    
    var isLoadingData: Bool = false
    var isSearchBool = false
    var nationalityCode = String()
    var viewModel:HotelListViewModel?
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var hotelSearchResultArray = [HotelSearchResult]()
    var filtered = [HotelSearchResult]()
    var isVcFrom = String()
    var tablerow = [TableRow]()
    let refreshControl = UIRefreshControl()
    
    
    static var newInstance: HotelSearchResultVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? HotelSearchResultVC
        return vc
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        TimerManager.shared.delegate = self
        addObserver()
        
        if callapibool == true {
            holderView.isHidden = true
            CallAPI()
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        viewModel = HotelListViewModel(self)
    }
    
    func setupUI() {
        
        self.holderView.backgroundColor = .AppHolderViewColor
        nav.titlelbl.text = "Search Result"
        nav.backBtn.addTarget(self, action: #selector(backbtnAction(_:)), for: .touchUpInside)
        nav.citylbl.isHidden = false
        nav.datelbl.isHidden = false
        nav.travellerlbl.isHidden = false
        nav.editView.isHidden = false
        nav.editBtn.addTarget(self, action: #selector(modifySearchHotel(_:)), for: .touchUpInside)
        nav.citylbl.text = "\(defaults.string(forKey: UserDefaultsKeys.locationcity) ?? "")"
        nav.datelbl.text = "CheckIn - \(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.checkin) ?? "" , f1: "dd-MM-yyyy", f2: "dd MMM")) & CheckOut - \(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.checkout) ?? "", f1: "dd-MM-yyyy", f2: "dd MMM"))"
        nav.travellerlbl.text = "Guests- \(defaults.string(forKey: UserDefaultsKeys.guestcount) ?? "1") / Room - \(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? "")"
        
        
        if screenHeight > 835 {
            navHeight.constant = 190
        }else {
            navHeight.constant = 160
        }
        
        
        
        setupViews(v: mapView, radius: 4, color: .AppJournyTabSelectColor)
        setupViews(v: filterView, radius: 4, color: .AppNavBackColor)
        mapImg.image = UIImage(named: "loc")
        filterImg.image = UIImage(named: "filter")
        mapBtn.setTitle("", for: .normal)
        filterpBtn.setTitle("", for: .normal)
        mapBtn.addTarget(self, action: #selector(didTapOnMapviewBtn(_:)), for: .touchUpInside)
        filterpBtn.addTarget(self, action: #selector(didTapOnFilterwBtn(_:)), for: .touchUpInside)
        

        commonTableView.registerTVCells(["EmptyTVCell",
                                         "HotelSearchResultTVCell"])
        
        
        
    }
    
  
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.2
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    @objc func modifySearchHotel(_ sender:UIButton) {
        guard let vc = ModifyHotelSearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    
    @objc func backbtnAction(_ sender:UIButton) {
        TimerManager.shared.sessionStop()
        guard let vc = BookHotelVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = false
        self.present(vc, animated: false)
    }
    
    @objc func didTapOnMapviewBtn(_ sender:UIButton) {
        guard let vc = MapViewVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    @objc func didTapOnFilterwBtn(_ sender:UIButton) {
        guard let vc = FilterSearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        vc.filterTapKey = "sort"
        self.present(vc, animated: false)
    }
    
    
    override func didTapOnDetailsBtn(cell: HotelSearchResultTVCell) {
        guard let vc = SelectedHotelInfoVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        hotelid = cell.hotelid
        grandTotal = cell.kwdlbl.text ?? ""
        defaults.set(cell.kwdlbl.text, forKey: UserDefaultsKeys.kwdprice)
        callapibool = true
        self.present(vc, animated: false)
    }
    
}


extension HotelSearchResultVC {
    
    
    func CallAPI() {
        
        holderView.isHidden = true
        
        do {
            
            let arrJson = try JSONSerialization.data(withJSONObject: payload, options: JSONSerialization.WritingOptions.prettyPrinted)
            let theJSONText = NSString(data: arrJson, encoding: String.Encoding.utf8.rawValue)
            print(theJSONText ?? "")
            payload1["search_params"] = theJSONText
            payload1["limit"] = "10"
            payload1["offset"] = "0"
            viewModel?.CALL_GET_HOTEL_LIST_API(dictParam: payload1)
            
        }catch let error as NSError{
            print(error.description)
        }
        
    }
    
    
    func hotelList(response: HotelListModel) {
        
        if response.status == 1 {
            
            holderView.isHidden = false
            hbooking_source = response.booking_source ?? ""
            hsearch_id = String(response.search_id ?? 0)
        
            TimerManager.shared.stopTimer()
            TimerManager.shared.startTimer(time: 900)
            hotelSearchResultArray = response.data?.hotelSearchResult ?? []
            appendValues(list: hotelSearchResultArray)

            response.filters_display?.loc?.forEach({ i in
                nearBylocationsArray.append(i.v ?? "")
            })
            
            response.filters_display?.a_type?.forEach({ i in
                neighbourwoodArray.append(i.v ?? "")
            })
            
            response.filters_display?.facility?.forEach({ i in
                amenitiesArray.append(i.v ?? "")
            })
            
           
            
        }else {
            
            
            callapibool = true
            guard let vc = NoInternetConnectionVC.newInstance.self else {return}
            vc.modalPresentationStyle = .fullScreen
            vc.key = "noresult"
            self.present(vc, animated: false)
        }
        
    }
    
    
    
    func appendValues(list:[HotelSearchResult]) {
        
        
        prices.removeAll()
        latitudeArray.removeAll()
        longitudeArray.removeAll()
        facilityArray.removeAll()
        faretypeArray .removeAll()
        
        
        list.forEach { i in
            prices.append("\(i.price ?? "")")
            latitudeArray.append(i.latitude ?? "")
            longitudeArray.append(i.longitude ?? "0.0")
            faretypeArray.append(i.refund ?? "")
            i.facility?.forEach({ j in
                facilityArray.append(j.name ?? "")
            })
        }
        prices = Array(Set(prices))
        facilityArray = Array(Set(facilityArray))
        faretypeArray = Array(Set(faretypeArray))
        
        list.forEach { i in
            let mapModel = MapModel(
                longitude: i.longitude ?? "",
                latitude: i.latitude ?? "",
                hotelname: i.name ?? ""
            )
            mapModelArray.append(mapModel)
        }
        
        
        DispatchQueue.main.async {
            self.setupTVCells(hotelList: list)
        }
        
    }
    
}


extension HotelSearchResultVC:AppliedFilters {
    
    
    func hotelFilterByApplied(minpricerange: Double, maxpricerange: Double, starRating: String, refundableTypeArray: [String], nearByLocA: [String], niberhoodA: [String], aminitiesA: [String]) {
        
        
        isSearchBool = true
        
        print("====minpricerange ==== \(minpricerange)")
        print("====maxpricerange ==== \(maxpricerange)")
        print(" ==== starRating === \(starRating)")
        print(" ==== refundableTypeArray === \n\(refundableTypeArray)")
        print(" ==== nearByLocA === \n\(nearByLocA)")
        print(" ==== niberhoodA === \n\(niberhoodA)")
        print(" ==== aminitiesA === \n\(aminitiesA)")
        
        
        
        let filteredArray = hotelSearchResultArray.filter { hotel in
            guard let netPrice = Double(hotel.price ?? "0.0") else { return false }
            
            let ratingMatches = hotel.star_rating == Int(starRating) || starRating.isEmpty
            let refundableMatch = refundableTypeArray.isEmpty || refundableTypeArray.contains(hotel.refund ?? "")
            let nearByLocMatch = nearByLocA.isEmpty || nearByLocA.contains(hotel.location ?? "")

            
            let facilityMatch = aminitiesA.isEmpty || aminitiesA.allSatisfy { desiredAmenity in
                hotel.facility?.contains { facility in
                    let facilityName = facility.name?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() ?? ""
                    return facilityName == desiredAmenity.lowercased()
                } ?? false
            }


            return ratingMatches && netPrice >= minpricerange && netPrice <= maxpricerange && refundableMatch && facilityMatch && nearByLocMatch
            
            
        }

        
        
        
        
        filtered = filteredArray
        if filtered.count == 0{
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
        }else {
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
        }
        
        DispatchQueue.main.async {[self] in
            setupTVCells(hotelList: filtered)
        }
    }
    
    
    
    func filtersSortByApplied(sortBy: SortParameter) {
        
        
        
        
        switch sortBy {
        case .PriceLow:
            
            let sortedByPriceLowToHigh = hotelSearchResultArray.sorted { hotel1, hotel2 in
                return (Double(hotel1.price ?? "") ?? 0.0) < (Double(hotel2.price ?? "") ?? 0.0)
            }
          
            setupTVCells(hotelList: sortedByPriceLowToHigh)
            break
            
        case .PriceHigh:
            
            let sortedByPriceLowToHigh = hotelSearchResultArray.sorted { hotel1, hotel2 in
                return (Double(hotel1.price ?? "") ?? 0.0) > (Double(hotel2.price ?? "") ?? 0.0)
            }
            setupTVCells(hotelList: sortedByPriceLowToHigh)
            break
            
            
            
        case .hotelaz:
            // Sort hotel names alphabetically
            let sortedByNameAZ = hotelSearchResultArray.sorted { $0.name?.localizedCaseInsensitiveCompare($1.name ?? "") == .orderedAscending }
            setupTVCells(hotelList: sortedByNameAZ)
            break
            
        case .hotelza:
            // Sort hotel names alphabetically
            let sortedByNameAZ = hotelSearchResultArray.sorted { $0.name?.localizedCaseInsensitiveCompare($1.name ?? "") == .orderedDescending }
            setupTVCells(hotelList: sortedByNameAZ)
            break
            
            
            
            
        case .nothing:
            setupTVCells(hotelList: hotelSearchResultArray)
            break
            
        default:
            break
        }
        
        DispatchQueue.main.async {[self] in
            // commonTableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        }
        
    }
    
    func filterByApplied(minpricerange: Double, maxpricerange: Double, noofstopsFA: [String], departureTimeFilter: [String], arrivalTimeFilter: [String], airlinesFA: [String], cancellationTypeFA: [String], connectingFlightsFA: [String], connectingAirportsFA: [String]) {
        
    }
    
    
    
    
    
    
    func setupTVCells(hotelList:[HotelSearchResult]) {
        
        
        if hotelList.count == 0 {
            tablerow.removeAll()
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
            commonTVData = tablerow
            commonTableView.reloadData()
        }else {
            tablerow.removeAll()
            setupLabels(lbl: subtitlelbl, text: "\(hotelList.count) Hotels Found", textcolor: .WhiteColor, font: .OpenSansRegular(size: 12))
            hotelList.forEach { i in
                tablerow.append(TableRow(title:i.name,
                                         subTitle: "\(i.address ?? "")",
                                         kwdprice: "\(i.currency ?? "") \(i.price ?? "")",
                                         text: "\(i.hotel_code ?? 0)",
                                         image: i.image,
                                         characterLimit: i.star_rating,
                                         cellType:.HotelSearchResultTVCell))
                
            }
            
            tablerow.append(TableRow(height:50,
                                     bgColor: .AppHolderViewColor,
                                     cellType:.EmptyTVCell))
            
            commonTVData = tablerow
            commonTableView.reloadData()
        }
        
    }
    
    
}

extension HotelSearchResultVC {
   

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
        if indexPath.row == lastRowIndex && !isLoadingData {
            isLoadingData = true // Set the flag to indicate that data loading is in progress
          //  callHotelSearchPaginationAPI()
        }
    }

    func callHotelSearchPaginationAPI() {
        print("You've reached the last cell, trigger the API call.")

        payload.removeAll()
        payload["booking_source"] = hbooking_source
        payload["search_id"] = hsearch_id
        payload["offset"] = "270"
        payload["limit"] = "10"
        payload["no_of_nights"] = "1"
    

       // viewModel?.CallHotelSearchPagenationAPI(dictParam: payload)
    }

    func hoteSearchPagenationResult(response: HotelListModel) {
        isLoadingData = false // Reset the flag when the API call is complete

        if let newResults = response.data?.hotelSearchResult, !newResults.isEmpty {
            // Append the new data to the existing data
            hotelSearchResultArray.append(contentsOf: newResults)
        } else {
            // No more items to load, update UI accordingly
            print("No more items to load.")
            // You can show a message or hide a loading indicator here
        }

        DispatchQueue.main.async { [self] in
            self.appendValues(list: hotelSearchResultArray)
        }
    }
}





extension HotelSearchResultVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
    }
    
    
    
    @objc func reload(notification: NSNotification){
        commonTableView.reloadData()
    }
    
    //MARK: - resultnil
    @objc func resultnil(notification: NSNotification){
        callapibool = true
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.key = "noresult"
        self.present(vc, animated: false)
    }
    
    
    @objc func offline(notificatio:UNNotification) {
        callapibool = true
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.key = "offline"
        self.present(vc, animated: false)
    }
    
    
    func timerDidFinish() {
        guard let vc = PopupVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    func updateTimer() {
        var totalTime = TimerManager.shared.totalTime
        let minutes =  totalTime / 60
        let seconds = totalTime % 60
        let formattedTime = String(format: "%02d:%02d", minutes, seconds)
        
        setuplabels(lbl: titlelbl, text: "Your Session Expires In: \(formattedTime)",
                    textcolor: .WhiteColor,
                    font: .OpenSansRegular(size: 12),
                    align: .left)
    }
    
}


