//
//  FlightSearchVC.swift
//  Boookers
//
//  Created by FCI on 11/01/24.
//

import UIKit

class FlightSearchVC: BaseTableVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
    }
    

    
    func setupUI() {
        commonTableView.registerTVCells(["FlightSearchTVCell"])
        setupTVCell()
    }


    override func didTapOnAdvanceOption(cell: FlightSearchTVCell) {
        
    }
    
    override func didTapOnClassBtnAction(cell: FlightSearchTVCell) {
        
    }
    
    override func donedatePicker(cell: FlightSearchTVCell) {
        view.endEditing(true)
    }
    override func cancelDatePicker(cell: FlightSearchTVCell) {
        view.endEditing(true)
    }
    
    override func didTapOnFlightSearchBtnAction(cell: FlightSearchTVCell) {
       
    }
   
}


extension FlightSearchVC{
    
    func setupTVCell() {
        MySingleton.shared.tablerow.removeAll()
        
        MySingleton.shared.tablerow.append(TableRow(cellType:.FlightSearchTVCell))
        
        commonTVData = MySingleton.shared.tablerow
        commonTableView.reloadData()
    }
}
