//
//  FareBreakdownTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 18/08/22.
//

import UIKit

class FareBreakdownTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var fareBreakdownTV: UITableView!
    @IBOutlet weak var TVheight: NSLayoutConstraint!
    
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
        TVheight.constant = (6 * 50)
        fareBreakdownTV.reloadData()
    }
    
    func setupUI() {
        holderView.backgroundColor = .AppHolderViewColor
        setupTV()
    }
    
    func setupTV() {
       
        fareBreakdownTV.addCornerRadiusWithShadow(color: .AppBorderColor, borderColor: .clear, cornerRadius: 6)
        fareBreakdownTV.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        fareBreakdownTV.register(UINib(nibName: "TitleLblTVCell", bundle: nil), forCellReuseIdentifier: "cell1")
        fareBreakdownTV.register(UINib(nibName: "TitleLblTVCell", bundle: nil), forCellReuseIdentifier: "cell2")
        fareBreakdownTV.register(UINib(nibName: "TitleLblTVCell", bundle: nil), forCellReuseIdentifier: "cell3")
        fareBreakdownTV.register(UINib(nibName: "TitleLblTVCell", bundle: nil), forCellReuseIdentifier: "cell4")
        fareBreakdownTV.register(UINib(nibName: "TitleLblTVCell", bundle: nil), forCellReuseIdentifier: "cell5")
        fareBreakdownTV.register(UINib(nibName: "TitleLblTVCell", bundle: nil), forCellReuseIdentifier: "cell6")
        fareBreakdownTV.register(UINib(nibName: "EmptyTVCell", bundle: nil), forCellReuseIdentifier: "cell7")
        fareBreakdownTV.register(UINib(nibName: "TitleLblTVCell", bundle: nil), forCellReuseIdentifier: "cell8")

        fareBreakdownTV.delegate = self
        fareBreakdownTV.dataSource = self
        fareBreakdownTV.tableFooterView = UIView()
        fareBreakdownTV.separatorStyle = .none
        fareBreakdownTV.isScrollEnabled = false
        
    }
    
}


extension FareBreakdownTVCell :UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? TitleLblTVCell {
                cell.selectionStyle = .none
                cell.titlelbl.text = "Fare Description(KWD)"
                cell.subtitlelbl.text = cellInfo?.title
                cell.fare()
                c = cell
            }
        }else if indexPath.row == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as? TitleLblTVCell {
                cell.selectionStyle = .none
                cell.titlelbl.text = "Base Fare"
                cell.subtitlelbl.text = cellInfo?.text
                cell.fare()
                c = cell
            }
        }else if indexPath.row == 2 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell3") as? TitleLblTVCell {
                cell.selectionStyle = .none
                cell.titlelbl.text = "Tax"
                cell.subtitlelbl.text = cellInfo?.tempText
                cell.fare()
                c = cell
            }
        }else if indexPath.row == 3 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell4") as? TitleLblTVCell {
                cell.selectionStyle = .none
                cell.titlelbl.text = "Sub Total"
                cell.subtitlelbl.text = cellInfo?.buttonTitle
                cell.fare()
                c = cell
            }
        }else if indexPath.row == 4 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell5") as? TitleLblTVCell {
                cell.selectionStyle = .none
                cell.titlelbl.text = "No .Of Passengers"
                cell.subtitlelbl.text = cellInfo?.subTitle
                cell.fare()
                c = cell
            }
        }else  if indexPath.row == 5{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell6") as? TitleLblTVCell {
                cell.selectionStyle = .none
                cell.titlelbl.text = "Total (Fare Breakdown)"
                cell.subtitlelbl.text = cellInfo?.headerText
                cell.fare()
                c = cell
            }
        }
        
//        else
//
//        if indexPath.row == 6{
//            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell7") as? EmptyTVCell {
//                cell.viewHeight.constant = 10
//                c = cell
//            }
//        }
//    else {
//            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell8") as? TitleLblTVCell {
//                cell.selectionStyle = .none
//                cell.titlelbl.text = "Total (Fare Breakdown)"
//                cell.subtitlelbl.text = "\(cellInfo?.key ?? ""):\(cellInfo?.key1 ?? "")"
//                cell.tripcost()
//
//                c = cell
//            }
//        }
            
        
        
        return c
    }
    
    
}

//extension FareBreakdownTVCell {
//
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let cell =  Bundle.main.loadNibNamed("TitleLblTVCell", owner: self, options: nil)?.first as! TitleLblTVCell
//        cell.selectionStyle = .none
//        cell.titlelbl.text = "Total Trip Cost"
//        cell.subtitlelbl.text = "\(cellInfo?.key ?? ""):\(cellInfo?.key1 ?? "")"
//        cell.tripcost()
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 50
//    }
//}

