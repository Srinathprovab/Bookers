//
//  ViewController.swift
//  BeeoonsApp
//
//  Created by MA673 on 12/08/22.
//

import UIKit



class ViewController: UIViewController {
    
    var ExecuteOnceBool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if !UserDefaults.standard.bool(forKey: "ExecuteOnceLoginVC") {
            ExecuteOnceBool = false
            self.getCountryList()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                self.gotoLoginVC()
            })
            
            UserDefaults.standard.set(true, forKey: "ExecuteOnceLoginVC")
        }
        
        
        if ExecuteOnceBool == true {
            
            self.getCountryList()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                self.gotodashBoardScreen()
                
                
                //                                                defaults.set("Flight", forKey: UserDefaultsKeys.tabselect)
                //                                                self.gotoBookingConfirmedVC(url: "https://kuwaitways.com/mobile_webservices/index.php/voucher/flight/KWA-F-TP-1201-7553/PTBSID0000000016/show_voucher")
            })
            
            
        }
        
    }
    
    
    func gotoBookingConfirmedVC(url:String) {
        guard let vc = BookingConfirmedVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.vocherurl = url
        callapibool = true
        present(vc, animated: true)
    }
    
    
    func gotodashBoardScreen() {
        guard let vc = DBTabbarController.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        callapibool = true
        present(vc, animated: true)
    }
    
    func gotoLoginVC() {
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        vc.isvcfrom = "ViewController"
        present(vc, animated: true)
    }
    
}


