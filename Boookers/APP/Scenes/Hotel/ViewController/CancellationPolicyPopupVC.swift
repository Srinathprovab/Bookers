//
//  CancellationPolicyPopupVC.swift
//  KuwaitWays
//
//  Created by FCI on 09/06/23.
//

import UIKit

class CancellationPolicyPopupVC: UIViewController {

    @IBOutlet weak var valuelbl: UILabel!
    @IBOutlet weak var datelbl: UILabel!
    
    static var newInstance: CancellationPolicyPopupVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? CancellationPolicyPopupVC
        return vc
    }
    
    var amount = String()
    var datetime = String()
    
    override func viewWillAppear(_ animated: Bool) {
        valuelbl.text = amount
        datelbl.text = datetime
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .black.withAlphaComponent(0.50)
    }
    
    @IBAction func didTapOnCloseBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
   
}
