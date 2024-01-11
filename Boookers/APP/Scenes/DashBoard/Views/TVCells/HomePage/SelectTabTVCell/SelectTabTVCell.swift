//
//  SelectTabTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 16/08/22.
//

import UIKit

protocol SelectTabTVCellDelegate {
    func didTapOnDashboardTab(cell:SelectTabTVCell)
    func didTapOnMenuBtn(cell:SelectTabTVCell)
    func didTapOnLaungageBtn(cell:SelectTabTVCell)
    func didTapOnBackBtnAction(cell:SelectTabTVCell)
}


class SelectTabTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var tabscv: UICollectionView!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var langImg: UIImageView!
    @IBOutlet weak var langBtn: UIButton!
    @IBOutlet weak var currencylbl: UILabel!
    @IBOutlet weak var imageHolderView: UIView!
    @IBOutlet weak var currencyView: UIView!
    
    var delegate:SelectTabTVCellDelegate?
    var tabNames = ["Flight","Hotel","Holidays","Insurance"]
    var tabImages = ["flightNew","hotelNew","holidaysNew","insureNew"]
    var tabImages1 = ["f1","f2","f3","f4","f5","f6"]
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
        NotificationCenter.default.addObserver(self, selector: #selector(selectedCurrency), name: NSNotification.Name("selectedCurrency"), object: nil)
        
        
        
        if cellInfo?.key == "search" {
            menuBtn.setImage(UIImage(named: "left")?.withRenderingMode(.alwaysOriginal), for: .normal)
            menuBtn.tag = 1
            imageHolderView.isHidden = true
            currencyView.isHidden = true
        }else {
            menuBtn.setImage(UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBtnColor), for: .normal)
            menuBtn.tag = 2
            imageHolderView.isHidden = false
            currencyView.isHidden = false
        }
        
        
    }
    
    @objc func selectedCurrency() {
        setuplabels(lbl: currencylbl, text: defaults.string(forKey: UserDefaultsKeys.selectedCurrencyType) ?? "KWD", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 14), align: .left)
    }
    
    
    func setupUI() {
        currencylbl.textColor = .AppLabelColor

        
        holderView.backgroundColor = .AppBackgroundColor
        setuplabels(lbl: currencylbl, text: defaults.string(forKey: UserDefaultsKeys.selectedCurrencyType) ?? "KWD", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 14), align: .left)
       
        langBtn.setTitle("", for: .normal)
        menuBtn.setTitle("", for: .normal)
        setupCV()
    }
    
    
    
    func setupCV() {
        holderView.backgroundColor = .white
        let nib = UINib(nibName: "SelectTabCVCell", bundle: nil)
        tabscv.register(nib, forCellWithReuseIdentifier: "cell")
        tabscv.delegate = self
        tabscv.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: tabscv.frame.width / 4 , height: 100)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tabscv.collectionViewLayout = layout
        tabscv.backgroundColor = .clear
        tabscv.layer.cornerRadius = 4
        tabscv.clipsToBounds = true
        tabscv.showsVerticalScrollIndicator = false
        tabscv.isScrollEnabled = false
        tabscv.bounces = false
    }
    
    
    @IBAction func didTapOnMenuBtn(_ sender: Any) {
       
        if menuBtn.tag == 1 {
            delegate?.didTapOnBackBtnAction(cell: self)
        }else {
            delegate?.didTapOnMenuBtn(cell: self)
        }
    }
    
    
    @IBAction func didTapOnLaungageBtn(_ sender: Any) {
        delegate?.didTapOnLaungageBtn(cell: self)
    }
    
    
}


extension SelectTabTVCell:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SelectTabCVCell {
            cell.titlelbl.text = tabNames[indexPath.row]
            cell.titlelbl.textColor = HexColor("#343434")
            cell.titlelbl.font = .poppinsRegular(size: 14)
            cell.bgImg.image = UIImage(named: tabImages[indexPath.row])
            
            
            if cell.titlelbl.text == defaults.string(forKey: UserDefaultsKeys.tabselect) {
                cell.selected()
                collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .top)
            }
            
            commonCell = cell
        }
        return commonCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SelectTabCVCell {
            
            cell.selected()
            defaults.set("\(cell.titlelbl.text ?? "")", forKey: UserDefaultsKeys.tabselect)
            
            self.delegate?.didTapOnDashboardTab(cell: self)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SelectTabCVCell {
            cell.deselected()
        }
    }
    
}

