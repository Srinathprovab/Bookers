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
}


class SelectTabTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var haiImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var tabscv: UICollectionView!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var langImg: UIImageView!
    @IBOutlet weak var langBtn: UIButton!
    @IBOutlet weak var currencylbl: UILabel!
    @IBOutlet weak var cvLeftConstraint: NSLayoutConstraint!
    
    
    var delegate:SelectTabTVCellDelegate?
    var tabNames = ["Flights","Hotels"]
    var tabImages = ["t1","t2","t3","t4","t5","t6"]
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
        
    }
    
    @objc func selectedCurrency() {
        setuplabels(lbl: currencylbl, text: defaults.string(forKey: UserDefaultsKeys.selectedCurrencyType) ?? "KWD", textcolor: .WhiteColor, font: .OpenSansRegular(size: 14), align: .left)
    }
    
    
    func setupUI() {
        
        if screenHeight > 835 {
            cvLeftConstraint.constant = 110
        }else {
            cvLeftConstraint.constant = 100
        }
        
        holderView.backgroundColor = .AppBackgroundColor
        haiImg.image = UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        langImg.image = UIImage(named: "lang")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        setuplabels(lbl: currencylbl, text: defaults.string(forKey: UserDefaultsKeys.selectedCurrencyType) ?? "KWD", textcolor: .WhiteColor, font: .OswaldSemiBold(size: 14), align: .left)
        titlelbl.text = "Welcome"
        titlelbl.textColor = .WhiteColor
        titlelbl.font = .LatoRegular(size: 24)
        langBtn.setTitle("", for: .normal)
        menuBtn.setTitle("", for: .normal)
        setupCV()
    }
    
    
    
    func setupCV() {
        holderView.backgroundColor = .AppBackgroundColor
        let nib = UINib(nibName: "SelectTabCVCell", bundle: nil)
        tabscv.register(nib, forCellWithReuseIdentifier: "cell")
        tabscv.delegate = self
        tabscv.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 85, height: 100)
        layout.scrollDirection = .vertical
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
        delegate?.didTapOnMenuBtn(cell: self)
    }
    
    
    @IBAction func didTapOnLaungageBtn(_ sender: Any) {
       // delegate?.didTapOnLaungageBtn(cell: self)
    }
    
    
}


extension SelectTabTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SelectTabCVCell {
            cell.titlelbl.text = tabNames[indexPath.row]
            cell.tabImg.image = UIImage(named: tabImages[indexPath.row])?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
            cell.bgImg.image = UIImage(named: tabImages1[indexPath.row])
            commonCell = cell
        }
        return commonCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SelectTabCVCell {
           
            if tabNames[indexPath.row] == "Flights" {
                defaults.set("Flight", forKey: UserDefaultsKeys.tabselect)
            }else {
                defaults.set("Hotel", forKey: UserDefaultsKeys.tabselect)
            }
           
            delegate?.didTapOnDashboardTab(cell: self)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SelectTabCVCell {
            cell.imgHolderView.layer.borderColor = UIColor.WhiteColor.cgColor
            cell.imgHolderView.layer.borderWidth = 0
            cell.tabImg.image = UIImage(named: tabImages[indexPath.row])?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        }
    }
    
}

