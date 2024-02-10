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
        setuUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
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
        let nib = UINib(nibName: "HotelDealsCVCell", bundle: nil)
        dealsCV.register(nib, forCellWithReuseIdentifier: "cell")
        dealsCV.delegate = self
        dealsCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 156, height: 190)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        dealsCV.collectionViewLayout = layout
        dealsCV.layer.cornerRadius = 4
        dealsCV.clipsToBounds = true
        dealsCV.showsHorizontalScrollIndicator = false
        dealsCV.bounces = false
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
        if self.key == "offer" {
           
            
            if offercase == .flight {
                return sliderimagesflight.count
            }else  if offercase == .flight {
                return sliderimageshotel.count
            }else {
                return sliderimageshotel.count
            }
                
            
            
        }else if self.key == "flight" {
            return sliderimagesflight.count
        }else {
            return sliderimageshotel.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HotelDealsCVCell {
            
            if self.key == "offer" {
                
                
                
                switch offercase {
                case .flight:
                    
                    setSelectedColor(btn: flightBtn)
                    setUnSelectedColor(btn: hotelbtn)
                    setUnSelectedColor(btn: sportbtn)
                    
                    let data = sliderimagesflight[indexPath.row]
                    offerTabsView.isHidden = false
                    cell.dealsImg.sd_setImage(with: URL(string: "\(imgPath )\(data.image ?? "")"), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
                    cell.citylbl.text = "\(data.from_city_name ?? "") - \(data.from_city_loc ?? "")"
                    cell.countrylbl.text = data.from_country
                    cell.kwdlbl.text = "\(currencyType) \(data.price ?? "")"
                    
                    break
                    
                case .hotel:
                    setSelectedColor(btn: hotelbtn)
                    setUnSelectedColor(btn: flightBtn)
                    setUnSelectedColor(btn: sportbtn)
                    
                    
                    let data = sliderimagesflight[indexPath.row]
                    
                    cell.dealsImg.sd_setImage(with: URL(string: "\(imgPath )\(data.image ?? "")"), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
                    cell.citylbl.text = "\(data.from_city_name ?? "") - \(data.from_city_loc ?? "")"
                    cell.countrylbl.text = data.from_country
                    cell.kwdlbl.text = "\(currencyType) \(data.price ?? "")"
                    
                    
                    break
                    
                case .sports:
                    setSelectedColor(btn: sportbtn)
                    setUnSelectedColor(btn: hotelbtn)
                    setUnSelectedColor(btn: flightBtn)
                    
                    let data = sliderimageshotel[indexPath.row]
                    
                    cell.dealsImg.sd_setImage(with: URL(string: "\(imgPath )\(data.image ?? "")"), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
                    cell.citylbl.text = "\(data.city_name ?? "")"
                    cell.countrylbl.text = data.country_name
                    cell.kwdlbl.text = "\(currencyType) \(data.price ?? "")"
                    
                    
                    break
                    
                    
                default:
                    break
                }
                
            }else if self.key == "flight" {
                let data = sliderimagesflight[indexPath.row]
                
                cell.dealsImg.sd_setImage(with: URL(string: "\(imgPath )\(data.image ?? "")"), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
                cell.citylbl.text = "\(data.from_city_name ?? "") - \(data.from_city_loc ?? "")"
                cell.countrylbl.text = data.from_country
                cell.kwdlbl.text = "\(currencyType) \(data.price ?? "")"
            }else {
                let data = sliderimageshotel[indexPath.row]
                
                cell.dealsImg.sd_setImage(with: URL(string: "\(imgPath )\(data.image ?? "")"), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
                cell.citylbl.text = "\(data.city_name ?? "")"
                cell.countrylbl.text = data.country_name
                cell.kwdlbl.text = "\(currencyType) \(data.price ?? "")"
                
            }
            commonCell = cell
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

