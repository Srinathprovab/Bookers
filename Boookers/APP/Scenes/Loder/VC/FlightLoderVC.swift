//
//  FlightLoderVC.swift
//  Boookers
//
//  Created by FCI on 21/02/24.
//

import UIKit

class FlightLoderVC: UIViewController {
    
    
    @IBOutlet weak var cityslbl: UILabel!
    @IBOutlet weak var dateslbl: UILabel!
    @IBOutlet weak var economylbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        cityslbl.text = "\(defaults.string(forKey: UserDefaultsKeys.fromCityCode) ?? "") To \(defaults.string(forKey: UserDefaultsKeys.toCityCode) ?? "")"
        dateslbl.text = "\(defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "")"
        economylbl.text = "\(defaults.string(forKey: UserDefaultsKeys.journeyType) ?? ""),\(defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "")"
        
    }
    

    

}
