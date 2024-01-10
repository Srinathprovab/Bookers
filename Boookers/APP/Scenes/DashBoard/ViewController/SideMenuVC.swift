//
//  SideMenuVC.swift
//  BabSafar
//
//  Created by MA673 on 21/07/22.
//

import UIKit

class SideMenuVC: BaseTableVC, ProfileUpdateViewModelDelegate {
    
    @IBOutlet weak var holderView: UIView!
    
    static var newInstance: SideMenuVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SideMenuVC
        return vc
    }
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    var vm:LogoutViewmodel?
    var vm1:ProfileUpdateViewModel?
    
    override func viewWillDisappear(_ animated: Bool) {
        menubool = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(loginDone), name: NSNotification.Name("logindon"), object: nil)
        
        
        let logstatus = defaults.bool(forKey: UserDefaultsKeys.loggedInStatus)
        if logstatus == true {
            if menubool == true {
                callApi()
            }
        }
        
        
    }
    
    
    func callApi() {
        payload.removeAll()
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid)
        vm1?.CALL_SHOW_PROFILE_API(dictParam: payload)
    }
    func profileDetails(response: ProfileUpdateModel) {
        profildata = response.data
        
        DispatchQueue.main.async {[self] in
            setupMenuTVCells()
        }
    }
    
    @objc func loginDone() {
        callApi()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        vm = LogoutViewmodel(self)
        vm1 = ProfileUpdateViewModel(self)
        
    }
    
    
    func setupUI(){
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        holderView.backgroundColor = .clear
        
        if screenHeight > 835 {
            commonTableView.isScrollEnabled = false
        }
        
        
        commonTableView.backgroundColor = .WhiteColor
        commonTableView.registerTVCells(["MenuBGTVCell",
                                         "checkOptionsTVCell",
                                         "EmptyTVCell",
                                         "MenuTitleTVCell",
                                         "AboutusTVCell"])
        
        setupMenuTVCells()
    }
    
    
    
    
    //MARK: - setupMenuTVCells
    func setupMenuTVCells() {
        
        tablerow.removeAll()
        tablerow.append(TableRow(cellType:.MenuBGTVCell))
        tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Bookings",key: "ourproducts", image: "",cellType:.MenuTitleTVCell))
        tablerow.append(TableRow(title:"Flights",key: "menu", image: "menu5",cellType:.checkOptionsTVCell))
        tablerow.append(TableRow(title:"Hotels",key: "menu", image: "menu6",cellType:.checkOptionsTVCell))
        
        let loginstatus = defaults.bool(forKey: UserDefaultsKeys.loggedInStatus)
        if loginstatus == true {
            tablerow.append(TableRow(title:"Check My Bookings",key: "menu", image: "menu1",cellType:.checkOptionsTVCell))
        }
        
        
        //        tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        //        tablerow.append(TableRow(title:"Traveler Tools",key: "ourproducts", image: "",cellType:.MenuTitleTVCell))
        //        tablerow.append(TableRow(title:"Customer Support",key: "menu", image: "menu2",cellType:.checkOptionsTVCell))
        //        tablerow.append(TableRow(title:"Travel Guides",key: "menu", image: "menu2",cellType:.checkOptionsTVCell))
        //        tablerow.append(TableRow(title:"Client Testimonial",key: "menu", image: "menu2",cellType:.checkOptionsTVCell))
        //        tablerow.append(TableRow(title:"FAQ's",key: "menu", image: "menu2",cellType:.checkOptionsTVCell))
        
        
        tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Legal",key: "ourproducts", image: "",cellType:.MenuTitleTVCell))
        tablerow.append(TableRow(cellType:.AboutusTVCell))
        
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == true {
            tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
            tablerow.append(TableRow(title:"Delete Account",key: "menu", image: "deleteacc",cellType:.checkOptionsTVCell))
            tablerow.append(TableRow(title:"Logout",key: "menu", image: "logout",cellType:.checkOptionsTVCell))
            tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        }else {
            tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
            
        }
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    //MARK: - didTapOnLoginBtn
    override func didTapOnLoginBtn(cell: MenuBGTVCell) {
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        isFromVCBool = true
        present(vc, animated: true)
        
    }
    
    
    
    //MARK: - didTapOnEditProfileBtn
    override func didTapOnEditProfileBtn(cell: MenuBGTVCell) {
        guard let vc = EditProfileVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        isFromVCBool = true
        present(vc, animated: true)
    }
    
    
    
    //MARK: - didTapOnMenuOptionBtn
    override func didTapOnMenuOptionBtn(cell:checkOptionsTVCell){
        switch cell.titlelbl.text {
        case "Check My Bookings":
            gotoMyBookingVC()
            break
            
        case "Flights":
            gotoBookFlightsVC()
            break
            
        case "Hotels":
            //  gotoBookHotelsVC()
            break
            
            
        case "Delete Account":
            basicloderBool = true
            payload.removeAll()
            payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid)
            vm?.CALL_DELETE_USER_API(dictParam: payload)
            
            break
            
        case "Logout":
            basicloderBool = true
            vm?.CALL_LOgout_API(dictParam: [:])
            break
            
        default:
            break
        }
    }
    
    
    
    //MARK: - didTapOnAboutUsLink
    func gotoBookFlightsVC() {
        guard let vc = BookFlightVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        isFromVCBool = true
        present(vc, animated: true)
    }
    
    
    
    //MARK: - gotoBookHotelsVC
    func gotoBookHotelsVC() {
        guard let vc = BookHotelVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        isFromVCBool = true
        present(vc, animated: true)
    }
    
    
    
    //MARK: - gotoMyBookingVC
    func gotoMyBookingVC() {
        guard let vc = DBTabbarController.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 1
        callapibool = true
        present(vc, animated: true)
    }
    
    
    
    //MARK: - didTapOnAboutUsLink
    override func didTapOnAboutUsLink(cell: AboutusTVCell) {
        gotoAboutUsVC(keystr: "aboutus")
    }
    
    //MARK: - didTapOnTermsLink
    override func didTapOnTermsLink(cell: AboutusTVCell) {
        gotoAboutUsVC(keystr: "terms")
    }
    
    //MARK: - didTapOnCoockiesLink
    override func didTapOnCoockiesLink(cell: AboutusTVCell) {
        gotoContactUsVC()
    }
    
    override func didTapOnPrivacyPolicyLink(cell:AboutusTVCell){
        gotoAboutUsVC(keystr: "pp")
    }
    
    
    func gotoAboutUsVC(keystr:String) {
        guard let vc = AboutUsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.keystr = keystr
        isFromVCBool = true
        present(vc, animated: true)
    }
    
    func gotoLoginVC() {
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.isvcfrom = "menu"
        present(vc, animated: true)
    }
    
    func gotoContactUsVC() {
        guard let vc = ContactUsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}

extension SideMenuVC:LogoutViewmodelDelegate {
    func deleteSucess(response: LoginModel) {
        basicloderBool = false
        showToast(message: response.data ?? "")
        
        let seconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
            showToast(message: response.msg ?? "")
            defaults.set(false, forKey: UserDefaultsKeys.loggedInStatus)
            defaults.set("0", forKey: UserDefaultsKeys.userid)
            defaults.set("", forKey: UserDefaultsKeys.userimg)
            defaults.set("", forKey: UserDefaultsKeys.username)
            
            defaults.set("", forKey: UserDefaultsKeys.useremail)
            defaults.set("", forKey: UserDefaultsKeys.usermobilecode)
            defaults.set("", forKey: UserDefaultsKeys.usermobile)
            
            loginmenubool = false
            
            DispatchQueue.main.async {[self] in
                setupMenuTVCells()
            }
        }
    }
    
    func logoutSucess(response: LoginModel) {
        basicloderBool = false
        showToast(message: response.data ?? "")
        defaults.set(false, forKey: UserDefaultsKeys.loggedInStatus)
        defaults.set("0", forKey: UserDefaultsKeys.userid)
        defaults.set("", forKey: UserDefaultsKeys.userimg)
        defaults.set("", forKey: UserDefaultsKeys.username)
        
        defaults.set("", forKey: UserDefaultsKeys.useremail)
        defaults.set("", forKey: UserDefaultsKeys.usermobilecode)
        defaults.set("", forKey: UserDefaultsKeys.usermobile)
        
        loginmenubool = false
        
        DispatchQueue.main.async {[self] in
            setupMenuTVCells()
        }
        
        DispatchQueue.main.async {[self] in
            gotoLoginVC()
        }
    }
    
}
