//
//  AdvancedSearchTVCell.swift
//  KuwaitWays
//
//  Created by FCI on 18/10/23.
//

import UIKit
import DropDown

protocol AdvancedSearchTVCellDelegate {
    func didTapOnAdvancedSearchBtnAction(cell:AdvancedSearchTVCell)
    func didTapOnAirlinesSelectBtnAction(cell:AdvancedSearchTVCell)
}

class AdvancedSearchTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var advanceSearchBtn: UIButton!
    @IBOutlet weak var btnsView: UIStackView!
    @IBOutlet weak var AirlinesView: UIView!
    @IBOutlet weak var airlineslbl: UILabel!
    @IBOutlet weak var airlinesBtn: UIButton!
    @IBOutlet weak var airlinesTF: UITextField!
    
    
    
    let dropDown = DropDown()
    var airlineNameArray = [String]()
    var airlineCodeArray = [String]()
    var list = [Airline_list]()
    var filterdcountrylist = [Airline_list]()
    var vm:AirlinesListVModel?
    var showbool = true
    var delegate:AdvancedSearchTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        vm = AirlinesListVModel(self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
   
    
    func setupUI() {
        holderView.backgroundColor = HexColor("#F2F2F2",alpha: 0.50)
        advanceSearchBtn.setTitle("", for: .normal)
        advanceSearchBtn.addTarget(self, action: #selector(didTapOnAdvancedSearchBtnAction(_:)), for: .touchUpInside)
        btnsView.isHidden = true
        
        AirlinesView.backgroundColor = .AppBGcolor
        AirlinesView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 4)
        airlinesBtn.setTitle("", for: .normal)
        airlinesBtn.addTarget(self, action: #selector(didTapOnAirlinesSelectBtnAction(_:)), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(reload(_:)), name: NSNotification.Name("eco"), object: nil)
       
        setuptf(tf: airlinesTF, tag1: 1, leftpadding: 15, font: .OpenSansRegular(size: 14), placeholder: "Select Airlines")
        airlinesTF.addTarget(self, action: #selector(searchTextChanged(textField:)), for: .editingChanged)
        airlinesTF.addTarget(self, action: #selector(searchTextBegin(textField:)), for: .editingDidBegin)
    }
    
    func setuptf(tf:UITextField,tag1:Int,leftpadding:Int,font:UIFont,placeholder:String){
        tf.backgroundColor = .clear
        tf.setLeftPaddingPoints(CGFloat(leftpadding))
        tf.font = font
        tf.tag = tag1
        tf.delegate = self
    }
    
    
    @objc func reload(_ notification: NSNotification){
        airlineslbl.text = notification.userInfo?["title"] as? String
    }
    
    
    @objc func didTapOnAdvancedSearchBtnAction(_ sender:UIButton) {
        delegate?.didTapOnAdvancedSearchBtnAction(cell: self)
    }
    
    @objc func didTapOnAirlinesSelectBtnAction(_ sender:UIButton) {
        delegate?.didTapOnAirlinesSelectBtnAction(cell: self)
    }
    
    
}

extension AdvancedSearchTVCell: AirlinesListVModelDelegate{
    
    
    func callAPI() {
        vm?.CALL_GET_AIRLINE_LIST_API(dictParam: [:])
    }
    
    func airlineList(response: AirlinesListModel) {
        airlineNameArray.removeAll()
        airlineCodeArray.removeAll()
        
        list = response.airline_list ?? []
        filterdcountrylist = list
        loadCountryNamesAndCode()
        
       
        DispatchQueue.main.async {[self] in
            setupDropDown()
        }
    }
    
    
    func setupDropDown() {
        
        dropDown.dataSource = airlineNameArray
        dropDown.direction = .bottom
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.AirlinesView
        dropDown.bottomOffset = CGPoint(x: 0, y: AirlinesView.frame.size.height + 10)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            self?.airlinesTF.text = self?.airlineNameArray[index] ?? ""
            self?.airlineslbl.text = ""
            self?.airlinesTF.resignFirstResponder()
            defaults.set(self?.airlineNameArray[index] ?? "", forKey: UserDefaultsKeys.nationality)
            defaults.set(self?.airlineCodeArray[index] ?? "", forKey: UserDefaultsKeys.airlinescode)
            
        }
    }
    
    @objc func searchTextBegin(textField: UITextField) {
        airlinesTF.text = ""
        airlineslbl.text = ""
        filterdcountrylist.removeAll()
        filterdcountrylist = list
        loadCountryNamesAndCode()
        dropDown.show()
    }
    
    
    @objc func searchTextChanged(textField: UITextField) {
        filterContentForSearchText(textField.text ?? "")
    }
    
    func filterContentForSearchText(_ searchText: String) {
        print("Filterin with:", searchText)
        
        filterdcountrylist.removeAll()
        filterdcountrylist = list.filter { thing in
            return "\(thing.name?.lowercased() ?? "")".contains(searchText.lowercased())
        }
        
        loadCountryNamesAndCode()
        dropDown.show()
        
    }
    
    
    func loadCountryNamesAndCode(){
        
        airlineNameArray.removeAll()
        airlineCodeArray.removeAll()
        
        
        airlineNameArray.append("ALL")
        airlineCodeArray.append("ALL")
        filterdcountrylist.forEach { i in
            airlineNameArray.append(i.name ?? "")
            airlineCodeArray.append(i.code ?? "")
        }
        
        DispatchQueue.main.async {[self] in
            dropDown.dataSource = airlineNameArray
        }
    }
    
}

extension AdvancedSearchTVCell {
    
    //MARK - UITextField Delegates
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For mobile numer validation
        var maxLength = 50
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
       
    }
    
    
}

