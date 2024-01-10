//
//  BookingConfirmedVC.swift
//  BabSafar
//
//  Created by MA673 on 26/07/22.
//

import UIKit

class BookingConfirmedVC: BaseTableVC,VocherDetailsViewModelDelegate, UIDocumentInteractionControllerDelegate, HSecureBookingViewModelDelegate {
    
    
    
    @IBOutlet weak var navBar: NavBar!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    
    var vocherurl = String()
    var viewmodel:VocherDetailsViewModel?
    var tablerow = [TableRow]()
    var vocherdata1:VocherModelDetails?
    var hotelVoucherData:HotelVoucherData?
    var hotelvm:HSecureBookingViewModel?
    var kwdPrice = String()
    
    static var newInstance: BookingConfirmedVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BookingConfirmedVC
        return vc
    }
    
    
    @objc func offline(notificatio:UNNotification) {
        callapibool = true
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        
        if callapibool == true {
            BASE_URL = ""
            
            if let tabselect = defaults.object(forKey: UserDefaultsKeys.tabselect) as? String {
                if tabselect == "Flight" {
                    callFlightVoucherDetailsAPI()
                }else {
                    callHotelSecureBookingAPI()
                }
            }
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        viewmodel = VocherDetailsViewModel(self)
        hotelvm = HSecureBookingViewModel(self)
    }
    
    
    func setupUI() {
        navBar.titlelbl.text = "Booking Confirmed"
        navBar.backBtn.addTarget(self, action: #selector(didTapOnBackButton(_:)), for: .touchUpInside)
        if screenHeight < 835 {
            navHeight.constant = 120
        }else {
            navHeight.constant = 160
        }
        commonTableView.registerTVCells(["BookingConfirmedTVCell",
                                         "CommonBookingItinearyTVCell",
                                         "EmptyTVCell",
                                         "LabelTVCell",
                                         "ButtonTVCell",
                                         "SearchFlightResultTVCell",
                                         "BookedTravelDetailsTVCell",
                                         "FlightResultTVCell"])
        
    }
    
    
    func setupTV() {
        
        tablerow.removeAll()
        tablerow.append(TableRow(title:"Booking Confirmed",
                                 subTitle: vocherdata1?.booking_details?.first?.booked_by_id,
                                 text: vocherdata1?.booking_details?.first?.booked_date,
                                 buttonTitle: vocherdata1?.booking_details?.first?.app_reference,
                                 tempText: vocherdata1?.booking_details?.first?.pnr,
                                 cellType:.BookingConfirmedTVCell))
        
        
        
        let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect)
        if tabselect == "Flight"{
            tablerow.append(TableRow(title:"Flight details",
                                     key: "bc",
                                     cellType:.LabelTVCell))
            
            tablerow.append(TableRow(title:kwdPrice,
                                     moreData:fdetails,
                                     cellType:.CommonBookingItinearyTVCell))
            
            
            
            tablerow.append(TableRow(height:15,
                                     cellType:.EmptyTVCell))
            tablerow.append(TableRow(title:"Traveller Details",
                                     key: "bc",
                                     cellType:.LabelTVCell))
            
            
            tablerow.append(TableRow(moreData:vocherdata1?.booking_details?.first?.customer_details,
                                     cellType:.BookedTravelDetailsTVCell))
        }else {
            tablerow.append(TableRow(title:"Hotel details",
                                     key: "bc",
                                     cellType:.LabelTVCell))
            
            tablerow.append(TableRow(title:kwdPrice,
                                     moreData:fdetails,
                                     cellType:.CommonBookingItinearyTVCell))
            
            
            
            tablerow.append(TableRow(height:15,
                                     cellType:.EmptyTVCell))
            tablerow.append(TableRow(title:"Guest Details",
                                     key: "bc",
                                     cellType:.LabelTVCell))
            
            
            tablerow.append(TableRow(moreData:vocherdata1?.booking_details?.first?.customer_details,
                                     cellType:.BookedTravelDetailsTVCell))
        }
        
        
        
        tablerow.append(TableRow(height:35,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Thank you for booking with bab safar Your attraction \n voucher has been shared on the confirmed email.",
                                 key: "booked",
                                 cellType:.LabelTVCell))
        
        tablerow.append(TableRow(title:"Download E - Ticket",
                                 key:"booked",
                                 bgColor: .AppNavBackColor,
                                 cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:60,
                                 cellType:.EmptyTVCell))
        
        
        
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    @objc func didTapOnBackButton(_ sender:UIButton) {
        BASE_URL = BASE_URL1
        guard let vc = DBTabbarController.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        callapibool = true
        present(vc, animated: true)
    }
    
    override func btnAction(cell: ButtonTVCell) {
        let vocherpdf = "https://kuwaitways.com/mobile_webservices/index.php/voucher/flight/\(bookingRefrence)/\(bookingsource)/show_pdf"
        
        downloadAndSavePDF(showpdfurl: vocherpdf)
        
        let seconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.gotoAboutUsVC(title: "Vocher Details", url: vocherpdf)
        }
        
    }
    
    func gotoAboutUsVC(title:String,url:String) {
        guard let vc = LoadWebViewVC.newInstance.self else {return}
        vc.urlString = url
        vc.isVcFrom = "voucher"
        vc.modalPresentationStyle = .overCurrentContext
        callapibool = true
        self.present(vc, animated: true)
        
    }
    
}


extension BookingConfirmedVC {
    
    //MARK: - Flight Related Stuf
    
    func callFlightVoucherDetailsAPI() {
        DispatchQueue.main.async {[self] in
            viewmodel?.CALL_GET_VOUCHER_DETAILS_API(dictParam: [:], url: vocherurl )
        }
    }
    
    
    func redirectvocherDetails(response: GetvoucherUrlModel) {
        DispatchQueue.main.async {[self] in
            viewmodel?.CALL_GET_VOUCHER_DETAILS_API(dictParam: [:], url: response.url ?? "" )
        }
    }
    
    
    
    func vocherdetails(response: VocherModel) {
        BASE_URL = BASE_URL1
        
        vocherdata1 = response.data
        fdetails = response.flight_details?.summary ?? []
        kwdPrice = "\(response.price?.api_currency ?? ""):\(response.price?.api_total_display_fare ?? 0)"
        vouchercustomerdetails = vocherdata1?.booking_details?.first?.customer_details ?? []
        
        
        vocherdata1?.booking_details?.forEach({ i in
            bookingRefrence = i.app_reference ?? ""
            bookingsource = i.booking_source ?? ""
            bookingStatus = i.status ?? ""
        })
        
        DispatchQueue.main.async {
            self.setupTV()
        }
    }
    
    
}




extension BookingConfirmedVC {
    
    //MARK: - Hotel Related Stuf
    
    func callHotelSecureBookingAPI(){
        hotelvm?.CALL_HOTEL_VOUCHER_API(dictParam: [:], urlstr: self.vocherurl)
    }
    
    
    func hotelVoucherDetails(response: HotelVoucherModel) {
        BASE_URL = BASE_URL1
        
        hotelVoucherData = response.data
        //        fdetails = response.flight_details?.summary ?? []
        kwdPrice = "\(response.data?.booking_details?[0].currency ?? ""):\(response.data?.booking_details?[0].grand_total ?? 0.0)"
        
        
        vouchercustomerdetails = vocherdata1?.booking_details?.first?.customer_details ?? []
        
        
        vocherdata1?.booking_details?.forEach({ i in
            bookingRefrence = i.app_reference ?? ""
            bookingsource = i.booking_source ?? ""
            bookingStatus = i.status ?? ""
        })
        
        DispatchQueue.main.async {
            self.setupTV()
        }
    }
    
}


extension BookingConfirmedVC {
    
    
    
    // Function to download and save the PDF
    func downloadAndSavePDF(showpdfurl:String) {
        let urlString = showpdfurl
        
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Download Error: \(error.localizedDescription)")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("Invalid Response: \(response.debugDescription)")
                    return
                }
                
                if let pdfData = data {
                    self.savePdfToDocumentDirectory(pdfData: pdfData, fileName: "\(Date())")
                }
            }
            task.resume()
        } else {
            print("Invalid URL: \(urlString)")
        }
    }
    
    // Function to save PDF data to the app's document directory
    func savePdfToDocumentDirectory(pdfData: Data, fileName: String) {
        do {
            let resourceDocPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
            let pdfName = "Kuwaitways-\(fileName).pdf"
            let destinationURL = resourceDocPath.appendingPathComponent(pdfName)
            try pdfData.write(to: destinationURL)
            
            
        } catch {
            print("Error saving PDF to Document Directory: \(error)")
        }
    }
    
    
    
}
