//
//  ViewHotelDetailsVC.swift
//  KuwaitWays
//
//  Created by FCI on 04/05/23.
//

import UIKit

class ViewHotelDetailsVC: BaseTableVC {
    
    
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    
    
    var kwdprice = String()
    var isVcFrom = String()
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    
    
    static var newInstance: ViewHotelDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ViewHotelDetailsVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        setupTVCells(hotelDetails: hd!)
        addObserver()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() {
        
        self.view.backgroundColor = .WhiteColor
        self.holderView.backgroundColor = .AppHolderViewColor
        nav.titlelbl.text = "Hotel Details"
        nav.backBtn.addTarget(self, action: #selector(backbtnAction(_:)), for: .touchUpInside)
        
        
        if screenHeight > 835 {
            navHeight.constant = 130
        }else {
            navHeight.constant = 100
        }
        
        
        
        commonTableView.registerTVCells(["EmptyTVCell",
                                         "HotelSearchResultTVCell",
                                         "RatingWithLabelsTVCell",
                                         "FacilitiesTVCell",
                                         "HotelImagesTVCell",
                                         "RoomsTVCell"])
        
        
    }
    
    
    @objc func backbtnAction(_ sender:UIButton) {
        isFromVCBool = false
        dismiss(animated: true)
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
    
    
    override func didTapOnCancellationPolicyBtn(cell: TwinSuperiorRoomTVCell) {
        
    }
    
    
    override func didTapOnRoomTvcell(cell:TwinSuperiorRoomTVCell) {
        
    }
    
    
}



extension ViewHotelDetailsVC {
    
    func setupTVCells(hotelDetails:HotelDetailsModel) {
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:hotelDetails.hotel_details?.name,
                                 subTitle: hotelDetails.hotel_details?.address,
                                 key:"rating",
                                 characterLimit: hotelDetails.hotel_details?.star_rating,
                                 cellType:.RatingWithLabelsTVCell))
        
        
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        
        tablerow.append(TableRow(image:hotelDetails.hotel_details?.image,
                                 moreData: hotelDetails.hotel_details?.images,
                                 cellType:.HotelImagesTVCell))
        
        tablerow.append(TableRow(title:hotelDetails.hotel_details?.format_desc?[0].heading,
                                 subTitle: hotelDetails.hotel_details?.format_desc?[0].content,
                                 cellType:.RatingWithLabelsTVCell))
        
        
        
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
}



extension ViewHotelDetailsVC {
    
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
    
    
    
}
