//
//  AddCityTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 19/08/22.
//

import UIKit

protocol AddCityTVCellDelegate {
    
    func didTapOnFromBtn(cell:MulticityFromToTVCell)
    func didTapOnToBtn(cell:MulticityFromToTVCell)
    func didTapOndateBtn(cell:MulticityFromToTVCell)
    func didTapOnCloseBtn(cell:MulticityFromToTVCell)
    func didTapOnAddCityBtn(cell:AddCityTVCell)
    func didTapOnAddTravellerEconomy(cell:AddCityTVCell)
    func didTapOnMultiCityTripSearchFlight(cell:AddCityTVCell)
    
    
    func donedatePicker(cell:MulticityFromToTVCell)
    func donedatePicker(cell:AddCityTVCell)
    func cancelDatePicker(cell:AddCityTVCell)
    func didTapOnSelectAirlineBtnAction(cell:AddCityTVCell)
}

class AddCityTVCell: TableViewCell, MulticityFromToTVCellDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var addCityTV: UITableView!
    @IBOutlet weak var addCityTVHeight: NSLayoutConstraint!
    @IBOutlet weak var addCityBtn: UIButton!
    
    @IBOutlet weak var traView: UIView!
    @IBOutlet weak var tralbl: UILabel!
    @IBOutlet weak var searchFlightView: UIView!
    @IBOutlet weak var addCityView: UIView!
    @IBOutlet weak var airlinelbl: UILabel!
    
    
    
    var datecellTag = Int()
    let depDatePicker = UIDatePicker()
    var count = 0
    var delegate:AddCityTVCellDelegate?
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
        self.airlinelbl.text = "\(defaults.string(forKey: UserDefaultsKeys.nationality) ?? "ALL")"
        updateheight()
    }
    
    func setupUI() {
        
        //  holderView.backgroundColor = .AppHolderViewColor
        addCityTVHeight.constant = 110
        
        tralbl.text = defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? ""
        traView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 4)
        searchFlightView.addCornerRadiusWithShadow(color: HexColor("#254179",alpha: 0.10), borderColor: .clear, cornerRadius: 8)
        tralbl.numberOfLines = 2
        setupTV()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: NSNotification.Name("reload"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(travellerMulticity), name: NSNotification.Name("calreloadTV"), object: nil)
        
    }
    
    
    @objc func travellerMulticity() {
        tralbl.text = defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? ""
        updateheight()
    }
    
    
    @objc func reload(notification: NSNotification){
        updateheight()
    }
    
    
    func setupTV() {
        
        addCityTV.register(UINib(nibName: "MulticityFromToTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        addCityTV.delegate = self
        addCityTV.dataSource = self
        addCityTV.tableFooterView = UIView()
        addCityTV.separatorStyle = .none
        addCityTV.backgroundColor = .AppHolderViewColor
        addCityTV.isScrollEnabled = false
        
    }
    
    
    func didTapOnFromBtn(cell: MulticityFromToTVCell) {
        defaults.set(cell.fromBtn.tag, forKey: UserDefaultsKeys.cellTag)
        delegate?.didTapOnFromBtn(cell: cell)
    }
    
    func didTapOnToBtn(cell: MulticityFromToTVCell) {
        defaults.set(cell.toBtn.tag, forKey: UserDefaultsKeys.cellTag)
        delegate?.didTapOnToBtn(cell: cell)
    }
    
    func didTapOndateBtn(cell: MulticityFromToTVCell) {
        defaults.set(cell.dateBtn.tag, forKey: UserDefaultsKeys.cellTag)
        delegate?.didTapOndateBtn(cell: cell)
    }
    
    
    func updateheight() {
        addCityTVHeight.constant = CGFloat(55 * (fromCityNameArray.count))
        addCityTV.reloadData()
    }
    
    @IBAction func didTapOnAddCityBtn(_ sender: Any) {
        count += 1
        if fromCityNameArray.count >= 5 {
            addCityView.isHidden = true
            
        }else {
            
            fromCityNameArray.append("From")
            toCityNameArray.append("To")
            fromCityCodeArray.append("From")
            toCityCodeArray.append("To")
            fromlocidArray.append("")
            tolocidArray.append("")
            depatureDatesArray.append("Date")
            
            fromCityShortNameArray.append("From")
            toCityShortNameArray.append("To")
            
            DispatchQueue.main.async {[self] in
                updateheight()
                NotificationCenter.default.post(name: Notification.Name("addcity"), object: nil)
            }
            
            
            if fromCityCodeArray.count == 5 {
                addCityView.isHidden = true
            }
            
        }
        
        delegate?.didTapOnAddCityBtn(cell: self)
    }
    
    
    func didTapOnCloseBtn(cell: MulticityFromToTVCell) {
        
        fromlocidArray.remove(at: cell.closeBtn.tag)
        tolocidArray.remove(at: cell.closeBtn.tag)
        fromCityCodeArray.remove(at: cell.closeBtn.tag)
        toCityCodeArray.remove(at: cell.closeBtn.tag)
        depatureDatesArray.remove(at: cell.closeBtn.tag)
        fromCityNameArray.remove(at: cell.closeBtn.tag)
        toCityNameArray.remove(at: cell.closeBtn.tag)
        
        
        fromCityShortNameArray.remove(at: cell.closeBtn.tag)
        toCityShortNameArray.remove(at: cell.closeBtn.tag)
        
        
        //---------------
        
        addCityTV.deleteRows(at: [IndexPath(item: cell.closeBtn.tag, section: 0)], with: .automatic)
        DispatchQueue.main.async {[self] in
            if fromCityCodeArray.count <= 5 {
                addCityView.isHidden = false
            }
        }
        
        updateheight()
        NotificationCenter.default.post(name: Notification.Name("addcity"), object: nil)
    }
    
    
    
    @IBAction func didTapOnAddTravellerBtnAction(_ sender: Any) {
        delegate?.didTapOnAddTravellerEconomy(cell: self)
    }
    
    
    
    @IBAction func didTapOnSearchFlightBtnAction(_ sender: Any) {
        delegate?.didTapOnMultiCityTripSearchFlight(cell: self)
    }
    
    
    
    @objc func didTapOnTextField(_ tf:UITextField) {
        print(tf.tag)
        defaults.set(tf.tag, forKey: UserDefaultsKeys.cellTag)
        
    }
    
    
    @IBAction func didTapOnSelectAirlineBtnAction(_ sender: Any) {
        delegate?.didTapOnSelectAirlineBtnAction(cell: self)
    }

    
}


extension AddCityTVCell:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fromCityNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? MulticityFromToTVCell {
            cell.selectionStyle = .none
            cell.delegate = self
            
            if indexPath.row == 0 || indexPath.row == 1{
                cell.closeView.isHidden = true
            }else {
                cell.closeView.isHidden = false
            }
            
            
            cell.fromlbl.text = fromCityShortNameArray[indexPath.row]
            cell.tolbl.text = toCityShortNameArray[indexPath.row]
            
            //            cell.fromlbl.text = fromCityCodeArray[indexPath.row]
            //            cell.tolbl.text = toCityCodeArray[indexPath.row]
            cell.datelbl.text = depatureDatesArray[indexPath.row]
            cell.dateString = depatureDatesArray[indexPath.row]
            
            
            cell.fromBtn.tag = indexPath.row
            cell.toBtn.tag = indexPath.row
            cell.dateBtn.tag = indexPath.row
            cell.closeBtn.tag = indexPath.row
            cell.dateTF.tag = indexPath.row
            
            cell.dateTF.addTarget(self, action: #selector(didTapOnTextField(_:)), for: .editingDidBegin)
            showdepDatePicker(cell: cell)
            
            c = cell
        }
        return c
    }
    
    
    //MARK: - showdepDatePicker
    func showdepDatePicker(cell:MulticityFromToTVCell){
        
        
        //Formate Date
        depDatePicker.datePickerMode = .date
        depDatePicker.minimumDate = Date()
        depDatePicker.preferredDatePickerStyle = .wheels
        
        let formter = DateFormatter()
        formter.dateFormat = "dd-MM-yyyy"
        
        
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker))
        //  let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker(_:)))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        cell.dateTF.inputAccessoryView = toolbar
        cell.dateTF.inputView = depDatePicker
        
        
    }
    
    @objc func donedatePicker(){
        delegate?.donedatePicker(cell:self)
        
        // Update the selected date when the date picker is done
        selectedDate = depDatePicker.date
        
        // Update the minimum date of the date picker
        depDatePicker.minimumDate = selectedDate
        
        
        
        // Reload the table view to update the date pickers
        addCityTV.reloadData()
    }
    
    
    
    
    @objc func cancelDatePicker(){
        delegate?.cancelDatePicker(cell:self)
    }
    
    
    
    // Function to format date as string
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: date)
    }
    
}
