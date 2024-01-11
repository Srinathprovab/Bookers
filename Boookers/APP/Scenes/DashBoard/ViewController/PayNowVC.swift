//
//  PayNowVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 18/08/22.
//

import UIKit

class PayNowVC: BaseTableVC, PreProcessBookingViewModelDelegate, TimerManagerDelegate {
    
    

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    @IBOutlet weak var viewFlightsBtnView: UIView!
    @IBOutlet weak var viewFlightlbl: UILabel!
    @IBOutlet weak var viewFlightsBtn: UIButton!
    @IBOutlet weak var bookNowHolderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var bookNowView: UIView!
    @IBOutlet weak var bookNowlbl: UILabel!
    @IBOutlet weak var bookNowBtn: UIButton!
    
    static var newInstance: PayNowVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? PayNowVC
        return vc
    }
    
    var tmpFlightPreBookingId = String()
    var fnameA = [String]()
    var passengertypeA = [String]()
    var title2A = [String]()
    var mnameA = [String]()
    var lnameA = [String]()
    var dobA = [String]()
    var passportNoA = [String]()
    var countryCodeA = [String]()
    var genderA = [String]()
    var passportexpiryA = [String]()
    var passportissuingcountryA = [String]()
    var middleNameA = [String]()
    var leadPassengerA = [String]()
    var activepaymentoptions = String()
    var tokenkey1 = String()
    var callpaymenthotelbool = true
    var tokenkey = String()
    let datePicker = UIDatePicker()
    var tablerow = [TableRow]()
    var bool = true
    var name = String()
    var flighttotelCount = 0
    var hoteltotelCount = 0
    var adultsCount = Int()
    var childCount = Int()
    var infantsCount = Int()
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var payload2 = [String:Any]()
    var secureapidonebool = false
    var hbookingToken = String()
    var vm:PreProcessBookingViewModel?
    var vm1:HotelMBViewModel?
    var positionsCount = 0
    
    var roompaxesdetails = [Room_paxes_details]()
    var passportExpiryBoolString = String()
    
    var priceDetails :PriceDetails?
    var payemail = String()
    var paymobile = String()
    var paycountryCode = String()
    var promocodeBool = false
    var promocodeValue = String()
    var promocodeString = ""
    
    var promocodeString1 = ""
    
    
    
    
    
    
    // Initialize an array to store the validation state for each cell
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        TimerManager.shared.delegate = self
        vm = PreProcessBookingViewModel(self)
        vm1 = HotelMBViewModel(self)
        
    }
    
    
    func setupUI() {
        
        if screenHeight > 835 {
            navHeight.constant = 230
        }else {
            navHeight.constant = 145
        }
        
        holderView.backgroundColor = .WhiteColor
        nav.titlelbl.text = "Booking Details"
        nav.backBtn.addTarget(self, action: #selector(gotoBackScreen), for: .touchUpInside)
        nav.citylbl.isHidden = false
        nav.datelbl.isHidden = false
        nav.travellerlbl.isHidden = false
        
        
        viewFlightsBtnView.backgroundColor = .clear
        viewFlightsBtnView.addCornerRadiusWithShadow(color: .clear, borderColor: HexColor("#C5A47E"), cornerRadius: 15)
        viewFlightlbl.textColor = .WhiteColor
        viewFlightlbl.font = UIFont.poppinsRegular(size: 14)
        viewFlightsBtn.setTitle("", for: .normal)
        
       // setupViews(v: bookNowHolderView, radius: 0, color: .AppJournyTabSelectColor)
        setupViews(v: bookNowView, radius: 6, color: .AppNavBackColor)
        bookNowView.layer.cornerRadius = 20
        bookNowView.clipsToBounds = true
     //   setupLabels(lbl: titlelbl, text: grandTotal, textcolor: .WhiteColor, font: .OpenSansMedium(size: 20))
        titlelbl.text = grandTotal
        setupLabels(lbl: bookNowlbl, text: "PAY NOW", textcolor: .WhiteColor, font: .OpenSansMedium(size: 16))
        bookNowBtn.setTitle("", for: .normal)
        
        
        commonTableView.registerTVCells(["TDetailsLoginTVCell",
                                         "EmptyTVCell",
                                         "PromocodeTVCell",
                                         "PriceSummaryTVCell",
                                         "checkOptionsTVCell",
                                         "PriceLabelsTVCell",
                                         "AddDeatilsOfGuestTVCell",
                                         "AcceptTermsAndConditionTVCell",
                                         "HotelPurchaseSummaryTVCell",
                                         "AddDeatilsOfTravellerTVCell",
                                         "CommonTVAddTravellerTVCell",
                                         "BillingAddressTVCell",
                                         "ContactInformationTVCell",
                                         "TotalNoofTravellerTVCell",
                                         "FlightPriceSummeryTVCell",
                                         "AddInfantaTravellerTVCell"])
        
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
    
    
    
    //MARK: - gotoBackScreen searchFlightAgain
    @objc func gotoBackScreen() {
        
        callapibool = true
        travelerArray.removeAll()
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.tabselect) {
            if journeyType == "Flight" {
                searchFlightAgain()
            }else {
                searchHotelAgain()
            }
        }
        
    }
    
    
    
    //MARK: - didTapOnExpandAdultViewbtnAction AddDeatilsOfTravellerTVCell
    override func didTapOnExpandAdultViewbtnAction(cell: AddDeatilsOfTravellerTVCell) {
        if cell.expandViewBool == true {
            
            cell.expandView()
            cell.expandViewBool = false
        }else {
            
            cell.collapsView()
            cell.expandViewBool = true
        }
        
        commonTableView.beginUpdates()
        commonTableView.endUpdates()
    }
    
    
    override func tfeditingChanged(tf:UITextField) {
        print(tf.tag)
    }
    
    
    
    override func donedatePicker(cell:AddDeatilsOfTravellerTVCell){
        self.view.endEditing(true)
    }
    
    override func cancelDatePicker(cell:AddDeatilsOfTravellerTVCell){
        self.view.endEditing(true)
    }
    
    
    
    
    //MARK: - setupTVCells
    func setupTVCells() {
        tablerow.removeAll()
        passengertypeArray.removeAll()
        
        
        holderView.isHidden = false
        
        
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == false {
            tablerow.append(TableRow(cellType:.TDetailsLoginTVCell))
        }
        
        
        tablerow.append(TableRow(height:20, bgColor:.AppHolderViewColor,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Passenger Details",cellType:.TotalNoofTravellerTVCell))
        for i in 1...adultsCount {
            positionsCount += 1
            passengertypeArray.append("Adult")
            let travellerCell = TableRow(title: "Adult \(i)", key: "adult", characterLimit: positionsCount, cellType: .AddDeatilsOfTravellerTVCell)
            tablerow.append(travellerCell)
            
        }
        
        
        if childCount != 0 {
            for i in 1...childCount {
                positionsCount += 1
                passengertypeArray.append("Child")
                tablerow.append(TableRow(title:"Child \(i)",key:"child",characterLimit: positionsCount,cellType:.AddDeatilsOfTravellerTVCell))
            }
        }
        
        if infantsCount != 0 {
            for i in 1...infantsCount {
                positionsCount += 1
                passengertypeArray.append("Infant")
                tablerow.append(TableRow(title:"Infant \(i)",key:"infant",characterLimit: positionsCount,cellType:.AddDeatilsOfTravellerTVCell))
            }
        }
        
        tablerow.append(TableRow(cellType:.ContactInformationTVCell))
        
        if promocodeBool == false {
            tablerow.append(TableRow(cellType:.PromocodeTVCell))
        }
        
//        tablerow.append(TableRow(title:grandTotal,
//                                 cellType:.PriceSummaryTVCell))
        
        tablerow.append(TableRow(cellType:.FlightPriceSummeryTVCell))
        
        
        tablerow.append(TableRow(title:"I Accept T&C and Privacy Policy",cellType:.AcceptTermsAndConditionTVCell))
        tablerow.append(TableRow(height:30, bgColor:.AppBGcolor,cellType:.EmptyTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    //MARK: - didTapOnViewFlightDetails
    @objc func didTapOnViewFlightDetails(_ sender:UIButton) {
        guard let vc = ViewFlightDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnViewHotelDetails
    @objc func didTapOnViewHotelDetails(_ sender:UIButton) {
        guard let vc = ViewHotelDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        isFromVCBool = true
        self.present(vc, animated: true)
    }
    
    
    override func didTapOnLoginBtn(cell: TDetailsLoginTVCell) {
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    
    //MARK: - didTapOnApplyBtn
    override func didTapOnApplyBtn(cell:PromocodeTVCell){
        
        if cell.promocodeTF.text?.isEmpty == false {
            callPromocodeAPI(promocodeStr: cell.promocodeTF.text ?? "")
        }else {
            showToast(message: "Enter PromoCode To Apply")
        }
        
    }
    
    
    func callPromocodeAPI(promocodeStr:String) {
        payload.removeAll()
        payload["moduletype"] = "flight"
        payload["promocode"] = promocodeStr
        payload["total_amount_val"] = priceDetails?.grand_total ?? ""
        payload["convenience_fee"] = "0"
        payload["email"] = payemail
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        
        vm?.CALL_APPLY_PROMOCODE_API(dictParam: payload)
    }
    
    
    
    func promocodeResult(response: ApplyPromocodeModel) {
        
        if response.status == 1 {
            promocodeBool = true
            promocodeValue = response.total_amount_val ?? ""
            promocodeDiscountValue = response.value ?? ""
            promocodeString = response.promocode ?? ""
            grandTotal = "KWD:\(response.total_amount_val ?? "")"
            setuplabels(lbl: titlelbl, text: grandTotal, textcolor: .WhiteColor, font: .OpenSansMedium(size: 20), align: .left)
            NotificationCenter.default.post(name: NSNotification.Name("promocodeapply"), object: nil)
            
            DispatchQueue.main.async {[self] in
                commonTableView.reloadData()
            }
    
        }else {
            showToast(message: "Invalid Promo Code")
            promocodeBool = false
        }
        
    }
    
    
    //MARK: - didTapOnRefundBtn
    override func didTapOnRefundBtn(cell: PriceSummaryTVCell) {
        commonTableView.reloadData()
    }
    
    
    override func didTapOnSelectAdultTraveller(Cell: AddAdultsOrGuestTVCell) {
        
    }
    
    func goToSaveTravellersDetailsVC(ptitle:String,keyStr:String,pid:String) {
        
    }
    
    
    override func didTapOnTAndCAction(cell: AcceptTermsAndConditionTVCell) {
         gotoAboutUsVC(keystr: "terms")
    }
    
    override func didTapOnPrivacyPolicyAction(cell: AcceptTermsAndConditionTVCell) {
         gotoAboutUsVC(keystr: "pp")
    }
    
    func gotoAboutUsVC(keystr:String) {
        guard let vc = AboutUsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.keystr = keystr
        present(vc, animated: true)
    }
    
    override func editingMDCOutlinedTextField(tf:UITextField){
        
    }
    
    
    @IBAction func didTapOPayNowBtn(_ sender: Any) {
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.tabselect) {
            if journeyType == "Flight" {
                tapOnPayNow()
            }else {
                hotelTapPayNow()
            }
        }
    }
    
    
    
    override func didTapOnExpandAdultViewbtnAction(cell: AddDeatilsOfGuestTVCell){
        if cell.expandViewBool == true {
            
            cell.expandView()
            cell.expandViewBool = false
        }else {
            
            cell.collapsView()
            cell.expandViewBool = true
        }
        
        commonTableView.beginUpdates()
        commonTableView.endUpdates()
    }
    
    
    //MARK: - BillingAddressTVCell didTapOnBillingAddressDropDownBtnAction
    override func didTapOnBillingAddressDropDownBtnAction(cell: BillingAddressTVCell) {
        if cell.expandViewBool == true {
            
            cell.expandView()
            cell.expandViewBool = false
        }else {
            
            cell.collapsView()
            cell.expandViewBool = true
        }
        
        commonTableView.beginUpdates()
        commonTableView.endUpdates()
    }
    
    
    //MARK: - ContactInformationTVCell
    
    override func didTapOnCountryCodeBtn(cell: ContactInformationTVCell) {
        billingCountryCode = cell.billingCountryCode
        billingCountryName = cell.billingCountryName
        paycountryCode = cell.countryCodeLbl.text ?? ""
    }
    
    
    override func didTapOnDropDownBtn(cell: ContactInformationTVCell) {
        billingCountryCode = cell.billingCountryCode
        billingCountryName = cell.billingCountryName
        paycountryCode = cell.countryCodeLbl.text ?? ""
    }
    
    
    override func editingTextField(tf:UITextField){
        
        
        switch tf.tag {
        case 111:
            payemail = tf.text ?? ""
            break
            
        case 222:
            paymobile = tf.text ?? ""
            break
            
        default:
            break
        }
    }
    
}

extension PayNowVC {
    
    //MARK: - CALL_PRE_PROCESS_BOOKING_API
    func callAPI() {
        payload.removeAll()
        payload["search_id"] = searchid
        payload["booking_source"] = bookingsourcekey
        payload["access_key"] = accesskey
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid)
        
        vm?.CALL_PRE_PROCESS_BOOKING_API(dictParam: payload)
    }
    
    func preProcessBookingDetails(response: PreProcessBookingModel) {
        
        
        promoinfoArray = response.promo_info ?? []
        tokenkey1 = response.form_params?.token_key ?? ""
        callMobileBookingAPI(res: response)
        
    }
    
    //MARK: - CALL_MOBILE_BOOKING_API
    func callMobileBookingAPI(res:PreProcessBookingModel) {
        
        
        payload.removeAll()
        payload["search_id"] = searchid
        payload["booking_source"] = bookingsourcekey
        payload["promocode_val"] = ""
        payload["access_key"] = accesskey
        payload["booking_id"] = res.form_params?.booking_id
        
        
        vm?.CALL_MOBILE_BOOKING_API(dictParam: payload)
    }
    
    
    func mobileBookingDetails(response: MobileBookingModel) {
        if response.status == 1 {
            
            holderView.isHidden = false
            activepaymentoptions = response.active_payment_options?[0] ?? ""
            tmpFlightPreBookingId = response.tmp_flight_pre_booking_id ?? ""
            accesskey = response.access_key_tp ?? ""
            bookingsource = response.booking_source ?? ""
            
            specialAssistancelist1 = response.special_allowance ?? []
            meallist = response.meal_list ?? []
            travelerArray.removeAll()
            
            
            priceDetails = response.priceDetails
            
            DispatchQueue.main.async {[self] in
                setupTVCells()
            }
        }else {
            
            gotoNoInternetConnectionVC(key: "noresult", titleStr: "Due to Technical issue Booking Process has been aborted. Sorry for inconvenience.")
            
        }
    }

}



//MARK: - Did Tap On Flight Pay Now Button API Calls
extension PayNowVC {
    
    func tapOnPayNow() {
        
        payload.removeAll()
        payload1.removeAll()
        
        
        var callpaymentbool = true
        var fnameCharBool = true
        var lnameCharBool = true
        
        
        
        for traveler in travelerArray {
            
            if traveler.firstName == nil  || traveler.firstName?.isEmpty == true{
                callpaymentbool = false
            }
            
            if (traveler.firstName?.count ?? 0) <= 3 {
                fnameCharBool = false
            }
            
            if traveler.lastName == nil || traveler.firstName?.isEmpty == true{
                callpaymentbool = false
            }
            
            if (traveler.lastName?.count ?? 0) <= 3 {
                lnameCharBool = false
            }
            
            if traveler.dob == nil || traveler.dob?.isEmpty == true{
                callpaymentbool = false
            }
            
            if traveler.passportno == nil || traveler.passportno?.isEmpty == true{
                callpaymentbool = false
            }
            
            if traveler.passportIssuingCountry == nil || traveler.passportIssuingCountry?.isEmpty == true{
                callpaymentbool = false
            }
            
            if traveler.passportExpireDate == nil || traveler.passportExpireDate?.isEmpty == true{
                callpaymentbool = false
            }
            
            
            // Continue checking other fields
        }
        
        
        
        
        
        
        let positionsCount1 = commonTableView.numberOfRows(inSection: 0)
        for position in 0..<positionsCount1 {
            
            
            if let cell = commonTableView.cellForRow(at: IndexPath(row: position, section: 0)) as? AddDeatilsOfTravellerTVCell {
                
                
                if cell.titleTF.text?.isEmpty == true {
                    cell.titleView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                }
                
                if cell.fnameTF.text?.isEmpty == true {
                    cell.fnameView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                } else if (cell.fnameTF.text?.count ?? 0) <= 3 {
                    cell.fnameView.layer.borderColor = UIColor.red.cgColor
                    fnameCharBool = false
                }
                
                if cell.lnameTF.text?.isEmpty == true {
                    cell.lnameView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                } else if (cell.lnameTF.text?.count ?? 0) <= 3 {
                    cell.lnameView.layer.borderColor = UIColor.red.cgColor
                    lnameCharBool = false
                    
                }
                
                if cell.dobTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.dobView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                }
                
                
                if cell.passportnoTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.passportnoView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                }
                
                
                if cell.passportIssuingCountryTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.issuecountryView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                }
                
                
                if cell.passportExpireDateTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.passportexpireView.layer.borderColor = UIColor.red.cgColor
                    callpaymentbool = false
                }
                
            }
        }
        
        
        let mrtitleArray = travelerArray.compactMap({$0.mrtitle})
        let laedpassengerArray = travelerArray.compactMap({$0.laedpassenger})
        let middlenameArray = travelerArray.compactMap({$0.middlename})
        // let passengertypeArray = travelerArray.compactMap({$0.passengertype})
        let genderArray = travelerArray.compactMap({$0.gender})
        let firstnameArray = travelerArray.compactMap({$0.firstName})
        let lastNameArray = travelerArray.compactMap({$0.lastName})
        let dobArray = travelerArray.compactMap({$0.dob})
        let passportnoArray = travelerArray.compactMap({$0.passportno})
        let passportIssuingCountryArray = travelerArray.compactMap({$0.passportIssuingCountry})
        let passportExpireDateArray = travelerArray.compactMap({$0.passportExpireDate})
        //        let frequentFlyrNoArray = travelerArray.compactMap({$0.frequentFlyrNo})
        //        let mealNameArray = travelerArray.compactMap({$0.meal})
        //        let specialAssicintenceArray = travelerArray.compactMap({$0.specialAssicintence})
        //        let nationalityArray = travelerArray.compactMap({$0.nationality})
        
        
        // Convert arrays to string representations
        let laedpassengerString = "[\"" + laedpassengerArray.joined(separator: "\",\"") + "\"]"
        let genderString = "[\"" + genderArray.joined(separator: "\",\"") + "\"]"
        let mrtitleString = "[\"" + mrtitleArray.joined(separator: "\",\"") + "\"]"
        let firstnameString = "[\"" + firstnameArray.joined(separator: "\",\"") + "\"]"
        let middlenameString = "[\"" + middlenameArray.joined(separator: "\",\"") + "\"]"
        let lastNameString = "[\"" + lastNameArray.joined(separator: "\",\"") + "\"]"
        let dobString = "[\"" + dobArray.joined(separator: "\",\"") + "\"]"
        let passportnoString = "[\"" + passportnoArray.joined(separator: "\",\"") + "\"]"
        let passportIssuingCountryString = "[\"" + passportIssuingCountryArray.joined(separator: "\",\"") + "\"]"
        let passportExpireDateString = "[\"" + passportExpireDateArray.joined(separator: "\",\"") + "\"]"
        let passengertypeArrayString = "[\"" + passengertypeArray.joined(separator: "\",\"") + "\"]"
        
        
        payload["search_id"] = searchid
        payload["tmp_flight_pre_booking_id"] = tmpFlightPreBookingId
        payload["token_key"] = tokenkey1
        payload["access_key"] =  accesskey
        payload["access_key_tp"] =  accesskey
        payload["insurance_policy_type"] = "0"
        payload["insurance_policy_option"] = "0"
        payload["insurance_policy_cover_type"] = "0"
        payload["insurance_policy_duration"] = "0"
        payload["isInsurance"] = "0"
        payload["redeem_points_post"] = "1"
        payload["booking_source"] = bookingsourcekey
        payload["promocode_val"] = promocodeString
        payload["mealsAmount"] = "0"
        payload["baggageAmount"] = "0"
        
        payload["passenger_type"] = passengertypeArrayString
        payload["lead_passenger"] = laedpassengerString
        payload["gender"] = genderString
        payload["name_title"] =  mrtitleString
        payload["first_name"] =  firstnameString
        payload["middle_name"] =  middlenameString
        payload["last_name"] =  lastNameString
        payload["date_of_birth"] =  dobString
        payload["passenger_passport_number"] =  passportnoString
        payload["passenger_passport_issuing_country"] =  passportIssuingCountryString
        payload["passenger_nationality"] = passportIssuingCountryString
        payload["passenger_passport_expiry"] =  passportExpireDateString
        payload["Frequent"] = "\([["Select"]])"
        payload["ff_no"] = "\([[""]])"
        payload["payment_method"] =  "PNHB1"
        
        payload["billing_email"] = payemail
        payload["passenger_contact"] = paymobile
        payload["country_mobile_code"] = paycountryCode
        payload["insurance"] = "1"
        payload["tc"] = "on"
        payload["booking_step"] = "book"
        payload["selectedCurrency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD"
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        
        
        //        payload["address2"] = ""
        //        payload["billing_address_1"] = ""
        //        payload["billing_state"] = ""
        //        payload["billing_city"] = ""
        //        payload["billing_zipcode"] = ""
        
        // Check additional conditions
        if callpaymentbool == false {
            showToast(message: "Add Details")
        }else if passportExpireDateBool == false {
            showToast(message: "Invalid expiry. Passport expires within the next 3 months.")
        }else if !fnameCharBool {
            showToast(message: "First name should have more than 3 characters")
        }else if !lnameCharBool {
            showToast(message: "Last name should have more than 3 characters")
        }else if payemail == "" {
            showToast(message: "Enter Email Address")
        }else if payemail.isValidEmail() == false {
            showToast(message: "Enter Valid Email Addreess")
        }else if paymobile == "" {
            showToast(message: "Enter Mobile No")
        }else if paycountryCode == "" {
            showToast(message: "Enter Country Code")
        }else if mobilenoMaxLengthBool == false {
            showToast(message: "Enter Valid Mobile No")
        }else if checkTermsAndCondationStatus == false {
            showToast(message: "Please Accept T&C and Privacy Policy")
        }else {
            vm?.CALL_PROCESS_PASSENGER_DETAIL_API(dictParam: payload)
        }
        
        
    }
    
    
    func processPassengerDetails(response: ProcessPassangerDetailModel) {
        secureapidonebool = true
        DispatchQueue.main.async {[self] in
            payload.removeAll()
            payload["app_reference"] = tmpFlightPreBookingId
            payload["search_id"] = searchid
            payload["promocode_val"] = promocodeString
            
            
            
            vm?.CALL_PRE_FLIGHT_BOOKING_API(dictParam: payload, key: searchid)
        }
    }
    
    
    func preFlightBookingDetails(response: ProcessPassangerDetailModel) {
        
        DispatchQueue.main.async {[self] in
            payload.removeAll()
            payload["app_reference"] = tmpFlightPreBookingId
            payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
            payload["promocode_val"] = promocodeString
            
            vm?.CALL_FLIGHT_PRE_CONF_PAYMENT_API(dictParam: payload, key: "\(searchid)")
        }
    }
    
    
    func flightPrePaymentDetails(response: PrePaymentConfModel) {
        
        DispatchQueue.main.async {[self] in
            payload.removeAll()
            payload["extra_price"] = "0"
            payload["promocode_val"] = promocodeString
            
            vm?.CALL_SENDTO_PAYMENT_API(dictParam: payload, key: "\(tmpFlightPreBookingId)/\(searchid)")
        }
    }
    
    
    func sendtoPaymentDetails(response: sendToPaymentModel) {
        
        DispatchQueue.main.async {[self] in
            payload.removeAll()
            vm?.CALL_SECURE_BOOKING_API(dictParam: [:], key: "\(tmpFlightPreBookingId)")
        }
    }
    
    
    func secureBookingDetails(response: sendToPaymentModel) {
        
        if response.status == true {
            gotoLoadWebViewVC(url: response.form_url ?? "")
        }else {
            showToast(message: response.msg ?? "")
            gotoNoInternetConnectionVC(key: "noseat", titleStr: "Booking Failed Please Contact Kuwatways Customer Service")
            
        }
        
    }
    
    func gotoLoadWebViewVC(url:String) {
        guard let vc = LoadWebViewVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.urlString = url
        present(vc, animated: true)
    }
}


//MARK: - Did Tap On Hotel Pay Now Button API Calls
extension PayNowVC:HotelMBViewModelDelegate {
    
    
    //MARK: - setupHotelTVCells
    func setupHotelTVCells() {
        tablerow.removeAll()
        holderView.isHidden = false
        
        
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == false {
            tablerow.append(TableRow(cellType:.TDetailsLoginTVCell))
        }
        
        tablerow.append(TableRow(cellType:.ContactInformationTVCell))
        
        tablerow.append(TableRow(title:"Guest Details",cellType:.TotalNoofTravellerTVCell))
        for i in 1...adultsCount {
            positionsCount += 1
            let travellerCell = TableRow(title: "Adult \(i)", key: "adult", characterLimit: positionsCount, cellType: .AddDeatilsOfGuestTVCell)
            
            tablerow.append(travellerCell)
            
        }
        
        
        if childCount != 0 {
            for i in 1...childCount {
                positionsCount += 1
                tablerow.append(TableRow(title:"Child \(i)",key:"child",characterLimit: positionsCount,cellType:.AddDeatilsOfGuestTVCell))
                
            }
        }
        
        
        tablerow.append(TableRow(cellType:.PromocodeTVCell))
        tablerow.append(TableRow(title:"Purchase Summary",
                                 subTitle: defaults.string(forKey: UserDefaultsKeys.roomType),
                                 key:defaults.string(forKey: UserDefaultsKeys.checkout),
                                 text: defaults.string(forKey: UserDefaultsKeys.hoteladultscount),
                                 headerText: defaults.string(forKey: UserDefaultsKeys.hoteladultscount),
                                 buttonTitle: defaults.string(forKey: UserDefaultsKeys.checkin),
                                 key1: defaults.string(forKey: UserDefaultsKeys.refundtype),
                                 questionType: "KWD:00.00",
                                 TotalQuestions:"\(roompaxesdetails[0].currency ?? ""):\(roompaxesdetails[0].net ?? "")",
                                 cellType:.HotelPurchaseSummaryTVCell,
                                 questionBase: "\(roompaxesdetails[0].currency ?? ""):\(roompaxesdetails[0].net ?? "")"))
        tablerow.append(TableRow(title:"I Accept T&C and Privacy Policy",cellType:.AcceptTermsAndConditionTVCell))
        tablerow.append(TableRow(height:30, bgColor:.AppBGcolor,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    
    //MARK: - callHotelMobileBookingAPI
    func callHotelMobileBookingAPI() {
        
        let ratekeyArrayString = "[\"" + ratekeyArray.joined(separator: "\",\"") + "\"]"
        
        payload.removeAll()
        payload["search_id"] = hsearch_id
        payload["booking_source"] = hbooking_source
        payload["token"] = htoken
        payload["token_key"] = htokenkey
        payload["rateKey"] = ratekeyArrayString
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        
        
        vm1?.CALL_GET_HOTEL_MOBILE_BOOKING_DETAILS_API(dictParam: payload)
    }
    
    
    //MARK: - hotelMBDetails
    func hotelMBDetails(response: HotelMBModel) {
        
        checkTermsAndCondationStatus = false
        holderView.isHidden = false
        hbookingToken = response.data?.token ?? ""
        hbooking_source = response.data?.booking_source ?? ""
        
        roompaxesdetails = response.data?.room_paxes_details ?? []
        titlelbl.text = "\(roompaxesdetails[0].currency ?? ""):\(roompaxesdetails[0].net ?? "")"
        nav.travellerlbl.text = "Guests- \(roompaxesdetails[0].no_of_adults ?? 0) / Room - \(roompaxesdetails[0].no_of_rooms ?? 0))"
        
        travelerArray.removeAll()
        
        DispatchQueue.main.async {[self] in
            setupHotelTVCells()
        }
        
    }
    
    
    
    func hotelTapPayNow() {
        
        
        payload.removeAll()
        payload1.removeAll()
        
        var callpaymenthotelbool = true
        var fnameCharBool = true
        var lnameCharBool = true
        
        
        for traveler in travelerArray {
            
            if traveler.firstName == nil  || traveler.firstName?.isEmpty == true{
                callpaymenthotelbool = false
                
            }
            
            if (traveler.firstName?.count ?? 0) <= 3 {
                fnameCharBool = false
            }
            
            if traveler.lastName == nil || traveler.firstName?.isEmpty == true{
                callpaymenthotelbool = false
            }
            
            if (traveler.lastName?.count ?? 0) <= 3 {
                lnameCharBool = false
            }
            
            
            // Continue checking other fields
        }
        
        
        
        let positionsCount1 = commonTableView.numberOfRows(inSection: 0)
        for position in 0..<positionsCount1 {
            // Fetch the cell for the given position
            if let cell = commonTableView.cellForRow(at: IndexPath(row: position, section: 0)) as? AddDeatilsOfGuestTVCell {
                
                if cell.titleTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.titleView.layer.borderColor = UIColor.red.cgColor
                    callpaymenthotelbool = false
                    
                }
                
                if cell.fnameTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.fnameView.layer.borderColor = UIColor.red.cgColor
                    callpaymenthotelbool = false
                }else if (cell.fnameTF.text?.count ?? 0) <= 3{
                    cell.fnameView.layer.borderColor = UIColor.red.cgColor
                    fnameCharBool = false
                }else {
                    fnameCharBool = true
                }
                
                if cell.lnameTF.text?.isEmpty == true {
                    // Textfield is empty
                    cell.lnameView.layer.borderColor = UIColor.red.cgColor
                    callpaymenthotelbool = false
                }else if (cell.lnameTF.text?.count ?? 0) <= 3{
                    cell.lnameView.layer.borderColor = UIColor.red.cgColor
                    lnameCharBool = false
                } else {
                    // Textfield is not empty
                    lnameCharBool = true
                }
                
                
            }
        }
        
        
        let mrtitleArray = travelerArray.compactMap({$0.mrtitle})
        let passengertypeArray = travelerArray.compactMap({$0.passengertype})
        let firstnameArray = travelerArray.compactMap({$0.firstName})
        let lastNameArray = travelerArray.compactMap({$0.lastName})
        
        
        let mrtitleString = "[\"" + mrtitleArray.joined(separator: "\",\"") + "\"]"
        let firstnameString = "[\"" + firstnameArray.joined(separator: "\",\"") + "\"]"
        let lastNameString = "[\"" + lastNameArray.joined(separator: "\",\"") + "\"]"
        let passengertypeString = "[\"" + passengertypeArray.joined(separator: "\",\"") + "\"]"
        
        
        payload["search_id"] = hsearch_id
        payload["booking_source"] = hbooking_source
        payload["promo_code"] = ""
        payload["token"] = hbookingToken
        payload["redeem_points_post"] = "0"
        payload["reducing_amount"] = "0"
        payload["reward_usable"] = "0"
        payload["reward_earned"] = "0"
        payload["billing_email"] = payemail
        payload["passenger_contact"] = paymobile
        payload["first_name"] =  firstnameString
        payload["last_name"] =  lastNameString
        payload["name_title"] =  mrtitleString
        payload["billing_country"] = billingCountryCode
        payload["country_code"] = paycountryCode
        payload["passenger_type"] = passengertypeString
        
        // Check additional conditions
        if payemail == "" {
            showToast(message: "Enter Email Address")
        }else if payemail.isValidEmail() == false {
            showToast(message: "Enter Valid Email Addreess")
        }else if paymobile == "" {
            showToast(message: "Enter Mobile No")
        }else if paymobile.isValidMobileNumber() == false {
            showToast(message: "Enter Valid Mobile No")
        }else if paycountryCode == "" {
            showToast(message: "Enter Country Code")
        }else if mobilenoMaxLengthBool == false {
            showToast(message: "Enter Valid Mobile No")
        }else
        
        if callpaymenthotelbool == false{
            showToast(message: "Add Details")
        }else if fnameCharBool == false{
            showToast(message: "More Than 3 Char")
        }else if lnameCharBool == false{
            showToast(message: "More Than 3 Char")
        }else if checkTermsAndCondationStatus == false {
            showToast(message: "Please Accept T&C and Privacy Policy")
        }else {
            vm1?.CALL_GET_HOTEL_MOBILE_PRE_BOOKING_DETAILS_API(dictParam: payload)
        }
    }
    
    
    func hotelMobilePreBookingDetails(response: HMPreBookingModel) {
        BASE_URL = ""
        secureapidonebool = true
        gotoLoadWebViewVC(url: response.form_url ?? "")
    }
    
}







extension PayNowVC {
    
    
    func searchFlightAgain() {
        
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
            
            if defaults.string(forKey:UserDefaultsKeys.fromCity) == "" {
                showToast(message: "Please Select From City")
            }else if defaults.string(forKey:UserDefaultsKeys.toCity) == "" {
                showToast(message: "Please Select To City")
            }else if defaults.string(forKey:UserDefaultsKeys.toCity) == defaults.string(forKey:UserDefaultsKeys.fromCity) {
                showToast(message: "Please Select Different Citys")
            }else if defaults.string(forKey:UserDefaultsKeys.calDepDate) == "" {
                showToast(message: "Please Select Departure Date")
            }else if defaults.string(forKey:UserDefaultsKeys.calRetDate) == "" {
                showToast(message: "Please Select Return Date")
            }else if defaults.string(forKey:UserDefaultsKeys.travellerDetails) == "Add Details" {
                showToast(message: "Add Traveller")
            }else if defaults.string(forKey:UserDefaultsKeys.selectClass) == "Add Details" {
                showToast(message: "Add Class")
            }else if checkDepartureAndReturnDates1(payload, p1: "depature") == false {
                showToast(message: "Invalid Date")
            }else{
                gotoSearchFlightResultVC(input: payload)
            }
            
        }else {
            searchMulticityAgain()
        }
        
       
        
        
    }
    
    func gotoSearchFlightResultVC(input:[String:Any]) {
        defaults.set(false, forKey: "flightfilteronce")
        guard let vc = SearchFlightResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        loderBool = true
        callapibool = true
        vc.payload = input
        self.present(vc, animated: false)
    }
    
    
}



extension PayNowVC {
    
    func searchMulticityAgain() {
        
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
        payload["user_id"] = "0"
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
}



extension PayNowVC {
    
    
    
    //MARK: - searchHotelAgain
    func searchHotelAgain() {
        
        payload.removeAll()
        payload["city"] = defaults.string(forKey: UserDefaultsKeys.locationcity)
        payload["hotel_destination"] = defaults.string(forKey: UserDefaultsKeys.locationid)
        payload["hotel_checkin"] = defaults.string(forKey: UserDefaultsKeys.checkin)
        payload["hotel_checkout"] = defaults.string(forKey: UserDefaultsKeys.checkout)
        
        payload["rooms"] = "\(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? "1")"
        payload["adult"] = adtArray
        payload["child"] = chArray
        
        for roomIndex in 0..<totalRooms {
            
            
            if let numChildren = Int(chArray[roomIndex]), numChildren > 0 {
                var childAges: [String] = Array(repeating: "0", count: numChildren)
                
                if numChildren > 2 {
                    childAges.append("0")
                }
                
                payload["childAge_\(roomIndex + 1)"] = childAges
            }
        }
        
        
        payload["nationality"] = "IN"
        payload["language"] = "english"
        payload["search_source"] = "postman"
        payload["currency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "KWD"
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        
        do{
            
            let jsonData = try JSONSerialization.data(withJSONObject: payload, options: JSONSerialization.WritingOptions.prettyPrinted)
            let jsonStringData =  NSString(data: jsonData as Data, encoding: NSUTF8StringEncoding)! as String
            
            print(jsonStringData)
            
            
        }catch{
            print(error.localizedDescription)
        }
        
        gotoSearchHotelsResultVC()
    }
    
    
    func gotoSearchHotelsResultVC(){
        defaults.set(false, forKey: "hoteltfilteronce")
        guard let vc = HotelSearchResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        vc.payload = payload
        present(vc, animated: false)
        
    }
    
    
}



extension PayNowVC {
    
    func addObserver() {
        
        checkTermsAndCondationStatus = false
        let logstatus = defaults.bool(forKey: UserDefaultsKeys.loggedInStatus)
        if logstatus == true  {
            
            payemail = defaults.string(forKey: UserDefaultsKeys.useremail) ?? ""
            paymobile = defaults.string(forKey: UserDefaultsKeys.usermobile) ?? ""
            paycountryCode = defaults.string(forKey: UserDefaultsKeys.usermobilecode) ?? ""
            
            mobilenoMaxLengthBool = true
        }else {
            paycountryCode = defaults.string(forKey: UserDefaultsKeys.mobilecountrycode) ?? ""
        }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name("reloadTV"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(logindon), name: NSNotification.Name("logindon"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(passportexpiry), name: NSNotification.Name("passportexpiry"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(cancelpromo), name: Notification.Name("cancelpromo"), object: nil)
        
        
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.tabselect) {
            if journeyType == "Flight" {
                
                
                viewFlightlbl.text = "View Flight Details"
                nav.citylbl.text = defaults.string(forKey: UserDefaultsKeys.journeyCitys) ?? ""
                nav.datelbl.text = defaults.string(forKey: UserDefaultsKeys.journeyDates) ?? ""
                
                
                if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                    if journeyType == "oneway" {
                        nav.travellerlbl.text = defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? ""
                        
                        adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                        childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                        infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
                        flighttotelCount = (adultsCount + childCount + infantsCount)
                        
                        
                    }else if journeyType == "circle"{
                        nav.travellerlbl.text = defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? ""
                        
                        adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                        childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                        infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
                        flighttotelCount = (adultsCount + childCount + infantsCount)
                    }else {
                        nav.travellerlbl.text = defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? ""
                        
                        adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                        childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                        infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
                        flighttotelCount = (adultsCount + childCount + infantsCount)
                    }
                }
                
                viewFlightsBtn.addTarget(self, action: #selector(didTapOnViewFlightDetails(_:)), for: .touchUpInside)
                
                if callapibool == true {
                    holderView.isHidden = true
                    callAPI()
                }
                
            }else {
                
                
                viewFlightlbl.text = "View Hotel Details"
                viewFlightsBtn.addTarget(self, action: #selector(didTapOnViewHotelDetails(_:)), for: .touchUpInside)
                
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.hoteladultscount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.hotelchildcount) ?? "0") ?? 0
                nav.citylbl.text = "\(defaults.string(forKey: UserDefaultsKeys.locationcity) ?? "")"
                nav.datelbl.text = "CheckIn - \(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.checkin) ?? "" , f1: "dd-MM-yyyy", f2: "dd MMM")) & CheckOut - \(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.checkout) ?? "", f1: "dd-MM-yyyy", f2: "dd MMM"))"
                
                
                if callapibool == true {
                    holderView.isHidden = true
                    callHotelMobileBookingAPI()
                }
                
            }
        }
    }
    
    
    
    @objc func cancelpromo() {
        promocodeBool = false
        promocodeValue = ""
        promocodeString = ""
        grandTotal = newGrandTotal
        setupLabels(lbl: titlelbl, text: grandTotal, textcolor: .WhiteColor, font: .OpenSansMedium(size: 20))
        
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
    }
    
    @objc func passportexpiry(notify:NSNotification) {
        passportExpireDateBool = false
        self.passportExpiryBoolString = (notify.object as? String) ?? ""
        showToast(message: self.passportExpiryBoolString)
    }
    
    
    @objc func logindon(){
        commonTableView.reloadData()
    }
    
    
    @objc func nointernet(){
        gotoNoInternetConnectionVC(key: "nointernet", titleStr: "")
    }
    
    @objc func resultnil(){
        gotoNoInternetConnectionVC(key: "noresult", titleStr: "NO AVAILABILITY FOR THIS REQUEST")
    }
    
    @objc func reload(){
        commonTableView.reloadData()
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
