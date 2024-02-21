//
//  HotelDealsTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 16/08/22.
//

import UIKit
import SDWebImage

enum offer {
    
    case flight
    case hotel
    case sports
    
}


protocol HotelDealsTVCellDelegate {
    func didTapOnFlightOfferBtnAction(cell:HotelDealsTVCell)
    func didTapOnHoteOfferlBtnAction(cell:HotelDealsTVCell)
    func didTapOnSportsOfferBtnAction(cell:HotelDealsTVCell)
}


class HotelDealsTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var dealsCV: UICollectionView!
    @IBOutlet weak var offerTabsView: UIView!
    @IBOutlet weak var flightBtn: UIButton!
    @IBOutlet weak var hotelbtn: UIButton!
    @IBOutlet weak var sportbtn: UIButton!
    
    
    var delegate:HotelDealsTVCellDelegate?
    var offercase:offer = .flight
    var key = String()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        setuUI()
        self.key = cellInfo?.key1 ?? ""
        titlelbl.text = cellInfo?.title ?? ""
        dealsCV.reloadData()
    }
    
    
    func setuUI() {
        setupCV()
    }
    
    
    func setupCV() {
        
        //  contentView.backgroundColor = .AppBGcolor
        holderView.backgroundColor = .AppBGcolor
        dealsCV.backgroundColor = .AppBGcolor
        
        if offercase == .flight {
            let nib1 = UINib(nibName: "FlightDealsCVCell", bundle: nil)
            dealsCV.register(nib1, forCellWithReuseIdentifier: "cell1")
            setupCVAttributes(cv: dealsCV)
        }else if offercase == .hotel {
       
            let nib2 = UINib(nibName: "HotelDealsCVCell", bundle: nil)
            dealsCV.register(nib2, forCellWithReuseIdentifier: "cell2")
            setupCVAttributes(cv: dealsCV)
        

        }else{
            let nib3 = UINib(nibName: "SportDealsCVCell", bundle: nil)
            dealsCV.register(nib3, forCellWithReuseIdentifier: "cell3")
            setupCVAttributes(cv: dealsCV)
        }
            
        
        func setupCVAttributes(cv:UICollectionView) {
            cv.delegate = self
            cv.dataSource = self
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 200, height: 200)
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 15
            layout.minimumLineSpacing = 15
            cv.collectionViewLayout = layout
            cv.layer.cornerRadius = 4
            cv.clipsToBounds = true
            cv.showsHorizontalScrollIndicator = false
            cv.bounces = false
        }
       
    }
    
    
 

    
    
    @IBAction func didTapOnFlightOfferBtnAction(_ sender: Any) {
        offercase = .flight
        delegate?.didTapOnFlightOfferBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnHoteOfferlBtnAction(_ sender: Any) {
        offercase = .hotel
        delegate?.didTapOnHoteOfferlBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnSportsOfferBtnAction(_ sender: Any) {
        offercase = .sports
        delegate?.didTapOnSportsOfferBtnAction(cell: self)
    }
    
    
}



extension HotelDealsTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if offercase == .flight {
            return sliderimagesflight.count
        }else  if offercase == .hotel {
            return sliderimageshotel.count
        }else {
            return sports_top_destinations.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
       
            
            if self.key == "offer" {
                
                
                offerTabsView.isHidden = false
                
                switch offercase {
                case .flight:
                    
                    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as? FlightDealsCVCell {
                        
                        setSelectedColor(btn: flightBtn)
                        setUnSelectedColor(btn: hotelbtn)
                        setUnSelectedColor(btn: sportbtn)
                        
                        let data = sliderimagesflight[indexPath.row]
                       
                        cell.img.sd_setImage(with: URL(string: "\(data.image ?? "")"), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
                        cell.fromlbl.text = "\(data.from_city_loc ?? "") -> \(data.to_city_loc ?? "")"
                        cell.tolbl.text = "\(data.travel_date ?? "") -> \(data.return_date ?? "")"
                        cell.hit_url = data.hit_url ?? ""
                       
                        commonCell = cell
                    }
                    
                    
                    
                    
                case .hotel:
                    
                    
                    
                    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as? HotelDealsCVCell {
                        
                        setSelectedColor(btn: hotelbtn)
                        setUnSelectedColor(btn: flightBtn)
                        setUnSelectedColor(btn: sportbtn)
                        
                        
                        let data = sliderimageshotel[indexPath.row]
                        
                        cell.img.sd_setImage(with: URL(string: "\(data.image ?? "")"), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
   
                        cell.titlelbl.text = "\(data.city_name ?? "")(\(data.country_name ?? ""))"
                        cell.subTitlelbl.text = data.updated_at ?? ""
                        cell.nightslbl.text = "3 Nights"
                        commonCell = cell
                    }
                   
                    
                    
                    
                case .sports:
                    
                    
                    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as? SportDealsCVCell {
                        
                        setSelectedColor(btn: sportbtn)
                        setUnSelectedColor(btn: hotelbtn)
                        setUnSelectedColor(btn: flightBtn)
                        
                        let data = sports_top_destinations[indexPath.row]
                        
                        cell.img.sd_setImage(with: URL(string: "\(imgPath )\(data.image ?? "")"), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
                        cell.titlelbl.text = data.country ?? ""
                        cell.subTitlelbl.text = data.updated_at ?? ""
                        commonCell = cell
                    }
                    
                    
                    
                    
                    
                    
                    
                default:
                    break
                }
                
            }

        return commonCell
    }
    
    
    func setSelectedColor(btn:UIButton) {
        btn.layer.cornerRadius = 4
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.AppBtnColor.cgColor
        btn.backgroundColor = .AppBtnColor
        btn.setTitleColor(.WhiteColor, for: .normal)
    }
    
    
    func setUnSelectedColor(btn:UIButton) {
        btn.layer.cornerRadius = 4
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.AppBorderColor.cgColor
        btn.backgroundColor = .WhiteColor
        btn.setTitleColor(.AppLabelColor, for: .normal)
    }
    
}

