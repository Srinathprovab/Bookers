//
//  AddTravellersDetailsTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 18/08/22.
//

import UIKit
protocol AddTravellersDetailsTVCellDelegate {
    func didTapOnAddAdultBtn(cell:AddTravellersDetailsTVCell)
    func didTapOnEditBtn(cell:TitleLblTVCell)
}

class AddTravellersDetailsTVCell: TableViewCell,TitleLblTVCellDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var btnHolderView: UIView!
    @IBOutlet weak var adultlbl: UILabel!
    @IBOutlet weak var addImg: UIImageView!
    @IBOutlet weak var addAdultBtn: UIButton!
    @IBOutlet weak var addDetailsTV: UITableView!
    @IBOutlet weak var tvheight: NSLayoutConstraint!
    
    
    var detailsArray = [String]()
    var delegate:AddTravellersDetailsTVCellDelegate?
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
        titlelbl.text = cellInfo?.title
        
        let totalCount = cellInfo?.characterLimit
        if totalCount ?? 0 <= 5 {
            addAdultBtn.isUserInteractionEnabled = true
        }else {
            addAdultBtn.isUserInteractionEnabled = false
        }
        
        detailsArray = cellInfo?.data as? [String] ?? []
        tvheight.constant = CGFloat(detailsArray.count * 50)
        addDetailsTV.reloadData()
    }
    
    
    func setupUI() {
        contentView.backgroundColor = .AppBorderColor
        holderView.backgroundColor = .WhiteColor
        setupLabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: .OpenSansMedium(size: 18))
        setupLabels(lbl: adultlbl, text: "Adult", textcolor: .AppLabelColor, font: .OpenSansRegular(size: 16))
        addImg.image = UIImage(named: "add")
        setupViews(v: btnHolderView, radius: 4, color: HexColor("#5286BE", alpha: 0.20))
        addAdultBtn.setTitle("", for: .normal)
        
        setupTV()
    }
    
    
    func setupTV() {
        tvheight.constant = 0
//        addDetailsTV.layer.cornerRadius = 10
//        addDetailsTV.clipsToBounds = true
        addDetailsTV.backgroundColor = .clear
        addDetailsTV.register(UINib(nibName: "TitleLblTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        addDetailsTV.delegate = self
        addDetailsTV.dataSource = self
        addDetailsTV.tableFooterView = UIView()
        addDetailsTV.showsHorizontalScrollIndicator = false
        addDetailsTV.isScrollEnabled = false
        
    }
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.4
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    
    
    func didTapOnEditBtn(cell: TitleLblTVCell) {
        delegate?.didTapOnEditBtn(cell: cell)
    }
    
    
    
    @IBAction func didTapOnAddAdultBtn(_ sender: Any) {
        delegate?.didTapOnAddAdultBtn(cell: self)
    }
    
    
}



extension AddTravellersDetailsTVCell:UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TitleLblTVCell {
            cell.selectionStyle = .none
            cell.titlelbl.text = detailsArray[indexPath.row]
            cell.editView.isHidden = false
            cell.holderView.backgroundColor = HexColor("#5286BE", alpha: 0.20)
            cell.delegate = self
            c = cell
        }
        return c
    }
    
    
}
