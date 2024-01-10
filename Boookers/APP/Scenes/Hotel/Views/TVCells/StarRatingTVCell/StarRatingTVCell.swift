//
//  StarRatingTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 23/08/22.
//

import UIKit
protocol StarRatingTVCellDelegate {
    func didTapOnStarRatingCell(cell:StarRatingCVCell)
}


class StarRatingTVCell: TableViewCell {
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var starratingCV: UICollectionView!
    
    var delegate:StarRatingTVCellDelegate?
    var array = ["1","2","3","4","5"]
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title
        starratingCV.reloadData()
    }
    
    func setupUI() {
        titlelbl.textColor = .AppLabelColor
        titlelbl.font = UIFont.OpenSansBold(size: 16)
        setupCV()
    }
    
    
    
    
    func setupCV() {
        let nib = UINib(nibName: "StarRatingCVCell", bundle: nil)
        starratingCV.register(nib, forCellWithReuseIdentifier: "cell")
        starratingCV.delegate = self
        starratingCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 55, height: 28)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        starratingCV.collectionViewLayout = layout
        starratingCV.backgroundColor = .clear
        starratingCV.layer.cornerRadius = 4
        starratingCV.clipsToBounds = true
        starratingCV.showsHorizontalScrollIndicator = false
        starratingCV.bounces = false

        // Select the first item when setting up the collection view
        let initialIndexPath = IndexPath(item: 0, section: 0)
        starratingCV.selectItem(at: initialIndexPath, animated: false, scrollPosition: .centeredVertically)
    }

}

extension StarRatingTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? StarRatingCVCell {
            cell.titlelbl.text = array[indexPath.row]
            
      
            
            if starRatingFilter.isEmpty == false {
                if starRatingFilter == array[indexPath.row] {
                    cell.holderview.layer.borderColor = UIColor.AppNavBackColor.cgColor
                    cell.titlelbl.textColor = .AppNavBackColor
                    collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
                }
            }else {
                cell.holderview.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
                cell.titlelbl.textColor = .AppLabelColor
            }

            
            commonCell = cell
        }
        return commonCell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? StarRatingCVCell {
            cell.holderview.layer.borderColor = UIColor.AppNavBackColor.cgColor
            cell.titlelbl.textColor = .AppNavBackColor
            delegate?.didTapOnStarRatingCell(cell: cell)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? StarRatingCVCell {
            cell.holderview.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
            cell.titlelbl.textColor = .AppLabelColor
        }
    }
    
}
