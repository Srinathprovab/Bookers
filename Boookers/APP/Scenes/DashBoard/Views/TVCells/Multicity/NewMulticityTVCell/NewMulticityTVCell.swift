//
//  NewMulticityTVCell.swift
//  KuwaitWays
//
//  Created by FCI on 11/12/23.
//

import UIKit

protocol NewMulticityTVCellDelegate {
    func didTapOnFromBtn(cell:NewMulticityTVCell)
    func didTapOnToBtn(cell:NewMulticityTVCell)
    func didTapOndateBtn(cell:NewMulticityTVCell)
}

class NewMulticityTVCell: TableViewCell {
    
    
    @IBOutlet weak var addCityView: UIView!
    @IBOutlet weak var citycard3: UIStackView!
    @IBOutlet weak var citycard4: UIStackView!
    @IBOutlet weak var closeBtn3: UIButton!
    @IBOutlet weak var closeBtn4: UIButton!
    @IBOutlet weak var addCityViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var from1lbl: UILabel!
    @IBOutlet weak var from1btn: UIButton!
    @IBOutlet weak var to1lbl: UILabel!
    @IBOutlet weak var to1btn: UIButton!
    @IBOutlet weak var date1lbl: UILabel!
    @IBOutlet weak var date1btn: UIButton!
    
    @IBOutlet weak var from2btn: UIButton!
    @IBOutlet weak var to2btn: UIButton!
    @IBOutlet weak var date2btn: UIButton!
    
    @IBOutlet weak var from3btn: UIButton!
    @IBOutlet weak var to3btn: UIButton!
    @IBOutlet weak var date3btn: UIButton!
    
    @IBOutlet weak var from4btn: UIButton!
    @IBOutlet weak var to4btn: UIButton!
    @IBOutlet weak var date4btn: UIButton!
    
    
    
    
    var count = 2
    var delegate:NewMulticityTVCellDelegate?
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
        
//        cell.fromlbl.text = fromCityCodeArray[indexPath.row]
//        cell.tolbl.text = toCityCodeArray[indexPath.row]
//        cell.datelbl.text = depatureDatesArray[indexPath.row]
        
        
        if fromCityNameArray.count > 0 {
            from1lbl.text = fromCityNameArray[0]
            to1lbl.text = toCityNameArray[0]
          //  date1lbl.text = fromCityCodeArray[0]
        }
           
        
    }
    
    
    func setupUI() {
        
        from1btn.addTarget(self, action: #selector(didTapOnFromBtn(_:)), for: .touchUpInside)
        to1btn.addTarget(self, action: #selector(didTapOnToBtn(_:)), for: .touchUpInside)
        date1btn.addTarget(self, action: #selector(didTapOndateBtn(_:)), for: .touchUpInside)
        
        from2btn.addTarget(self, action: #selector(didTapOnFromBtn(_:)), for: .touchUpInside)
        to2btn.addTarget(self, action: #selector(didTapOnToBtn(_:)), for: .touchUpInside)
        date2btn.addTarget(self, action: #selector(didTapOndateBtn(_:)), for: .touchUpInside)
        
        from3btn.addTarget(self, action: #selector(didTapOnFromBtn(_:)), for: .touchUpInside)
        to3btn.addTarget(self, action: #selector(didTapOnToBtn(_:)), for: .touchUpInside)
        date3btn.addTarget(self, action: #selector(didTapOndateBtn(_:)), for: .touchUpInside)
        
        from4btn.addTarget(self, action: #selector(didTapOnFromBtn(_:)), for: .touchUpInside)
        to4btn.addTarget(self, action: #selector(didTapOnToBtn(_:)), for: .touchUpInside)
        date4btn.addTarget(self, action: #selector(didTapOndateBtn(_:)), for: .touchUpInside)

    }
    
    
    
    
    @objc func didTapOnFromBtn(_ sender:UIButton) {
        defaults.set(sender.tag, forKey: UserDefaultsKeys.cellTag)
        delegate?.didTapOnFromBtn(cell: self)
    }
    
    @objc func didTapOnToBtn(_ sender:UIButton) {
        defaults.set(sender.tag, forKey: UserDefaultsKeys.cellTag)
        delegate?.didTapOnToBtn(cell: self)
    }
    
    @objc func didTapOndateBtn(_ sender:UIButton) {
        defaults.set(sender.tag, forKey: UserDefaultsKeys.cellTag)
        delegate?.didTapOndateBtn(cell: self)
    }
    
    
    
    @IBAction func closecard3BtnAction(_ sender: Any) {
        count -= 1
        citycard3.isHidden = true
        addCityView.isHidden = false
        addCityViewHeight.constant = 40
        NotificationCenter.default.post(name: NSNotification.Name("addcity"), object: nil)
    }
    
    @IBAction func closecard4BtnAction(_ sender: Any) {
        count -= 1
        addCityView.isHidden = false
        addCityViewHeight.constant = 40
        citycard4.isHidden = true
        
//        fromlocidArray.remove(at: (sender as AnyObject).tag)
//        tolocidArray.remove(at: (sender as AnyObject).tag)
//        fromCityCodeArray.remove(at: (sender as AnyObject).tag)
//        toCityCodeArray.remove(at: (sender as AnyObject).tag)
//        depatureDatesArray.remove(at: (sender as AnyObject).tag)
//        fromCityNameArray.remove(at: (sender as AnyObject).tag)
//        toCityNameArray.remove(at: (sender as AnyObject).tag)
        
        
        NotificationCenter.default.post(name: NSNotification.Name("addcity"), object: nil)
    }
    
    
    
    
    @IBAction func didTapOnAddCityBtnAction(_ sender: Any) {
        count += 1
        
        if count <= 4 {
            
            switch count {
            case 3:
                citycard3.isHidden = false
                citycard4.isHidden = true
                break
                
            case 4:
                citycard3.isHidden = false
                citycard4.isHidden = false
                addCityView.isHidden = true
                addCityViewHeight.constant = 0
                break
                
            default:
                break
            }
        }
        
        
        NotificationCenter.default.post(name: NSNotification.Name("addcity"), object: nil)
        
    }
    
    
}
