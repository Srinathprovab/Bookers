//
//  BestHolidayOfferTVCell.swift
//  Boookers
//
//  Created by FCI on 15/02/24.
//

import UIKit

class BestHolidayOfferTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var dealsCV: UICollectionView!
    
    
    
    var delegate:HotelDealsTVCellDelegate?
    
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
        let nib = UINib(nibName: "HolidayOfferCVCell", bundle: nil)
        dealsCV.register(nib, forCellWithReuseIdentifier: "cell")
        dealsCV.delegate = self
        dealsCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 190, height: 190)
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



extension BestHolidayOfferTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return holiday_top_destinations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HolidayOfferCVCell {
            
            
            let data = holiday_top_destinations[indexPath.row]
            
            
            cell.img.sd_setImage(with: URL(string: "\(data.image ?? "")"), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            cell.titlelbl.text = "\(data.package_name ?? "")"
            cell.subTitlelbl.text = "3/5 Nights"
            
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

