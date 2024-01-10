//
//  TextfieldTVCell.swift
//  BabSafar
//
//  Created by MA673 on 21/07/22.
//

import UIKit
import DropDown
import MaterialComponents.MaterialTextControls_OutlinedTextFields


protocol TextfieldTVCellDelegate {
    
    func didTapOnForGetPassword(cell:TextfieldTVCell)
    func editingTextField(tf:UITextField)
    func didTapOnShowPasswordBtn(cell:TextfieldTVCell)
    func didTapOnCountryCodeDropDownBtn(cell:TextfieldTVCell)
    func donedatePicker(cell:TextfieldTVCell)
    func cancelDatePicker(cell:TextfieldTVCell)
    
    func didTapOnCountryCodeBtnAction(cell:TextfieldTVCell)
    func didTapOnGenderBtnAction(cell:TextfieldTVCell)
    
}
class TextfieldTVCell: TableViewCell {
    
    @IBOutlet weak var showPassView: UIView!
    @IBOutlet weak var showPassBtn: UIButton!
    @IBOutlet weak var showPassImg: UIImageView!
    @IBOutlet weak var txtField: MDCOutlinedTextField!
    @IBOutlet weak var countrycodeTF: MDCOutlinedTextField!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var forgetPwdBtn: UIButton!
    @IBOutlet weak var btnHeight: NSLayoutConstraint!
    @IBOutlet weak var viewheight: NSLayoutConstraint!
    @IBOutlet weak var countryCodeBtn: UIButton!
    @IBOutlet weak var countryCodeBtnView: UIView!
    @IBOutlet weak var txtfildHolderView: UIStackView!
    @IBOutlet weak var btn: UIButton!
    
    
    var gender = String()
    let datePicker = UIDatePicker()
    let dropDown = DropDown()
    let genderdropDown = DropDown()
    var maxLength = 8
    var key = String()
    var delegate:TextfieldTVCellDelegate?
    
    var filterdcountrylist = [Country_list]()
    var countryNames = [String]()
    var countrycodesArray = [String]()
    var showbool1 = true
    var showbool2 = true
    var chkBool = true
    var isSearchBool = Bool()
    var searchText = String()
    var cname = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func prepareForReuse() {
        hidethings()
    }
    
    func hidethings(){
        txtField.text = cellInfo?.subTitle
        countryCodeBtnView.isHidden = true
        dropDown.hide()
        datePicker.isHidden = true
        genderdropDown.hide()
        datePicker.isHidden = true
        showPassView.isHidden = true
        btn.isHidden = true
    }
    
    
    override func updateUI() {
        
        btnHeight.constant = 0
        loadCountryNamesAndCode()
        txtField.inputView = nil
        btn.isHidden = true
        
        
        setupTextField(txtField1: txtField, tagno: Int(cellInfo?.text ?? "") ?? 0, placeholder: cellInfo?.tempText ?? "",title: cellInfo?.title ?? "",subTitle: cellInfo?.subTitle ?? "")
        setupTextField(txtField1: countrycodeTF, tagno: Int(cellInfo?.text ?? "") ?? 0, placeholder: cellInfo?.tempText ?? "",title: "Code",subTitle: defaults.string(forKey: UserDefaultsKeys.mobilecountrycode) ?? "")
        
        
        key = cellInfo?.key ?? ""
        switch cellInfo?.key {
            
            
        case "name":
            hidethings()
            break
            
        case "pwd":
            self.txtField.isSecureTextEntry = true
            break
            
        case "pass":
            self.txtField.isSecureTextEntry = true
            btnHeight.constant = 30
            forgetPwdBtn.isHidden = false
            showPassView.isHidden = false
            break
            
        case "mobile":
            countryCodeBtnView.isHidden = false
            countrycodeTF.textColor = .SubTitleColor
            txtField.textColor = .SubTitleColor
            txtfildHolderView.isUserInteractionEnabled = true
            self.txtField.keyboardType = .numberPad
            break
            
        case "email":
            txtField.textColor = .SubTitleColor
            txtfildHolderView.isUserInteractionEnabled = false
            break
            
        case "dob":
            showPassView.isHidden = false
            showPassImg.image = UIImage(named: "calender")
            datePicker.isHidden = false
            break
            
        case "passport":
            showPassView.isHidden = false
            showPassImg.image = UIImage(named: "downarrow")
            break
            
            
       
            
        case "mobile1":
            txtfildHolderView.isUserInteractionEnabled = true
            countryCodeBtnView.isHidden = false
            countrycodeTF.keyboardType = .emailAddress
            self.txtField.keyboardType = .numberPad
            break
            
        default:
            break
        }
        
        
        if cellInfo?.key1 == "mobile1" {
            
           
            txtField.isUserInteractionEnabled = true
            txtField.alpha = 1
            countrycodeTF.isUserInteractionEnabled = true
            countrycodeTF.alpha = 1
            countrycodeTF.text = cellInfo?.buttonTitle ?? ""
            
            countryCodeBtnView.isHidden = false
            txtfildHolderView.isUserInteractionEnabled = true
            
            countrycodeTF.keyboardType = .emailAddress
            self.txtField.keyboardType = .numberPad
            
            
        }else if cellInfo?.key1 == "noedit" {
            txtField.isUserInteractionEnabled = false
            txtField.alpha = 0.6
            countrycodeTF.isUserInteractionEnabled = false
            countrycodeTF.alpha = 0.6
        }else if cellInfo?.key1 == "gender" {
            genderdropDown.dataSource = ["Male","Female","Others"]
            setupGenderDropDown()
        }else {
            txtField.isUserInteractionEnabled = true
            txtField.alpha = 1
        }
        
        
        if txtField.tag == 3 {
            showDatePicker()
        }else if txtField.tag == 7{
            btn.isHidden = false
        }
    }
    
    
    func setupUI() {
        
        self.txtField.isSecureTextEntry = false
        showPassView.backgroundColor = .WhiteColor
        showPassView.isHidden = true
        showPassBtn.setTitle("", for: .normal)
        holderView.backgroundColor = .WhiteColor
        showPassImg.image = UIImage(named: "hidepass")
        
        forgetPwdBtn.setTitle("Forgot Password?", for: .normal)
        forgetPwdBtn.setTitleColor(.AppBackgroundColor, for: .normal)
        forgetPwdBtn.titleLabel?.font = UIFont.OpenSansRegular(size: 14)
        forgetPwdBtn.isHidden = true
        
        countryCodeBtnView.isHidden = true
        countryCodeBtn.isHidden = true
        setupDropDown()
        countrycodeTF.addTarget(self, action: #selector(searchTextChanged(textField:)), for: .editingChanged)
        countrycodeTF.addTarget(self, action: #selector(searchTextBegin(textField:)), for: .editingDidBegin)
        countryCodeBtn.addTarget(self, action: #selector(didTapOnCountryCodeBtnAction(_:)), for: .touchUpInside)

    }
    
    
    
    func setupTextField(txtField1:MDCOutlinedTextField,tagno:Int,placeholder:String,title:String,subTitle:String){
        
        txtField1.tag = tagno
        txtField1.label.text = title
        txtField1.text = subTitle
        txtField1.placeholder = placeholder
        txtField1.delegate = self
        txtField1.backgroundColor = .clear
        txtField1.font = UIFont.LatoRegular(size: 16)
        txtField1.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
        txtField1.label.textColor = .SubTitleColor
        txtField1.setOutlineColor( .black, for: .editing)
        txtField1.setOutlineColor( .red , for: .disabled)
        txtField1.setOutlineColor( .lightGray.withAlphaComponent(0.4) , for: .normal)
        
        
    }
    
    
    @objc func editingText(textField:UITextField) {
        
        
        txtField.setOutlineColor(.black, for: .editing)
        txtField.setOutlineColor(.black, for: .normal)
        
        if textField.tag == 4 {
            if let text = textField.text {
                let length = text.count
                if length != maxLength {
                    mobilenoMaxLengthBool = false
                }else{
                    mobilenoMaxLengthBool = true
                }
                
            } else {
                mobilenoMaxLengthBool = false
            }
        }
        
        delegate?.editingTextField(tf: textField)
    }
    
    
    
    
    
    
    func setupGenderDropDown() {
        genderdropDown.direction = .bottom
        genderdropDown.backgroundColor = .WhiteColor
        genderdropDown.anchorView = self.txtField
        genderdropDown.bottomOffset = CGPoint(x: 0, y: txtField.frame.size.height + 10)
        genderdropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.txtField.text = item
            self?.gender = item
            
            self?.delegate?.didTapOnGenderBtnAction(cell: self!)
        }
        
    }
    
    
    
    
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        
        if txtField.tag == 3 {
            txtField.inputAccessoryView = toolbar
            txtField.inputView = datePicker
        }
        
        
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        txtField.text = formatter.string(from: datePicker.date)
        delegate?.donedatePicker(cell: self)
    }
    
    @objc func cancelDatePicker(){
        delegate?.cancelDatePicker(cell: self)
    }
    
    
    @IBAction func didTapOnForGetPassword(_ sender: Any) {
        delegate?.didTapOnForGetPassword(cell: self)
    }
    
    
    @IBAction func didTapOnShowPasswordBtn(_ sender: Any) {
        delegate?.didTapOnShowPasswordBtn(cell: self)
    }
    
    
    
    
    //MARK: - loadCountryNamesAndCode
    func loadCountryNamesAndCode(){
        countryNames.removeAll()
        countrycodesArray.removeAll()
        countrylist.forEach { i in
            countryNames.append(i.name ?? "")
            countrycodesArray.append(i.country_code ?? "")
        }
        DispatchQueue.main.async {[self] in
            dropDown.dataSource = countryNames
        }
    }
    
    
    func setupDropDown() {
        
        dropDown.direction = .bottom
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.countryCodeBtnView
        dropDown.bottomOffset = CGPoint(x: 0, y: countryCodeBtnView.frame.size.height + 25)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.countrycodeTF.text = self?.countrycodesArray[index] ?? ""
            self?.countrycodeTF.resignFirstResponder()
            self?.cname = self?.countryNames[index] ?? ""
            self?.txtField.text = ""
            self?.txtField.becomeFirstResponder()
            self?.delegate?.didTapOnCountryCodeBtnAction(cell: self!)
        }
        
    }
    
    
    @objc func searchTextBegin(textField: MDCOutlinedTextField) {
        textField.text = ""
        loadCountryNamesAndCode()
        dropDown.show()
    }
    
    
    @objc func searchTextChanged(textField: MDCOutlinedTextField) {
        searchText = textField.text ?? ""
        filterContentForSearchText(searchText)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        print("Filterin with:", searchText)
        
        filterdcountrylist.removeAll()
        filterdcountrylist = countrylist.filter { thing in
            return "\(thing.name?.lowercased() ?? "")".contains(searchText.lowercased())
        }
        
        countryNames.removeAll()
        countrycodesArray.removeAll()
        filterdcountrylist.forEach { i in
            countryNames.append(i.name ?? "")
            countrycodesArray.append(i.country_code ?? "")
        }
        dropDown.dataSource = countryNames
        dropDown.show()
        
    }
    
    @IBAction func didTapOnGenderBtnAction(_ sender: Any) {
        genderdropDown.show()
    }
    
    @objc func didTapOnCountryCodeBtnAction(_ sender:UIButton) {
        dropDown.show()
    }
    
}


extension TextfieldTVCell {
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if key == "mobile" {
            maxLength = 10
            guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
                return false
            }
        } else  if key == "mobile1"{
            
            if textField == txtField{
                
                maxLength = cname.getMobileNumberMaxLength() ?? 8
                guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
                    return false
                }
            }else {
                maxLength = 10
            }
            
        } else {
            maxLength = 50
        }
        
        
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        
        return newString.length <= maxLength
    }
}
