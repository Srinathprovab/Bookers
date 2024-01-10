//
//  HotelDealsTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 16/08/22.
//

import UIKit
import SDWebImage


class HotelDealsTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var dealsCV: UICollectionView!
    
    
    var key = String()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        self.key = cellInfo?.key1 ?? ""
       
        dealsCV.reloadData()
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
    
}



extension HotelDealsTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.key == "flight" {
            return sliderimagesflight.count
        }else {
            return sliderimageshotel.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HotelDealsCVCell {
            
            if self.key == "flight" {
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
    
    
}

