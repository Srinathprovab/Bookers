//
//  MenuBGTVCell.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit
protocol MenuBGTVCellDelegate {
    func didTapOnLoginBtn(cell:MenuBGTVCell)
    func didTapOnEditProfileBtn(cell:MenuBGTVCell)
}

class MenuBGTVCell: TableViewCell {
    
    @IBOutlet weak var profileImageView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var editProfileView: UIView!
    @IBOutlet weak var editProfilelbl: UILabel!
    @IBOutlet weak var editProfileBtn: UIButton!
    @IBOutlet weak var editProfileViewHeight: NSLayoutConstraint!
    
    var delegate:MenuBGTVCellDelegate?
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
        let logstatus = defaults.bool(forKey: UserDefaultsKeys.loggedInStatus)
        if logstatus == true  {
           
            loginBtn.setTitle("\(profildata?.first_name ?? "") \(profildata?.last_name ?? "")", for: .normal)
            loginBtn.isUserInteractionEnabled = false
            if profildata?.image?.isEmpty == true {
                profileImage.image = UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal)
                profileImage.alpha = 0.5
            }else {
                self.profileImage.sd_setImage(with: URL(string: profildata?.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
                profileImage.alpha = 1
            }
            editProfileView.isHidden = false
            editProfileViewHeight.constant = 30
        }else {
            loginBtn.setTitle("Login/Signup", for: .normal)
            loginBtn.isUserInteractionEnabled = true
            profileImage.image = UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal)
            profileImage.alpha = 0.5
            editProfileView.isHidden = true
            editProfileViewHeight.constant = 0
        }
        
        
        
    }
    
    
    func setupUI() {
        profileImage.image = UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal)
        profileImageView.layer.cornerRadius = 50
        profileImageView.clipsToBounds = true
        
        editProfileBtn.setTitle("", for: .normal)
        loginBtn.setTitle("Login/Signup", for: .normal)
        loginBtn.setTitleColor(.WhiteColor, for: .normal)
        loginBtn.titleLabel?.font = UIFont.LatoRegular(size: 25)
        loginBtn.addTarget(self, action: #selector(didTapOnLoginBtn(_:)), for: .touchUpInside)
        loginBtn.isHidden = false
        
        
        editProfileView.backgroundColor = .AppNavBackColor
        editProfileView.layer.cornerRadius = 15
        editProfileView.clipsToBounds = true
        editProfileView.layer.borderWidth = 1
        editProfileView.layer.borderColor = UIColor.WhiteColor.cgColor
        editProfileView.isHidden = true
        editProfileViewHeight.constant = 0
        
        editProfilelbl.text = "Edit Profile"
        editProfilelbl.textColor = .WhiteColor
        editProfilelbl.font = UIFont.LatoRegular(size: 14)
        
       
    }
    
    
    @objc func didTapOnLoginBtn(_ sender:UIButton){
        delegate?.didTapOnLoginBtn(cell: self)
    }
    
    @IBAction func didTapOnEditProfileBtn(_ sender: Any) {
        delegate?.didTapOnEditProfileBtn(cell: self)
        
    }
}
