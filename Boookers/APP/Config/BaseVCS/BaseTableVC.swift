//
//  BaseTableVC.swift
//  Clique
//
//  Created by Codebele-03 on 03/06/21.
//

import UIKit
import MaterialComponents

class BaseTableVC: UIViewController, ButtonTVCellDelegate,TextfieldTVCellDelegate, SelectGenderTVCellDelegate, RadioButtonTVCellDelegate, SignUpWithTVCellDelegate, MenuBGTVCellDelegate,LabelWithButtonTVCellDelegate, SelectTabTVCellDelegate, SearchFlightTVCellDelegate, TravellerEconomyTVCellDelegate, SearchFlightResultInfoTVCellDelegate, BookNowTVCellDelegate, TDetailsLoginTVCellDelegate,PromocodeTVCellDelegate, PriceSummaryTVCellDelegate, AddTravellersDetailsTVCellDelegate, CheckBoxTVCellDelegate,MultiCityTripTVCellDelegate, HotelSearchResultTVCellDelegate, RoomsTVCellDelegate, StarRatingTVCellDelegate, ChooseProfilPpictureTVCellDelegate,checkOptionsTVCellDelegate, AboutusTVCellDelegate, RoundTripTVcellDelegate, SortByPriceTVCellDelegate, SliderTVCellDelegate, ContactInformationTVCellDelegate,AcceptTermsAndConditionTVCellDelegate, FareRulesTVCellDelegate, MyBookingsTVCellsDelegate, CreateAccountTVCellDelegate, AddCityTVCellDelegate, AddDeatilsOfTravellerTVCellDelegate, CommonTVAddTravellerTVCellDelegate, AddDeatilsOfGuestTVCellDelegate, BillingAddressTVCellDelegate, AdvancedSearchTVCellDelegate, NewMulticityTVCellDelegate, ContactUsTVCellDelegate {
   
    
    
    
    @IBOutlet weak var commonScrollView: UITableView!
    @IBOutlet weak var commonTableView: UITableView!
    @IBOutlet weak var commonTVTopConstraint: NSLayoutConstraint!
    
    
    var commonTVData = [TableRow]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Disable vertical bounce
        commonTableView.bounces = false
        
        self.modalPresentationCapturesStatusBarAppearance = true
        self.navigationController?.navigationBar.isHidden = true
        configureTableView()
        //        self.automaticallyAdjustsScrollViewInsets = false
        
        // Do any additional setup after loading the view.
    }
    
    
    func configureTableView() {
        if commonTableView != nil {
            makeDefaultConfigurationForTable(tableView: commonTableView)
        } else {
            print("commonTableView is nil")
        }
    }
    
    func makeDefaultConfigurationForTable(tableView: UITableView) {
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()
        
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        } else {
            // Fallback on earlier versions
        }
    }
    
    func serviceCall_Completed_ForNoDataLabel(noDataMessage: String? = nil, data: [Any]? = nil, centerVal:CGFloat? = nil, color: UIColor = HexColor("#182541")) {
        dealWithNoDataLabel(message: noDataMessage, data: data, centerVal: centerVal ?? 2.0, color: color)
    }
    
    func dealWithNoDataLabel(message: String?, data: [Any]?, centerVal: CGFloat = 2.0, color: UIColor = HexColor("#182541")) {
        if commonTableView == nil { return; }
        
        commonTableView.viewWithTag(100)?.removeFromSuperview()
        
        if let message = message, let data = data {
            if data.count == 0 {
                let tableSize = commonTableView.frame.size
                
                let label = UILabel(frame: CGRect(x: 15, y: 15, width: tableSize.width, height: 60))
                label.center = CGPoint(x: (tableSize.width/2), y: (tableSize.height/centerVal))
                label.tag = 100
                label.numberOfLines = 0
                
                label.textAlignment = NSTextAlignment.center
                //                label.font = UIFont.CircularStdMedium(size: 14)
                label.textColor = color
                label.text = message
                
                commonTableView.addSubview(label)
            }
        }
        
    }
    
    
    //Delegate Methods
    func btnAction(cell: ButtonTVCell) {}
    func didTapOnForGetPassword(cell: TextfieldTVCell) {}
    func editingTextField(tf: UITextField) {}
    func tfeditingChanged(tf:UITextField) {}
    func didTapOnShowPasswordBtn(cell: TextfieldTVCell) {}
    func didSelectMaleRadioBtn(cell: SelectGenderTVCell) {}
    func didSelectOnFemaleBtn(cell: SelectGenderTVCell) {}
    func didTapOnSaveBtn(cell: SelectGenderTVCell) {}
    func didTapOnRadioButton(cell: RadioButtonTVCell) {}
    func didTapOnGoogleBtn(cell: SignUpWithTVCell) {}
    func didTapOnLoginBtn(cell: MenuBGTVCell) {}
    func didTapOnEditProfileBtn(cell: MenuBGTVCell) {}
    func didTapOnCountryCodeDropDownBtn(cell:TextfieldTVCell){}
    func didTapOnBackToLoginBtn(cell: LabelWithButtonTVCell) {}
    func didTapOnBackToCreateAccountBtn(cell: LabelWithButtonTVCell) {}
    func didTapOnDashboardTab(cell: SelectTabTVCell) {}
    func didTapOnFromCity(cell: HolderViewTVCell) {}
    func didTapOnToCity(cell: HolderViewTVCell) {}
    func didTapOnAddRooms(cell:HolderViewTVCell){}
    func didTapOnSelectDepDateBtn(cell: DualViewTVCell) {}
    func didTapOnSelectRepDateBtn(cell: DualViewTVCell) {}
    func didTapOnDecrementButton(cell: TravellerEconomyTVCell) {}
    func didTapOnIncrementButton(cell: TravellerEconomyTVCell) {}
    func didTapOnAddTravelerEconomy(){}
    func didTapOnSearchFlightsBtn(cell:SearchFlightTVCell){}
    func didTapOnRefunduableBtn(cell: SearchFlightResultInfoTVCell) {}
    func didTapOnBookNowBtn(cell: BookNowTVCell) {}
    func didTapOnLoginBtn(cell: TDetailsLoginTVCell) {}
    func didTapOnApplyBtn(cell: PromocodeTVCell) {}
    func didTapOnRefundBtn(cell: PriceSummaryTVCell) {}
    func didTapOnAddAdultBtn(cell: AddTravellersDetailsTVCell) {}
    func didTapOnCheckBoxDropDownBtn(cell: CheckBoxTVCell) {}
    func didTapOnShowMoreBtn(cell: CheckBoxTVCell) {}
    func didTapOnFromBtn(cell:MulticityFromToTVCell){}
    func didTapOnToBtn(cell:MulticityFromToTVCell){}
    func didTapOndateBtn(cell:MulticityFromToTVCell){}
    func didTapOnCloseBtn(cell:MulticityFromToTVCell){}
    func didTapOnAddTravellerEconomy(cell:HolderViewTVCell){}
    func didTapOnMultiCityTripSearchFlight(cell:ButtonTVCell){}
    func didTapOnLocationOrCityBtn(cell:HolderViewTVCell){}
    func didtapOnCheckInBtn(cell:DualViewTVCell){}
    func didtapOnCheckOutBtn(cell:DualViewTVCell){}
    func didTapOnSearchHotelsBtn(cell:ButtonTVCell){}
    func didTapOnDetailsBtn(cell: HotelSearchResultTVCell) {}
    func didTapOnCancellationPolicyBtn(cell: TwinSuperiorRoomTVCell) {}
    func didTapOnRoomTvcell(cell:TwinSuperiorRoomTVCell) {}
    func didTapOnMenuBtn(cell:SelectTabTVCell){}
    func didTapOnLaungageBtn(cell:SelectTabTVCell){}
    func didTapOnStarRatingCell(cell: StarRatingCVCell) {}
    func didTapOnEditBtn(cell:TitleLblTVCell){}
    func donedatePicker(cell:TextfieldTVCell){}
    func cancelDatePicker(cell:TextfieldTVCell){}
    func didtapOnChooseprofilePitctureBtn(cell: ChooseProfilPpictureTVCell) {}
    func didTapOnMenuOptionBtn(cell:checkOptionsTVCell){}
    func didTapOnAboutUsLink(cell: AboutusTVCell) {}
    func didTapOnTermsLink(cell: AboutusTVCell) {}
    func didTapOnPrivacyPolicyLink(cell:AboutusTVCell){}
    func didTapOnCoockiesLink(cell: AboutusTVCell) {}
    func didTaponRoundTripCell(cell: RoundTripTVcell) {}
    func didTapOnLowToHeighBtnAction(cell: SortByPriceTVCell) {}
    func didTapOnHeighToLowBtnAction(cell: SortByPriceTVCell) {}
    func didTapOnShowSliderBtn(cell: SliderTVCell) {}
    func didTapOnCheckBox(cell: checkOptionsTVCell) {}
    func didTapOnDeselectCheckBox(cell: checkOptionsTVCell) {}
    func didTapOnRemoveTravelInsuranceBtn(cell: PriceSummaryTVCell) {}
    func didTapOnCountryCodeBtn(cell: ContactInformationTVCell) {}
    func didTapOnDropDownBtn(cell: ContactInformationTVCell) {}
    func didTapOnEditTraveller(cell: AddAdultsOrGuestTVCell) {}
    func didTapOndeleteTravellerBtnAction(cell: AddAdultsOrGuestTVCell) {}
    func didTapOnSelectAdultTraveller(Cell: AddAdultsOrGuestTVCell) {}
    
    func editingMDCOutlinedTextField(tf: UITextField) {}
   
    func didTapOnSelectNationality(){}
   
    
    func donedatePicker(cell: AddDeatilsOfTravellerTVCell) {}
    func cancelDatePicker(cell: AddDeatilsOfTravellerTVCell) {}
    func didTapOnSelectIssuingCountryBtn(cell: AddDeatilsOfTravellerTVCell) {}
    func didTapOnTitleBtnAction(cell:AddDeatilsOfTravellerTVCell) {}
    func didTapOnMealPreferenceBtn(cell: AddDeatilsOfTravellerTVCell) {}
    func didTapOnSpecialAssicintenceBtn(cell: AddDeatilsOfTravellerTVCell) {}
    
    func didTapOnTAndCAction(cell: AcceptTermsAndConditionTVCell) {}
    func didTapOnPrivacyPolicyAction(cell: AcceptTermsAndConditionTVCell) {}
    func showContentBtnAction(cell: FareRulesTVCell) {}
    func didTapOnViewVocherBtnAction(cell: MyBookingsTVCells) {}
    func didTapOnCountryCodeBtnAction(cell: CreateAccountTVCell) {}
    func didTapOnCreateAccountBtnBtnAction(cell: CreateAccountTVCell) {}
    func didTapOnBackToLoginBtnAction(cell:CreateAccountTVCell){}
   
    func didTapOnAddCityBtn(cell: AddCityTVCell) {}
    
    func didTapOnAddTravellerEconomy(cell: AddCityTVCell) {}
    func didTapOnMultiCityTripSearchFlight(cell: AddCityTVCell) {}
    func didTapOnExpandAdultViewbtnAction(cell: AddDeatilsOfTravellerTVCell) {}
    func didTapOnExpandAdultViewbtnAction(cell: AddDeatilsOfGuestTVCell) {}
    func didTapOnTitleBtnAction(cell: AddDeatilsOfGuestTVCell) {}
    func didTapOnMrBtnAction(cell: AddDeatilsOfGuestTVCell) {}
    func didTapOnMrsBtnAction(cell: AddDeatilsOfGuestTVCell) {}
    func didTapOnCountryCodeBtnAction(cell:TextfieldTVCell){}
    func editingMDCOutlinedTextField(tf: MDCOutlinedTextField) {}
    func didTapOnBillingAddressDropDownBtnAction(cell: BillingAddressTVCell) {}
    
    
    func didTapOnAirlinesSelectBtnAction(cell:AdvancedSearchTVCell){}
    func didTapOnAdvancedSearchBtnAction(cell: AdvancedSearchTVCell) {}
    func didTapOnSelectAirlines(){}
    func didTapOnGenderBtnAction(cell:TextfieldTVCell){}
    func donedatePicker(cell:SearchFlightTVCell){}
    func cancelDatePicker(cell:SearchFlightTVCell){}
    
    func didTapOnFromBtn(cell:NewMulticityTVCell){}
    func didTapOnToBtn(cell:NewMulticityTVCell){}
    func didTapOndateBtn(cell:NewMulticityTVCell){}
    
    func donedatePicker(cell:AddCityTVCell){}
    func cancelDatePicker(cell:AddCityTVCell){}
    func donedatePicker(cell:MulticityFromToTVCell){}
    func didTapOnSelectAirlineBtnAction(cell:AddCityTVCell){}
    func didTapOnMailBtnAction(cell: ContactUsTVCell) {}
    func didTapOnPhoneBtnAction(cell: ContactUsTVCell) {}
    func didTapOnAddressBtnAction(cell: ContactUsTVCell) {}
    func didTapOnSubmitBtnAction(cell: ContactUsTVCell) {}
    func textViewDidChange(textView: UITextView) {}
    func didTapOnViewDetailsBtnAction(cell:SearchFlightResultInfoTVCell){}
    func didTapOnViewDetailsBtnAction(cell: RoundTripTVcell) {}
    
   
}

extension BaseTableVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = commonTVData[indexPath.row].height
        
        if let height = height {
            return height
        }
        
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
}
extension BaseTableVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == commonTableView {
            return commonTVData.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var commonCell: TableViewCell!
        
        var data: TableRow?
        var commonTV = UITableView()
        
        if tableView == commonTableView {
            data = commonTVData[indexPath.row]
            commonTV = commonTableView
        }
        
        
        if let cellType = data?.cellType {
            switch cellType {
                
                //Sign & SignUp Cells
                
            case .EmptyTVCell:
                let cell: EmptyTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .ButtonTVCell:
                let cell: ButtonTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .TextfieldTVCell:
                let cell: TextfieldTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .SelectGenderTVCell:
                let cell: SelectGenderTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .RadioButtonTVCell:
                let cell: RadioButtonTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .LabelTVCell:
                let cell: LabelTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .SignUpWithTVCell:
                let cell: SignUpWithTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .LogoImgTVCell:
                let cell: LogoImgTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .MenuBGTVCell:
                let cell: MenuBGTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .UnderLineTVCell:
                let cell: UnderLineTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .LabelWithButtonTVCell:
                let cell: LabelWithButtonTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .SelectTabTVCell:
                let cell: SelectTabTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .HotelDealsTVCell:
                let cell: HotelDealsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .SearchFlightTVCell:
                let cell: SearchFlightTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .FromCityTVCell:
                let cell: FromCityTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .TravellerEconomyTVCell:
                let cell: TravellerEconomyTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .TitleLblTVCell:
                let cell: TitleLblTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .SearchFlightResultInfoTVCell:
                let cell: SearchFlightResultInfoTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .BookNowTVCell:
                let cell: BookNowTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .FareBreakdownTVCell:
                let cell: FareBreakdownTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .TDetailsLoginTVCell:
                let cell: TDetailsLoginTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .PromocodeTVCell:
                let cell: PromocodeTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .PriceSummaryTVCell:
                let cell: PriceSummaryTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .checkOptionsTVCell:
                let cell: checkOptionsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .AddTravellersDetailsTVCell:
                let cell: AddTravellersDetailsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .SliderTVCell:
                let cell: SliderTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .CheckBoxTVCell:
                let cell: CheckBoxTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .MultiCityTripTVCell:
                let cell: MultiCityTripTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .HotelSearchResultTVCell:
                let cell: HotelSearchResultTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .RatingWithLabelsTVCell:
                let cell: RatingWithLabelsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .FacilitiesTVCell:
                let cell: FacilitiesTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .HotelImagesTVCell:
                let cell: HotelImagesTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .RoomsTVCell:
                let cell: RoomsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .PriceLabelsTVCell:
                let cell: PriceLabelsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .SelectLanguageTVCell:
                let cell: SelectLanguageTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .StarRatingTVCell:
                let cell: StarRatingTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .ChooseProfilPpictureTVCell:
                let cell: ChooseProfilPpictureTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .MenuTitleTVCell:
                let cell: MenuTitleTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .AboutusTVCell:
                let cell: AboutusTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .AboutustitleTVCell:
                let cell: AboutustitleTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .CommonTVCell:
                let cell: CommonTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .RoundTripTVcell:
                let cell:  RoundTripTVcell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .SortByPriceTVCell:
                let cell:  SortByPriceTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .AddItineraryTVCell:
                let cell:  AddItineraryTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .BaggageInfoTVCell:
                let cell:  BaggageInfoTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
       
                
                
            case .ContactInformationTVCell:
                let cell: ContactInformationTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
          
                
                
            case .AcceptTermsAndConditionTVCell:
                let cell: AcceptTermsAndConditionTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .BookingConfirmedTVCell:
                let cell:  BookingConfirmedTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .BookedTravelDetailsTVCell:
                let cell:  BookedTravelDetailsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .FareRulesTVCell:
                let cell: FareRulesTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .HotelPurchaseSummaryTVCell:
                let cell:  HotelPurchaseSummaryTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .MyBookingsTVCells:
                let cell: MyBookingsTVCells = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .CreateAccountTVCell:
                let cell: CreateAccountTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .CommonBookingItinearyTVCell:
                let cell:  CommonBookingItinearyTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .AddCityTVCell:
                let cell:  AddCityTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .AddDeatilsOfTravellerTVCell:
                let cell:  AddDeatilsOfTravellerTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .AddDeatilsOfGuestTVCell:
                let cell:  AddDeatilsOfGuestTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .CommonTVAddTravellerTVCell:
                let cell:  CommonTVAddTravellerTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .LoginTitleTVCell:
                let cell: LoginTitleTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .BillingAddressTVCell:
                let cell:  BillingAddressTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .TotalNoofTravellerTVCell:
                let cell: TotalNoofTravellerTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .AdvancedSearchTVCell:
                let cell:  AdvancedSearchTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .NewMulticityTVCell:
                let cell:  NewMulticityTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .FlightPriceSummeryTVCell:
                let cell:  FlightPriceSummeryTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .ContactUsTVCell:
                let cell:  ContactUsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            default:
                print("handle this case in getCurrentCellAt")
            }
        }
        
        commonCell.cellInfo = data
        commonCell.indexPath = indexPath
        commonCell.selectionStyle = .none
        
        return commonCell
    }
} 



extension UITableView {
    func registerTVCells(_ classNames: [String]) {
        for className in classNames {
            register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: className)
        }
    }
    
    func dequeTVCell<T: UITableViewCell>(indexPath: IndexPath, osVersion: String? = nil) -> T {
        let className = String(describing: T.self) + "\(osVersion ?? "")"
        guard let cell = dequeueReusableCell(withIdentifier: className, for: indexPath) as? T  else { fatalError("Couldn’t get cell with identifier \(className)") }
        return cell
    }
    
    func dequeTVCellForFooter<T: UITableViewCell>() -> T {
        let className = String(describing: T.self)
        guard let cell = dequeueReusableCell(withIdentifier: className) as? T  else { fatalError("Couldn’t get cell with identifier \(className)") }
        return cell
    }
    
    
    
    func isLast(for indexPath: IndexPath) -> Bool {
        
        let indexOfLastSection = numberOfSections > 0 ? numberOfSections - 1 : 0
        let indexOfLastRowInLastSection = numberOfRows(inSection: indexOfLastSection) - 1
        
        return indexPath.section == indexOfLastSection && indexPath.row == indexOfLastRowInLastSection
    }
    
}
