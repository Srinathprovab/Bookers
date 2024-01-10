//
//  LoginVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 16/08/22.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields


import Foundation


class LoginVC: BaseTableVC, CountryListViewModelDelegate {
   
    
    var tablerow = [TableRow]()
    static var newInstance: LoginVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? LoginVC
        return vc
    }
    
    var isvcfrom = String()
    var email = String()
    var pass = String()
    var showPwdBool = true
    var payload = [String:Any]()
   
    var vm:LoginViewModel?
    var vm1:CountryListViewModel?
    
    @objc func offline(notificatio:UNNotification) {
        callapibool = true
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)
        callcountryLiatAPI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupTV()
        vm = LoginViewModel(self)
       // vm1 = CountryListViewModel(self)
    }
    
    func callcountryLiatAPI() {
        vm1?.CALL_GET_COUNTRY_LIST_API(dictParam: [:])
    }
    
    func countryList(response: CountryListModel) {
        countrylist = response.country_list ?? []
       
        DispatchQueue.main.async {
            
        }
    }
    
    func setupTV() {
        
        commonTableView.registerTVCells(["EmptyTVCell",
                                         "LogoImgTVCell",
                                         "LoginTitleTVCell",
                                         "TextfieldTVCell",
                                         "RadioButtonTVCell",
                                         "ButtonTVCell",
                                         "UnderLineTVCell",
                                         "SignUpWithTVCell",
                                         "LabelWithButtonTVCell"])
        
        appendLoginTvcells()
    }
    
    
    func appendLoginTvcells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(height:80,cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType:.LogoImgTVCell))
        tablerow.append(TableRow(title:"Login Account",subTitle: "Hello , welcome back to our account !",key: "login",cellType:.LoginTitleTVCell))
        tablerow.append(TableRow(title:"Email Address*",text:"1", tempText: "Email Address",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Password*",key:"pass", text:"2", tempText: "Password",cellType:.TextfieldTVCell))
        
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Login",cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        //        tablerow.append(TableRow(cellType:.UnderLineTVCell))
        //        // tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        //        tablerow.append(TableRow(cellType:.SignUpWithTVCell))
        //        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Not register yet?",subTitle: "",key: "acccreate", tempText: "Create Account",cellType:.LabelWithButtonTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    override func editingTextField(tf: UITextField) {
        
        switch tf.tag {
        case 1:
            email = tf.text ?? ""
            break
            
        case 2:
            pass = tf.text ?? ""
            break
            
        default:
            break
        }
    }
    
    
    
    
    override func btnAction(cell: ButtonTVCell){
        
        
        let positionsCount = commonTableView.numberOfRows(inSection: 0)
        
        for position in 0..<positionsCount {
            // Fetch the cell for the given position
            if let cell = commonTableView.cellForRow(at: IndexPath(row: position, section: 0)) as? TextfieldTVCell {
                
                if email.isEmpty == true {
                    showToast(message: "Enter Email Address")
                    if cell.txtField.tag == 1 {
                        cell.txtField.setOutlineColor(.red, for: .normal)
                        cell.txtField.setOutlineColor(.red, for: .editing)
                    }
                }else  if email.isValidEmail() == false {
                    showToast(message: "Inavlid Email address")
                    if cell.txtField.tag == 1 {
                        cell.txtField.setOutlineColor(.red, for: .editing)
                        cell.txtField.setOutlineColor(.red, for: .editing)
                    }
                }else if pass.isEmpty == true {
                    showToast(message: "Enter Password")
                    if cell.txtField.tag == 2 {
                        cell.txtField.setOutlineColor(.red, for: .normal)
                        cell.txtField.setOutlineColor(.red, for: .editing)
                    }
                }else {
                    
                    payload.removeAll()
                    payload["username"] = email
                    payload["password"] = pass
                    vm?.CALL_LOGIN_API(dictParam: payload)
                }
                
            }
        }
        
        
    }
    
    override func didTapOnShowPasswordBtn(cell:TextfieldTVCell){
        
        if showPwdBool == true {
            cell.showPassImg.image = UIImage(named: "showpass")
            cell.txtField.isSecureTextEntry = false
            showPwdBool = false
        }else {
            cell.txtField.isSecureTextEntry = true
            cell.showPassImg.image = UIImage(named: "hidepass")
            showPwdBool = true
        }
        
    }
    
    
    override func didTapOnForGetPassword(cell:TextfieldTVCell){
        guard let vc = ResetPasswordVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    override func didTapOnGoogleBtn(cell: SignUpWithTVCell){
        print("didTapOnGoogleBtn")
    }
    
    
    override func didTapOnBackToCreateAccountBtn(cell: LabelWithButtonTVCell) {
        guard let vc = CreateAccountVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    func gotodashBoardScreen() {
        guard let vc = DBTabbarController.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        callapibool = true
        present(vc, animated: true)
    }
    
    @IBAction func didTapOnSkipBtn(_ sender: Any) {
        if isvcfrom == "ViewController" {
            defaults.set(false, forKey: UserDefaultsKeys.loggedInStatus)
            gotodashBoardScreen()
        }else if isvcfrom == "CreateAccountVC" {
            self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }else  {
            dismiss(animated: false)
        }
        
    }
    
    
    
}



extension LoginVC:LoginViewModelDelegate {
    
    func loginSucess(response: LoginModel) {
        if response.status == false {
            showToast(message: response.data ?? "")
            defaults.set(false, forKey: UserDefaultsKeys.loggedInStatus)
        }else {
            showToast(message: response.data ?? "")
            userLogedDetails = response
            defaults.set(true, forKey: UserDefaultsKeys.loggedInStatus)
            defaults.set(response.user_id, forKey: UserDefaultsKeys.userid)
            defaults.set("\(response.first_name ?? "") \(response.last_name ?? "")", forKey: UserDefaultsKeys.username)
            defaults.set(response.image, forKey: UserDefaultsKeys.userimg)
            
            defaults.set(response.email, forKey: UserDefaultsKeys.useremail)
            defaults.set(response.country_code, forKey: UserDefaultsKeys.usermobilecode)
            defaults.set(response.phone, forKey: UserDefaultsKeys.usermobile)
            
            
            
            NotificationCenter.default.post(name: NSNotification.Name("logindon"), object: nil)
            
            
            let seconds = 1.0
            if isvcfrom == "ViewController" {
                loginmenubool = true
                gotodashBoardScreen()
            }else {
                callapibool = false
                dismiss(animated: true)
            }
        }
    }
    
    
}
