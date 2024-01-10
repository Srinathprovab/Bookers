//
//  CreateAccountVC.swift
//  BeeoonsApp
//
//  Created by MA673 on 16/08/22.
//

import UIKit
import MaterialComponents

class CreateAccountVC: BaseTableVC, RegisterUserViewModelDelegate {
    
    
    var tablerow = [TableRow]()
    static var newInstance: CreateAccountVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? CreateAccountVC
        return vc
    }
    var fname = String()
    var lname = String()
    var email = String()
    var mobile = String()
    var pass = String()
    var cpass = String()
    var payload = [String:Any]()
    var vm:RegisterUserViewModel?
    
    

    @objc func offline(notificatio:UNNotification) {
        callapibool = true
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(offline), name: NSNotification.Name("offline"), object: nil)

        
        countryCode = defaults.string(forKey: UserDefaultsKeys.mobilecountrycode) ?? ""
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: NSNotification.Name("reload"), object: nil)
    }
    
    
    @objc func reload(notification: NSNotification){
        commonTableView.beginUpdates()
        commonTableView.endUpdates()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupTV()
        vm = RegisterUserViewModel(self)
    }
    
    func setupTV() {
        
        commonTableView.registerTVCells(["EmptyTVCell",
                                         "CreateAccountTVCell",
                                         "LogoImgTVCell"])
        
        appendLoginTvcells()
    }
    
    
    func appendLoginTvcells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(height:5,cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType:.LogoImgTVCell))
        tablerow.append(TableRow(cellType:.CreateAccountTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    override func editingMDCOutlinedTextField(tf:MDCOutlinedTextField){
        setcolor(tf: tf, color: .black)
        switch tf.tag {
        case 1:
            fname = tf.text ?? ""
            break
            
        case 2:
            lname = tf.text ?? ""
            break
            
        case 3:
            email = tf.text ?? ""
            break
            
        case 4:
            mobile = tf.text ?? ""
            break
            
        case 5:
            pass = tf.text ?? ""
            break
            
        case 6:
            cpass = tf.text ?? ""
            break
        default:
            break
        }
    }
    
    
    
    override func didTapOnCountryCodeBtnAction(cell: CreateAccountTVCell) {
        countryCode = cell.countryCodeTF.text ?? ""
        
    }
    
    func setcolor(tf:MDCOutlinedTextField,color:UIColor) {
        tf.setOutlineColor(color, for: .normal)
    }
    
    
    override func didTapOnCreateAccountBtnBtnAction(cell: CreateAccountTVCell) {
        
        
        if let cell = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? CreateAccountTVCell {
            
            if fname.isEmpty == true {
                showToast(message: "Enter First Name")
                setcolor(tf: cell.fnameTF, color: .red)
            }else  if lname.isEmpty == true {
                showToast(message: "Enter Last Name")
                setcolor(tf: cell.lnameTF, color: .red)
            }else  if email.isEmpty == true {
                showToast(message: "Enter Email Address")
                setcolor(tf: cell.emailTF, color: .red)
            }else  if email.isValidEmail() == false {
                showToast(message: "Invalid Email address ")
                setcolor(tf: cell.emailTF, color: .red)
            }else if mobile.isEmpty == true {
                showToast(message: "Enter Mobile Number")
                setcolor(tf: cell.mobileTF, color: .red)
            }else if pass.isEmpty == true {
                showToast(message: "Enter Password")
                setcolor(tf: cell.createPassTF, color: .red)
                setcolor(tf: cell.createPassTF, color: .red)
            }else  if pass.isValidPassword() == false {
                showToast(message: "Enter Valid Password")
                setcolor(tf: cell.createPassTF, color: .red)
            }else  if cpass.isEmpty == true {
                showToast(message: "Enter Conform Password")
                setcolor(tf: cell.confPassTF, color: .red)
            }else  if pass != cpass {
                showToast(message: "Password Should Match")
                setcolor(tf: cell.createPassTF, color: .red)
            }else  if mobilenoMaxLengthBool == false {
                showToast(message: "Enter Valid Mobile No")
                setcolor(tf: cell.mobileTF, color: .red)
            }else {
                
                
                payload.removeAll()
                payload["email"] = email
                payload["password"] = pass
                payload["first_name"] = fname
                payload["last_name"] = lname
                payload["phone"] = mobile
                payload["about_us"] = "test"
                
                
                vm?.CALL_REGISTER_USER_API(dictParam: payload)
                
            }
            
         
        }
        
    }
    
    
    override func didTapOnBackToLoginBtnAction(cell:CreateAccountTVCell){
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.isvcfrom = "CreateAccountVC"
        self.present(vc, animated: true)
    }
    
 
    @IBAction func didTapOnSkipBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    

    
    func registerUserSucess(response: RegisterUserModel) {
        if response.status == false {
            showToast(message: response.data?.msg ?? "")
        }else {
            showToast(message: "User Registration Sucess")
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
                dismiss(animated: true)
            }
        }
    }
    
    
    
}
