//
//  HotelImagesTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 22/08/22.
//

import UIKit

class HotelImagesTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var hotelImg: UIImageView!
    @IBOutlet weak var hotelImagesCV: UICollectionView!
    
    var imgs = [Images]()
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
        imgs = cellInfo?.moreData as! [Images]
        self.hotelImg.sd_setImage(with: URL(string: cellInfo?.image ?? ""),placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
        
        hotelImagesCV.reloadData()
    }
    
    
    func setupCV() {
        
        
        
        holderView.backgroundColor = .WhiteColor
        holderView.layer.cornerRadius = 6
        holderView.clipsToBounds = true
        holderView.layer.borderWidth = 0.4
        holderView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
        
        hotelImg.layer.cornerRadius = 6
        hotelImg.clipsToBounds = true
        hotelImg.contentMode = .scaleToFill
        hotelImg.image = UIImage(named: "bird")
        
        let nib = UINib(nibName: "HotelImageCVCell", bundle: nil)
        hotelImagesCV.register(nib, forCellWithReuseIdentifier: "cell")
        hotelImagesCV.delegate = self
        hotelImagesCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        
        let screenHeight = UIScreen.main.bounds.size.height
        if screenHeight > 835 {
            layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        }else {
            layout.sectionInset = UIEdgeInsets(top: 16, left: 5, bottom: 16, right: 5)
        }
        hotelImagesCV.collectionViewLayout = layout
        hotelImagesCV.backgroundColor = .clear
        hotelImagesCV.layer.cornerRadius = 4
        hotelImagesCV.clipsToBounds = true
        hotelImagesCV.showsHorizontalScrollIndicator = false
        hotelImagesCV.bounces = false
        
    }
    
}


extension HotelImagesTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HotelImageCVCell {
            cell.hotelImg.image = UIImage(named: "hotel1")
            
            cell.hotelImg.sd_setImage(with: URL(string: imgs[indexPath.row].img ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            commonCell = cell
        }
        return commonCell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? HotelImageCVCell {
            self.hotelImg.image = cell.hotelImg.image
        }
    }
    
}
