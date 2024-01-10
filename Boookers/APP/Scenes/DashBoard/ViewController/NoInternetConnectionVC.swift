//
//  noInternetConnectionVC.swift
//  BabSafar
//
//  Created by MA673 on 08/08/22.
//

import UIKit

class NoInternetConnectionVC: UIViewController {
    
    
    @IBOutlet weak var wifiImg: UIImageView!
    @IBOutlet weak var closeImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subTitlelbl: UILabel!
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var btnlbl: UILabel!
    @IBOutlet weak var tryAgainBtn: UIButton!
    
    var payload = [String:Any]()
    var key = String()
    var titleStr = String()
    static var newInstance: NoInternetConnectionVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? NoInternetConnectionVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if key == "noresult" || key == "noseat"{
            noresultSetup()
        }
    }
    
    func noresultSetup(){
        wifiImg.image = UIImage(named: "oops")
        setupLabels(lbl: titlelbl, text: titleStr, textcolor: .AppLabelColor, font: .LatoMedium(size: 18))
        setupLabels(lbl: subTitlelbl, text: "Please Search Again!", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: btnlbl, text: "Search Again", textcolor: .WhiteColor, font: .LatoSemibold(size: 18))
        titlelbl.numberOfLines = 0
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() {
        // wifiImg.image = UIImage(named: "wifi")
        closeImg.image = UIImage(named: "close1")
        
        setupLabels(lbl: titlelbl, text: "No Internet Connection", textcolor: .AppLabelColor, font: .LatoMedium(size: 18))
        setupLabels(lbl: subTitlelbl, text: "Please Check Your Internet Connection", textcolor: .AppLabelColor, font: .LatoLight(size: 14))
        setupLabels(lbl: btnlbl, text: "Try Again", textcolor: .WhiteColor, font: .LatoSemibold(size: 18))
        tryAgainBtn.setTitle("", for: .normal)
        setupViews(v: btnView, radius: 4, color: .AppNavBackColor)
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
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.clear.cgColor
    }
    
    @IBAction func didTapOnTryAgainBtn(_ sender: Any) {
        
        TimerManager.shared.stopTimer()
        
        if key == "noresult" {
            
            if let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect),tabselect == "Flight" {
                guard let vc = BookFlightVC.newInstance.self else {return}
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }else {
                guard let vc = BookHotelVC.newInstance.self else {return}
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
            
        }else if key == "noseat" {
            if let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect),tabselect == "Flight" {
                // searchFlightAgain()
                gotoBookFlightVC()
            }else {
                
            }
        }else {
            NotificationCenter.default.post(name: NSNotification.Name("reloadTV"), object: nil)
            dismiss(animated: false)
        }
    }
    
}



extension NoInternetConnectionVC {
    
    
    func gotoBookFlightVC() {
        guard let vc = BookFlightVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    
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
        
        let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
        if journyType == "oneway" {
            
            payload["return"] = ""
        }else if journyType == "circle"{
            payload["return"] = defaults.string(forKey: UserDefaultsKeys.calRetDate)
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
