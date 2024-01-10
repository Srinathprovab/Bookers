//
//  LoadWebViewVC.swift
//  AlghanimTravelApp
//
//  Created by FCI on 29/09/22.
//

import UIKit
import WebKit
import SwiftyJSON



class LoadWebViewVC: UIViewController, TimerManagerDelegate {
    
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var webview: WKWebView!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    
    
    static var newInstance: LoadWebViewVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? LoadWebViewVC
        return vc
    }
    
    
    var urlString = String()
    var titleString = String()
    var apicallbool = true
    var openpaymentgatewaybool = false
    var isVcFrom = String()
    
    let activityIndicatorView = UIActivityIndicatorView(style: .large)
    
    
    
    @objc func offline(notificatio:UNNotification) {
        callapibool = true
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //loderBool = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        
        
        print("<<<<<<<=== urlString ==>>>>>>\n \(urlString)")
        activityIndicatorView.startAnimating()
        self.webview.isUserInteractionEnabled = false
        
        
        if let url1 = URL(string: urlString) {
            webview.load(URLRequest(url: url1))
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: NSNotification.Name("nointernet"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadscreen), name: NSNotification.Name("reloadscreen"), object: nil)
        
        
        
        
        let seconds = 120.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
            if  openpaymentgatewaybool == false {
                
                
                showAlertOnWindow(title: "",message: "Somthing Went Wrong",titles: ["OK"]) { title in
                    self.gotoDashBoardTabbarVC()
                }
            }
        }
        
    }
    
    
    
    
    //MARK: - nointernet
    
    @objc func nointernet(){
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    @objc func reloadscreen(){
        guard let vc = PopupVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    func timerDidFinish() {
        
    }
    
    func updateTimer() {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TimerManager.shared.delegate = self
        // Do any additional setup after loading the view.
        activityIndicatorView.center = view.center
        activityIndicatorView.color = .AppBackgroundColor
        view.addSubview(activityIndicatorView)
        
        setupUI()
        
        
    }
    
    
    func setupUI() {
        
        if screenHeight > 835 {
            navHeight.constant = 130
        }else {
            navHeight.constant = 110
        }
        
        holderView.backgroundColor = .WhiteColor
        nav.backgroundColor = .AppNavBackColor
        
        if isVcFrom == "voucher" {
            nav.titlelbl.text = "Voucher Details"
        }else {
            nav.titlelbl.text = "Payment"
        }
        nav.backBtn.addTarget(self, action: #selector(didTapOnBackBtn(_:)), for: .touchUpInside)
        webview.navigationDelegate = self
        webview.isUserInteractionEnabled = true
        
    }
    
    
    @objc func didTapOnBackBtn(_ sender:UIButton) {
        if isVcFrom == "voucher" {
            callapibool = false
            dismiss(animated: true)
        }else {
            gotoDashBoardTabbarVC()
        }
    }
    
    
    
    func gotoBookingConfirmedVC(url:String) {
        TimerManager.shared.stopTimer()
        BASE_URL = BASE_URL1
        guard let vc = BookingConfirmedVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.vocherurl = url
        callapibool = true
        present(vc, animated: true)
    }
    
    
    
    func gotoDashBoardTabbarVC() {
        BASE_URL = BASE_URL1
        TimerManager.shared.stopTimer()
        guard let vc = DBTabbarController.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        isvcfrom1 = "viewcontroller"
        callapibool = true
        present(vc, animated: true)
    }
    
    
}



extension LoadWebViewVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        if let response = navigationResponse.response as? HTTPURLResponse {
            print(response)
            
            if response.statusCode == 200 {
                openpaymentgatewaybool = true
            }
            
        }
        decisionHandler(.allow)
    }
    
    
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        openpaymentgatewaybool = true
        debugPrint("didCommit")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        // Simulate a time-consuming operation
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            // Stop the activity indicator after 3 seconds (replace this with your actual data-fetching logic)
            self.activityIndicatorView.stopAnimating()
            self.webview.isUserInteractionEnabled = true
            
        }
        
        
        let str = webView.url?.absoluteString ?? ""
        webview.isHidden = false
        if apicallbool == false {
            
            if str.containsIgnoringCase(find: "paymentcancel") || str.containsIgnoringCase(find: "CANCELED") || str.containsIgnoringCase(find: "bookingFailuer"){
                
                webview.isHidden = true
                self.gotoDashBoardTabbarVC()
                showAlertOnWindow(title: "",message: "Somthing Went Wrong",titles: ["OK"]) { title in
                   
                }
            }else {
                
                
                if str.contains(find: "voucher") && str.contains(find: "show_voucher"){
                    gotoBookingConfirmedVC(url: webView.url?.absoluteString ?? "")
                }
                
                
                
            }
        }
        apicallbool = false
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        debugPrint("didFail")
    }
    
    
}

extension String {
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
}
