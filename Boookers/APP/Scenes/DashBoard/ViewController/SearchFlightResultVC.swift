//
//  SearchFlightResultVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 17/08/22.
//

import UIKit

class SearchFlightResultVC: BaseTableVC,TimerManagerDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var sessonlbl: UILabel!
    @IBOutlet weak var flightsFoundlbl: UILabel!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterBtn: UIButton!
    
    
    @IBOutlet weak var fromcityloclbl: UILabel!
    @IBOutlet weak var tocityloclbl: UILabel!
    @IBOutlet weak var fromcityairportlbl: UILabel!
    @IBOutlet weak var tocityairportlbl: UILabel!
    @IBOutlet weak var triplbl: UILabel!
    @IBOutlet weak var economylbl: UILabel!
    
    
    static var newInstance: SearchFlightResultVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SearchFlightResultVC
        return vc
    }
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var payload2 = [String:Any]()
    let refreshControl = UIRefreshControl()
    var vm:FlightListViewModel?
    let dateFormatter = DateFormatter()
    var journyType = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        vm = FlightListViewModel(self)
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        TimerManager.shared.delegate = self
        addObserver()
        dateFormatter.dateFormat = "HH:mm"
        
        if callapibool == true {
            DispatchQueue.main.async {[self] in
                TimerManager.shared.sessionStop()
                callAPI()
            }
            
        }
        
    }
    
    
    @objc func offline(notificatio:UNNotification) {
        callapibool = true
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.key = "noresult"
        self.present(vc, animated: false)
    }
    
    
    
    func setupUI() {
        
        
        
        sessonlbl.text = "Your Session Expires In: 14:15"
        sessonlbl.textColor = .AppLabelColor
        sessonlbl.font = UIFont.OpenSansRegular(size: 12)
        
        
        flightsFoundlbl.textColor = .AppLabelColor
        flightsFoundlbl.font = UIFont.OpenSansRegular(size: 12)
        
        filterView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 25)
        filterBtn.setTitle("", for: .normal)
        
        
        setupTV()
    }
    
    
    
    
    func setupTV() {
        
        commonTableView.registerTVCells(["SearchFlightResultInfoTVCell",
                                         "RoundTripTVcell",
                                         "EmptyTVCell"])
        
        
        
    }
    
    
    
    
    override func didTapOnRefunduableBtn(cell: SearchFlightResultInfoTVCell) {
        print("didTapOnRefunduableBtn")
    }
    
    
    
   
  //MARK: - didTaponRoundTripCell goToFlightInfoVC
    
    override func didTaponRoundTripCell(cell: RoundTripTVcell) {
        print(cell.access_key1)
        print(cell.bookingSource)
    }
    
  
    
    override func didTapOnViewDetailsBtnAction(cell:RoundTripTVcell){
        accesskey = cell.access_key1
        bookingsource = cell.bookingSource
        defaults.set( cell.refundlbl.text, forKey: UserDefaultsKeys.flightrefundtype)
        
        
        goToFlightInfoVC()
    }
    
    
    func goToFlightInfoVC() {
        guard let vc = SelectedFlightInfoVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        self.present(vc, animated: false)
    }
    
    
    //MARK: - didTapOnFilterBtnAction
    @IBAction func didTapOnFilterBtnAction(_ sender: Any) {
        guard let vc = FilterSearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        vc.filterTapKey = "sort"
        self.present(vc, animated: false)
    }
    
    
    //MARK: - didTapOnBackBtnAction
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        TimerManager.shared.sessionStop()
        callapibool = false
        guard let vc = BookFlightVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    
    
    //MARK: - didTapOnEditSearchBtnAction
    @IBAction func didTapOnEditSearchBtnAction(_ sender: Any) {
        guard let vc = ModifySearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    
}


extension SearchFlightResultVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SearchFlightResultInfoTVCell {
            accesskey = cell.access_key1
            goToFlightInfoVC()
        }
    }
}




extension SearchFlightResultVC:FlightListViewModelDelegate {
    
    
    
    // Create a function to check if a string is not nil and not equal to "null"
    func isNonNullString(_ string: String?) -> Bool {
        if let nonNullString = string, nonNullString.lowercased() != "null" {
            return true
        }
        return false
    }
    
}



extension SearchFlightResultVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name("reloadTV"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTimer), name: NSNotification.Name("reloadTimer"), object: nil)
        
    }
    
    
    @objc func reloadTimer(){
        DispatchQueue.main.async {
            TimerManager.shared.delegate = self
        }
    }
    
    
    @objc func reload(){
        DispatchQueue.main.async {[self] in
            callAPI()
        }
    }
    
    @objc func nointernet(){
        gotoNoInternetConnectionVC(key: "nointernet", titleStr: "")
    }
    
    @objc func resultnil(){
        gotoNoInternetConnectionVC(key: "noresult", titleStr: "NO AVAILABILITY FOR THIS REQUEST")
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
        DispatchQueue.main.async {[self] in
            let totalTime = TimerManager.shared.totalTime
            let minutes =  totalTime / 60
            let seconds = totalTime % 60
            let formattedTime = String(format: "%02d:%02d", minutes, seconds)
            
            setuplabels(lbl: sessonlbl, text: "Your Session Expires In: \(formattedTime)",
                        textcolor: .AppLabelColor,
                        font: .OpenSansRegular(size: 12),
                        align: .left)
        }
    }
    
    
}



//MARK: - callAPI  flightList  FlightListModel
extension SearchFlightResultVC {
    
    
    func callAPI() {
        
        holderView.isHidden = true
        journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) ?? "oneway"
        vm?.CALL_PRE_FLIGHT_SEARCH_API(dictParam: payload)
    }
    
    
    func preFlightSearchResponse(response : pre_flight_search_Model){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.vm?.CALL_GET_HIT_URL_API(dictParam: [:], url: response.hit_url ?? "")
        }
        
    }
    
    func getHitUrlResponse(response : Flight_search_hit_url_Model){
        
        bookingsource = response.active_booking_source?[0] ?? ""
        searchid = "\(response.flight_search_params?.search_id ?? 0)"
        
        
        self.fromcityloclbl.text = response.flight_search_params?.from_loc ?? ""
        self.tocityloclbl.text = response.flight_search_params?.to_loc ?? ""
        self.fromcityairportlbl.text = response.flight_search_params?.from ?? ""
        self.tocityairportlbl.text = response.flight_search_params?.to ?? ""
        self.triplbl.text = response.flight_search_params?.trip_type ?? ""
        self.economylbl.text = "\(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "") Traveller - \(response.flight_search_params?.v_class ?? "Economy")"
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.vm?.CALL_GET_FLIGHT_LIST_API(dictParam: [:], url: response.hit_url?[0] ?? "")
        }
    }
    
    
    //MARK: - oneway and roundtrip flightList
    func flightList(response: FlightListModel) {
        
        
        if response.status == 1{
            
            holderView.isHidden = false
            view.backgroundColor = .WhiteColor
            loderBool = false
            oneWayFlights.removeAll()
            //  searchid = "\(response.data?.search_id ?? 0)"
            
            
            
            TimerManager.shared.stopTimer()
            TimerManager.shared.startTimer(time: 900)
            
            oneWayFlights = response.flight_result ?? []
            
            
            let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
            switch journyType {
                
            case "oneway":
                
                defaults.set("\(defaults.string(forKey: UserDefaultsKeys.fromcityname) ?? "") - \(defaults.string(forKey: UserDefaultsKeys.tocityname) ?? "")", forKey: UserDefaultsKeys.journeyCitys)
                defaults.set("\(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "", f1: "dd-MM-yyyy", f2: "EEE, d MMM"))", forKey: UserDefaultsKeys.journeyDates)
                
                
                appendValues(jfl: oneWayFlights)
                
                break
                
            case "circle":
                
                defaults.set("\(defaults.string(forKey: UserDefaultsKeys.fromcityname) ?? "") - \(defaults.string(forKey: UserDefaultsKeys.tocityname) ?? "")", forKey: UserDefaultsKeys.journeyCitys)
                defaults.set("\(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "", f1: "dd-MM-yyyy", f2: "EEE, d MMM")) - \(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.calRetDate) ?? "", f1: "dd-MM-yyyy", f2: "EEE, d MMM"))", forKey: UserDefaultsKeys.journeyDates)
                
                
                appendValues(jfl: oneWayFlights)
                break
                
                
                
                
            default:
                break
            }
            
            
        }else {
            
            gotoNoInternetConnectionVC(key: "noresult", titleStr: "NO AVAILABILITY FOR THIS REQUEST")
            
        }
    }
    
    
    
    func appendValues(jfl:[Flight_result]) {
        
        airlinesA.removeAll()
        prices.removeAll()
        noofStopsA.removeAll()
        fareTypeA.removeAll()
        connectingFlightsA.removeAll()
        connectingAirportA.removeAll()
        
        
        
        oneWayFlights.forEach { j in
            
            prices.append("\(j.price?.api_total_display_fare ?? 0.0)")
            
            if j.faretype == true {
                fareTypeA.append("NonRefundable")
            }else {
                fareTypeA.append("Refundable")
            }
            
            j.flight_details?.summary?.forEach({ k in
                
                airlinesA.append(k.operator_name ?? "")
                
                
                switch k.no_of_stops {
                case 0:
                    noofStopsA.append("0 Stop")
                    break
                case 1:
                    noofStopsA.append("1 Stop")
                    break
                case 2:
                    noofStopsA.append("2 Stops")
                    break
                default:
                    break
                }
            })
            
        }
        
        oneWayFlights.forEach { j in
            
            
            j.flight_details?.details?.forEach({ i in
                i.forEach { j in
                    
                    connectingFlightsA.append("\(j.operator_name ?? "") (\(j.operator_code ?? ""))")
                    connectingAirportA.append("\( j.destination?.city ?? "") (\(j.destination?.loc ?? ""))")
                }
            })
            
        }
        
        
        
        
        prices = Array(Set(prices))
        noofStopsA = Array(Set(noofStopsA))
        fareTypeA = Array(Set(fareTypeA))
        airlinesA = Array(Set(airlinesA.compactMap { $0 }))
        connectingFlightsA = Array(Set(connectingFlightsA))
        connectingAirportA = Array(Set(connectingAirportA))
        
        
        setupRoundTripTVCells(jfl: jfl)
        
    }
    
    
    
    func setupRoundTripTVCells(jfl:[Flight_result]) {
        commonTableView.separatorStyle = .none
        setuplabels(lbl: flightsFoundlbl, text: "\(jfl.count) Flights found", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 12), align: .right)
        TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
        flightsFoundlbl.isHidden = false
        sessonlbl.isHidden = false
        
        
        tablerow.removeAll()
        
        jfl.forEach { j in
            
            
            tablerow.append(TableRow(title:j.access_key,
                                     subTitle: j.booking_source,
                                     kwdprice:"\(j.price?.api_currency ?? ""):\(String(format: "%.2f", j.price?.api_total_display_fare ?? 0.0))",
                                     nonrefundable:j.faretype,
                                     key: "circle",
                                     moreData: j.flight_details?.summary,
                                     cellType:.RoundTripTVcell))
            
        }
        
        tablerow.append(TableRow(height: 40,
                                 bgColor: .AppHolderViewColor,
                                 cellType:.EmptyTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
        
        if jfl.count == 0 {
            tablerow.removeAll()
            flightsFoundlbl.isHidden = true
            sessonlbl.isHidden = true
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
            
            commonTVData = tablerow
            commonTableView.reloadData()
        }
    }
    
    
    
}


extension SearchFlightResultVC:AppliedFilters {
    
    
    
    func hotelFilterByApplied(minpricerange: Double, maxpricerange: Double, starRating: String, refundableTypeArray: [String], nearByLocA: [String], niberhoodA: [String], aminitiesA: [String]) {
        
    }
    
    
    
    // Create a function to check if a given time string is within a time range
    func isTimeInRange(time: String, range: String) -> Bool {
        guard let departureDate = dateFormatter.date(from: time) else {
            return false
        }
        
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: departureDate)
        
        switch range {
        case "12 am - 6 am":
            return hour >= 0 && hour < 6
        case "06 am - 12 pm":
            return hour >= 6 && hour < 12
        case "12 pm - 06 pm":
            return hour >= 12 && hour < 18
        case "06 pm - 12 am":
            return hour >= 18 && hour < 24
        default:
            return false
        }
    }
    
    
    
    
    func filterByApplied(minpricerange: Double, maxpricerange: Double, noofstopsFA: [String], departureTimeFilter: [String], arrivalTimeFilter: [String], airlinesFA: [String], cancellationTypeFA: [String], connectingFlightsFA: [String], connectingAirportsFA: [String]) {
        
        let filteredFlights = oneWayFlights.filter { flightList in
            // Assuming flightList is an array of flights
            
            guard let details = flightList.flight_details?.details else {
                return false
            }
            
            // Calculate the total price for the single flight
            let totalPrice = (flightList.price?.api_total_display_fare ?? 0.0)


            
            // Check if the flight list has at least one flight with the specified number of stops
            let noOfStopsMatch = noofstopsFA.isEmpty || {
                if let summary = flightList.flight_details?.summary?.first {
                    return noofstopsFA.contains("\(summary.no_of_stops ?? 0)")
                } else {
                    return false
                }
            }()
            
            
            
            // Check if the flight list has at least one flight with the specified airline
            let airlinesMatch = airlinesFA.isEmpty || {
                if let summary = flightList.flight_details?.summary?.first {
                    return airlinesFA.contains(summary.operator_name ?? "")
                } else {
                    return false
                }
            }()

            
            
            // Check if the flight list has at least one flight with the specified cancellation type
            let refundableMatch = connectingFlightsFA.isEmpty || {
                return oneWayFlights.contains { flight in
                    return flight.faretype == (cancellationTypeFA.first == "true")
                }
            }()


            
            
            // Check if the flight list has at least one flight with the specified connecting flights
            let connectingFlightsMatch = connectingFlightsFA.isEmpty || {
                return details.contains { summaryArray in
                    summaryArray.contains { flightDetail in
                        let operatorName = flightDetail.operator_name ?? ""
                        let loc = flightDetail.operator_code ?? ""
                        return connectingFlightsFA.contains("\(operatorName) (\(loc))")
                    }
                }
            }()


            
            // Assuming details is a property within Flight_result and it's not an array
            let connectingAirportsMatch = connectingAirportsFA.isEmpty || {
                if let summaryArray = flightList.flight_details?.summary {
                    return summaryArray.contains { flightDetail in
                        let airportName = flightDetail.destination?.city ?? ""
                        let airportLoc = flightDetail.destination?.loc ?? ""
                        return connectingAirportsFA.contains("\(airportName) (\(airportLoc))")
                    }
                } else {
                    return false
                }
            }()

            
            // Check if the departure time matches the filter
            let depMatch = departureTimeFilter.isEmpty || {
                if let departureDateTime = flightList.flight_details?.summary?.first?.origin?.time {
                    return departureTimeFilter.contains { departureTime in
                        return isTimeInRange(time: departureDateTime, range: departureTime.trimmingCharacters(in: .whitespaces))
                    }
                }
                return false
            }()
            
            

            
            // Check if the arrival time matches the filter
            let arrMatch = arrivalTimeFilter.isEmpty || {
                if let arrivalDateTime = flightList.flight_details?.summary?.first?.destination?.time {
                    return arrivalTimeFilter.contains { arrivalTime in
                        return isTimeInRange(time: arrivalDateTime, range: arrivalTime)
                    }
                }
                return false
            }()

            
            
            // Check if the total price is within the specified range
            return totalPrice >= minpricerange && totalPrice <= maxpricerange && noOfStopsMatch && airlinesMatch && refundableMatch && connectingFlightsMatch && connectingAirportsMatch && depMatch && arrMatch
        }
        
        setupRoundTripTVCells(jfl: filteredFlights)
        
        
    }
    
   
    
    
    
    func filtersSortByApplied(sortBy: SortParameter) {
        
        
        switch sortBy {
        case .PriceLow:
            
            
            
            let sortedFlights = oneWayFlights.sorted { (flight1, flight2) -> Bool in
                let price1 = flight1.price?.api_total_display_fare ?? 0.0
                let price2 = flight2.price?.api_total_display_fare ?? 0.0
                return price1 > price2
            }
            
            setupRoundTripTVCells(jfl: sortedFlights)
            
            
            break
            
        case .PriceHigh:
            
            let sortedFlights = oneWayFlights.sorted { (flight1, flight2) -> Bool in
                let price1 = flight1.price?.api_total_display_fare ?? 0.0
                let price2 = flight2.price?.api_total_display_fare ?? 0.0
                return price1 < price2
            }
            
            setupRoundTripTVCells(jfl: sortedFlights)
            
            
            break
            
            
            
        case .DepartureLow:
            
            let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                let time1 = j1.flight_details?.summary?.first?.origin?.time ?? "0"
                let time2 = j2.flight_details?.summary?.first?.origin?.time ?? "0"
                return time1 < time2
            })
            
            setupRoundTripTVCells(jfl: sortedArray)
            break
            
        case .DepartureHigh:
            
            let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                let time1 = j1.flight_details?.summary?.first?.origin?.time ?? "0"
                let time2 = j2.flight_details?.summary?.first?.origin?.time ?? "0"
                return time1 > time2
            })
            
            setupRoundTripTVCells(jfl: sortedArray)
            
            break
            
            
            
        case .ArrivalLow:
            let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                let time1 = j1.flight_details?.summary?.first?.destination?.time ?? "0"
                let time2 = j2.flight_details?.summary?.first?.destination?.time ?? "0"
                return time1 < time2
            })
            
            setupRoundTripTVCells(jfl: sortedArray)
            
            break
            
        case .ArrivalHigh:
            let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                let time1 = j1.flight_details?.summary?.first?.destination?.time ?? "0"
                let time2 = j2.flight_details?.summary?.first?.destination?.time ?? "0"
                return time1 > time2
            })
            
            setupRoundTripTVCells(jfl: sortedArray)
            
            break
            
        case .DurationLow:
            let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                let durationseconds1 = j1.flight_details?.summary?.first?.duration_seconds ?? 0
                let durationseconds2 = j2.flight_details?.summary?.first?.duration_seconds ?? 0
                return durationseconds1 < durationseconds2
            })
            
            setupRoundTripTVCells(jfl: sortedArray)
            break
            
        case .DurationHigh:
            let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                let durationseconds1 = j1.flight_details?.summary?.first?.duration_seconds ?? 0
                let durationseconds2 = j2.flight_details?.summary?.first?.duration_seconds ?? 0
                return durationseconds1 > durationseconds2
            })
            
            setupRoundTripTVCells(jfl: sortedArray)
            
            break
            
            
        case .airlineaz:
            
            let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                let operatorCode1 = j1.flight_details?.summary?.first?.operator_code ?? ""
                let operatorCode2 = j2.flight_details?.summary?.first?.operator_code ?? ""
                return operatorCode1 < operatorCode2
            })
            
            setupRoundTripTVCells(jfl: sortedArray)
            
            break
            
        case .airlineza:
            let sortedArray = oneWayFlights.sorted(by: { j1, j2 in
                let operatorCode1 = j1.flight_details?.summary?.first?.operator_code ?? ""
                let operatorCode2 = j2.flight_details?.summary?.first?.operator_code ?? ""
                return operatorCode1 > operatorCode2
            })
            
            setupRoundTripTVCells(jfl: sortedArray)
            
            break
            
            
        case .nothing:
            setupRoundTripTVCells(jfl: oneWayFlights)
            break
            
        default:
            break
        }
        
        
    }
    
    
    
}
