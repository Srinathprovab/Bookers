//
//  Constants.swift
//  DoorcastRebase
//
//  Created by U Dinesh Kumar Reddy on 04/05/22.
//

import Foundation
import UIKit
import CoreData


/*SETTING USER DEFAULTS*/
let defaults = UserDefaults.standard

let loginResponseDefaultKey = "LoginResponse"
let KPlatform = "Platform"
let KPlatformValue = "iOS"
let KContentType = "Content-Type"
let KContentTypeValue = "application/x-www-form-urlencoded"
let KAccept = "Accept"
let KAcceptValue = "application/json"
let KAuthorization = "Authorization"
//let KDEVICE_ID = "DEVICE_ID"
let KAccesstoken = "Accesstoken"
let KAccesstokenValue = ""
var key = ""
let screenHeight = UIScreen.main.bounds.size.height
//var data : Data?
var loderBool = false
var basicloderBool = true

var BASE_URL = "https://boookers.com/webservice/"
var BASE_URL1 = "https://boookers.com/webservice/"
var accessToken = "e3VzZXJuYW1lOmFudWpob29kYSxwYXNzd29yZDprdXdhaXR3YXlzQG1vYmlsZWFwcCxhdXRodHlwZTp0ZXN0fQ=="

var defaultCountryCode = "+91"
var mobilenoMaxLength = Int()
var mobilenoMaxLengthBool = false

var countrylist = [Country_list]()
var currencylistArray = [SelectCurrencyData]()
var isvcfrom1 = String()
var profildata:ProfileUpdateData?
var menubool = Bool()
var loginmenubool = false
var mapModelArray: [MapModel] = []

var userLogedDetails : LoginModel?
//MARK: - COREDATE SAVE PASSENGER DETAILS
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext
var sliderimagesflight = [Flight_top_destinations]()
var sliderimageshotel = [Hotel_top_destination]()

var sports_top_destinations = [Sports_top_destinations]()
var holiday_top_destinations = [Holiday_top_destinations]()
var imgPath = String()
var currencyType = String()
var search_params:Flight_search_params?

//MARK: - Filters
var filterModel = FlightFilterModel()
var hotelfiltermodel = HotelFilterModel()
var sortBy: SortParameter = .nothing
var starRatingFilter = String()


//MARK: - FLIGHT RESULT
var searchid = String()
var bookingsource = String()
var bookingsourcekey = String()
var accesskey = String()
var oneWayFlights = [Flight_result]()

var fd:Flight_details?
var baggageAllowance1 = [BaggageAllowance]()
var selectedDate: Date = Date()

//MARK: - FILTERS
var prices = [String]()
var noofStopsA = [String]()
var fareTypeA = [String]()
var airlinesA = [String]()
var cancellationsTypeA = [String]()
var connectingFlightsA = [String]()
var connectingAirportA = [String]()
var departureTimeA = [String]()
var arrivalTimeA = [String]()


//Price Syummery
var AdultsTotalPrice = String()
var ChildTotalPrice = String()
var InfantTotalPrice = String()
var sub_total_adult : String?
var sub_total_child : String?
var sub_total_infant : String?

var Adults_Base_Price = String()
var Adults_Tax_Price = String()
var Childs_Base_Price = String()
var Childs_Tax_Price = String()
var Infants_Base_Price = String()
var Infants_Tax_Price = String()
var TotalPrice_API = String()
var grandTotal = String()
var promocodeDiscountValue = String()
var newGrandTotal = String()
var subtotal = String()
var checkTermsAndCondationStatus = false
var meallist = [Meal_list]()
var specialAssistancelist1 = [Special_allowance]()
var totalBaseFare = String()
var totaltax = String()


//paynow screen
var countryCode = String()
var billingCountryCode = String()
var billingCountryName = String()
var email = String()
var mobile = String()

//Booking confirmed
var bookedDate = String()
var pnrNo = String()
var bookingRefrence = String()
var bookingId = String()
var itinearyDet = [Booking_itinerary_details]()
var bookingStatus = String()
var callapibool = Bool()

var fdetails = [Summary]()
var vouchercustomerdetails = [Customer_details]()

var passportExpireDateBool = false

//MARK: - Travellers Details

var checkOptionCountArray = [String]()
var passengertypeArray = [String]()
var genderArray = [String]()
var leadPassengerArray = [String]()
var middleNameArray = [String]()
var arrayOf_SelectedCellsAdult = [IndexPath]()
var arrayOf_SelectedCellsChild = [IndexPath]()
var arrayOf_SelectedCellsInfanta = [IndexPath]()
var totalNoOfTravellers = String()
var travellerdetails  = [NSFetchRequestResult]()
var ageCategory: AgeCategory = .adult
var selectCityCategory : SelectCityCategory = .none


var fnameAAA = [String]()
var travelerArray: [Traveler] = []
var promoinfoArray = [Promo_info]()

//MARK: - Multicity
var fromCityNameArray = ["From","From"]
var fromCityCodeArray = ["From","From"]
var fromlocidArray = ["",""]
var toCityNameArray = ["To","To"]
var toCityCodeArray = ["To","To"]
var tolocidArray = ["",""]
var depatureDatesArray = ["Date","Date"]
var fromCityShortNameArray = ["From","From"]
var toCityShortNameArray = ["To","To"]
var finalInputArray = [[String:Any]]()

//HOTEL
var adtArray = [String]()
var chArray = [String]()
var childAge_1A = [String]()
var hbooking_source = String()
var hsearch_id = String()
var hotelid = String()
var isFromVCBool = Bool()
var ratekeyArray = [String]()
var htoken = String()
var htokenkey = String()
var hd:HotelDetailsModel?
var latitudeArray: [String] = []
var longitudeArray: [String] = []
var totalRooms = 0
var facilityArray = [String]()
var faretypeArray = [String]()
var neighbourwoodArray = [String]()
var amenitiesArray = [String]()
var nearBylocationsArray = [String]()


/* URL endpoints */
struct ApiEndpoints {
    
    static let indexpage = "general/index"
    static let countrylist1 = "flight/country_list"
    static let general_getAirlineList = "general/getAirlineList"
    static let mobilePreFlightSearch = "mobile_pre_flight_search"
    static let mobilelogin = "auth/mobile_login"
    static let mobileregister = "auth/mobile_register_on_light_box"
    static let mobilelogout = "auth/mobile_ajax_logout"
    static let auth_deleteuser = "auth/deleteuser"
    static let general_mobile_contact_us = "general/mobile_contact_us"
    static let mobileforgotpassword = "auth/mobile_forgot_password"
    static let updatemobileprofile = "user/mobile_profile"
    static let getCurrencyList = "general/getCurrencyList"
    static let getairportcodelist = "ajax/get_airport_code_list"
    static let mobilepreflightsearch = "general/mobile_pre_flight_search"
    static let indexphp_ajax_flight_details = "index.php/ajax/flight_details"
    static let preprocessbooking = "flight/pre_process_booking"
    static let mobilebooking = "index.php/flight/booking"
    static let processpassengerdetail = "flight/process_passenger_detail"
    static let prebooking = "flight/pre_booking/"
    static let prepaymentconfirmation = "flight/pre_payment_confirmation/"
    static let sendtopayment = "flight/send_to_payment/"
    static let securebooking = "flight/secure_booking/"
    static let upcomingbookingmobile = "flight/upcoming_booking_mobile"
    static let completedbookingmobile = "flight/completed_booking_mobile"
    static let cancelledbookingmobile = "flight/cancelled_booking_mobile"
    static let getSpecialAssistancelist = "general/getSpecialAssistance_list"
    static let getMeals_list = "general/getMeals_list"
    static let applypromocode = "management/promocode"
    //HOTEL
    static let gethotelcitylist = "ajax/get_hotel_city_list"
    static let mobileprehotelsearch = "general/mobile_pre_hotel_search"
    static let general_ajaxHotelSearch_pagination = "general/ajaxHotelSearch_pagination"
    
    static let hoteldetails = "hotel/mobile_details"
    static let hotelmobilebooking = "hotel/mobile_booking"
    static let mobilehotelprebooking = "hotel/mobile_hotel_pre_booking"
    static let hotelsecurebooking = "hotel/secure_booking"

    static let general_pre_flight_search = "general/pre_flight_search"
    
    
}

/*App messages*/
struct Message {
    static let internetConnectionError = "Please check your connection and try reconnecting to internet"
    static let sessionExpired = "Your session has been expired, please login again"
}


/*USER ENTERED DETAILS DEFAULTS*/

struct UserDefaultsKeys {
    
    static var mobilecountrycode = "mobilecountrycode"
    static var mobilecountryname = "mobilecountryname"
    static var tabselect = "tabselect"
    static var nationality = "nationality"
    static var airlinescode = "airlinescode"
    static var userLoggedIn = "userLoggedIn"
    static var loggedInStatus = "loggedInStatus"
    static var userid = "userid"
    static var username = "username"
    static var userimg = "userimg"
    static var useremail = "useremail"
    static var usermobile = "usermobile"
    static var usermobilecode = "usermobilecode"
    static var journeyType = "Journey_Type"
    static var itinerarySelectedIndex = "ItinerarySelectedIndex"
    static var selectedCurrency = "selectedCurrency"
    static var selectedCurrencyType = "selectedCurrencyType"
    static var totalTravellerCount = "totalTravellerCount"
    static var select_classIndex = "select_classIndex"
    static var rselect_classIndex = "rselect_classIndex"
    static var mselect_classIndex = "mselect_classIndex"
    static var journeyCitys = "journeyCitys"
    static var journeyDates = "journeyDates"
    static var cellTag = "cellTag"
    static var flightrefundtype = "flightrefundtype"
    
    
    
    //ONE WAY
    static var fromCity = "fromCity"
    static var fromCityCode = "fromCityCode"
    static var toCity = "toCity"
    static var toCityCode = "toCityCode"
    static var calDepDate = "calDepDate"
    static var calRetDate = "calRetDate"
    static var adultCount = "Adult_Count"
    static var childCount = "Child_Count"
    static var hadultCount = "HAdult_Count"
    static var hchildCount = "HChild_Count"
    static var infantsCount = "Infants_Count"
    static var selectClass = "select_class"
    static var fromlocid = "from_loc_id"
    static var tolocid = "to_loc_id"
    static var fromcityname = "fromcityname"
    static var tocityname = "tocityname"
    static var fcity = "fcity"
    static var tcity = "tcity"
    
    
    //ROUND TRIP
//    static var rlocationcity = "rlocation_city"
//    static var rfromCity = "rfromCity"
//    static var rtoCity = "rtoCity"
//    static var rcalDepDate = "rcalDepDate"
//    static var rcalRetDate = "rcalRetDate"
//    static var radultCount = "rAdult_Count"
//    static var rchildCount = "rChild_Count"
//    static var rhadultCount = "rHAdult_Count"
//    static var rhchildCount = "rHChild_Count"
//    static var rinfantsCount = "rInfants_Count"
//    static var rselectClass = "rselect_class"
//    static var rfromlocid = "rfrom_loc_id"
//    static var rtolocid = "rto_loc_id"
//    static var rfromcityname = "rfromcityname"
//    static var rtocityname = "rtocityname"
    
    
    //MULTICITY TRIP
    static var mlocationcity = "mlocation_city"
    static var mfromCity = "mfromCity"
    static var mtoCity = "mtoCity"
    
//    static var mcalDepDate = "mcalDepDate"
//    static var mcalRetDate = "mcalRetDate"
//    static var madultCount = "mAdult_Count"
//    static var mchildCount = "mChild_Count"
//    static var mhadultCount = "mHAdult_Count"
//    static var mhchildCount = "mHChild_Count"
//    static var minfantsCount = "mInfants_Count"
//    static var mselectClass = "mselect_class"
    
    static var mfromlocid = "mfrom_loc_id"
    static var mtolocid = "mto_loc_id"
    static var mfromcityname = "mfromcityname"
    static var mtocityname = "mtocityname"
    
    
    //Hotel
    static var locationcity = "location_city"
    static var locationid = "location_id"
    static var hoteladultCount = "HotelAdult_Count"
    static var hotelchildCount = "HotelChild_Count"
    static var cityid = "cityid"
    static var htravellerDetails = "htraveller_Details"
    static var roomType = "Room_Type"
    static var refundtype = "refundtype"
    static var hnationality = "hnationality"
    static var hnationalitycode = "hnationalitycode"
    
    
    static var select = "select"
    static var checkin = "check_in"
    static var checkout = "check _out"
    static var addTarvellerDetails = "addTarvellerDetails"
    static var travellerDetails = "traveller_Details"
   // static var mtravellerDetails = "mtraveller_Details"
    static var roomcount = "room_count"
    static var hoteladultscount = "hotel_adults_count"
    static var hotelchildcount = "hotel_child_count"
    static var guestcount = "guestcount"
    static var selectPersons = "selectPersons"
    static var kwdprice = "kwdprice"
    
}


struct sessionMgrDefaults {
    
    static var userLoggedIn = "username"
    static var loggedInStatus = "email"
    static var globalAT = "mobile_no"
    static var Base_url = "accesstoken"
}



/*LOCAL JSON FILES*/
struct LocalJsonFiles {
    
}
