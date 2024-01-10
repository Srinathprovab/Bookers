//
//  AboutUsVC.swift
//  QBBYTravelApp
//
//  Created by FCI on 05/04/23.
//

import UIKit

class AboutUsVC: BaseTableVC,AboutusViewModelDelegate {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var navheight: NSLayoutConstraint!
    
    
    static var newInstance: AboutUsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? AboutUsVC
        return vc
    }
    var tablerow = [TableRow]()
    var page_title = String()
    var page_description = String()
    var keystr = String()
    var vm:AboutusViewModel?
    
    

    @objc func offline(notificatio:UNNotification) {
        callapibool = true
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)

        callAPI()
    }
    
    func callAPI() {
        BASE_URL = ""
        switch keystr {
            
        case "aboutus":
            vm?.CALL_ABOUTUS_API(dictParam: [:], url: "https://kuwaitways.com/mobile_webservices/index.php/general/cms/Bottom/8")
            break
            
            
        case "contactus":
            vm?.CALL_ABOUTUS_API(dictParam: [:], url: "https://kuwaitways.com/mobile_webservices/index.php/general/cms/Bottom/3")
            break
            
            
        case "terms":
            vm?.CALL_ABOUTUS_API(dictParam: [:], url: "https://kuwaitways.com/mobile_webservices/index.php/general/cms/Bottom/3")
            break
            
        case "pp":
            vm?.CALL_ABOUTUS_API(dictParam: [:], url: "https://kuwaitways.com/mobile_webservices/index.php/general/cms/Bottom/2")
            break
            
        default:
            break
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        vm = AboutusViewModel(self)
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        nav.backBtn.addTarget(self, action: #selector(gotoBackBtnAction), for: .touchUpInside)
        if screenHeight > 835 {
            navheight.constant = 130
        }else {
            navheight.constant = 100
        }
        
        commonTableView.registerTVCells(["AboutustitleTVCell",
                                         "EmptyTVCell"])
        commonTableView.isScrollEnabled = false
    }
    
    
    
    @objc func gotoBackBtnAction(){
        callapibool = false
        BASE_URL = BASE_URL1
        dismiss(animated: true)
    }
    
    
    
    
    func aboutusDetails(response: AboutusModel) {
        self.page_description = response.data?.page_description ?? ""
        
        
        setuplabels(lbl: nav.titlelbl, text: response.data?.page_title ?? "", textcolor: .WhiteColor, font: .LatoSemibold(size: 18), align: .center)
        
        DispatchQueue.main.async {[self] in
            setupTVCells()
        }
    }
    
    
    func setupTVCells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:self.page_description,cellType:.AboutustitleTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    
}

