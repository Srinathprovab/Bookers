//
//  SingleClass.swift
//  TravgateApp
//
//  Created by FCI on 04/01/24.
//

import Foundation
import UIKit


func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
    lbl.text = text
    lbl.textColor = textcolor
    lbl.font = font
}



class MySingleton {
    // Declare static constant instance
    static let shared = MySingleton()
    
    // Declare your variables
    var myVariable1: Int
    var myVariable2: String
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var payload2 = [String:Any]()
    
    //Home Page
    var indexpagevm:IndexPageViewModel?
    var currencyListArray = [SelectCurrencyData]()
    
    
  
    
    //Flight Search
    var directFlightBool = false
    var adultsCount = 1
    var childCount = 0
    var infantsCount = 0
    var acount = 0
    var ccount = 0
    var icount = 0
    var infoArray = [String]()
    var countrylist = [Country_list]()
    var callboolapi = false
    var bookingsource = String()
    var bookingsourcekey = String()
    var searchid = String()
    var traceid = String()
    var selectedResult = String()
    var tmpFlightPreBookingId = String()
    var accesskeytp = String()
    let dateFormatter = DateFormatter()
    var flightPriceDetails: PriceDetails?
    var mpbpriceDetails: PriceDetails?
    var travelerArray: [Traveler] = []
    var ageCategory: AgeCategory = .adult
    var passportExpireDateBool = false
    var passengertypeArray = [String]()
    var positionsCount = 0
    var searchTextArray = [String]()
    var payemail = String()
    var paymobile = String()
    var paymobilecountrycode = String()
    var nationalityCode = String()
    
    //TIMER
    var timerDidFinish = false
    var timer: Timer?
    var totalTime = 1
    private var backgroundTask: UIBackgroundTaskIdentifier = .invalid


    //View Models
    var vm:FlightListViewModel?
    var fdvm:FlightDetailsViewModel?
    
    
    // Private initializer to prevent multiple instances
    private init() {
        myVariable1 = 0
        myVariable2 = "Default value"
    }
    
    
    
    //MARK: - ExecuteOnce
    func callonce() {
        
        if !UserDefaults.standard.bool(forKey: "ExecuteOnce") {
            
            defaults.set("KWD", forKey: UserDefaultsKeys.selectedCurrency)
            defaults.set("KWD", forKey: UserDefaultsKeys.selectedCurrencyType)
            
            UserDefaults.standard.set(true, forKey: "ExecuteOnce")
        }
    }
    
    
    //MARK: - convert Date Format
    func convertDateFormat(inputDate: String,f1:String,f2:String) -> String {
        
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = f1
        
        guard let oldDate = olDateFormatter.date(from: inputDate) else { return "" }
        
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = f2
        
        return convertDateFormatter.string(from: oldDate)
    }
    
    
    
    //MARK: - getCountryList
    func getCountryList() {
        
       
        
        // Get the path to the clist.json file in the Xcode project
        if let jsonFilePath = Bundle.main.path(forResource: "clist", ofType: "json") {
            do {
                // Read the data from the file
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: jsonFilePath))
                
                // Decode the JSON data into a dictionary
                let jsonDictionary = try JSONDecoder().decode([String: [Country_list]].self, from: jsonData)
                
                // Access the array of countries using the "country_list" key
                if let countries = jsonDictionary["country_list"] {
                    self.countrylist = countries
                    
                } else {
                    print("Unable to find 'country_list' key in the JSON dictionary.")
                }
                
                
            } catch let error {
                print("Error decoding JSON: \(error)")
            }
        } else {
            print("Unable to find clist.json in the Xcode project.")
        }
        
        
    }
    
    
    
    //MARK: - convertToDesiredFormat

    func convertToDesiredFormat(_ inputString: String) -> String {
        if let number = Int(inputString.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
            if inputString.contains("Kilograms") {
                return "\(number) kg"
            } else if inputString.contains("NumberOfPieces") {
                return "\(number) pc"
            }
        }
        return "Invalid input format."
    }
    
    
    
    //MARK: - setAttributedTextnew
    func setAttributedTextnew(str1:String,str2:String,lbl:UILabel,str1font:UIFont,str2font:UIFont,str1Color:UIColor,str2Color:UIColor)  {
        
        let atter1 = [NSAttributedString.Key.foregroundColor:str1Color,
                      NSAttributedString.Key.font:str1font] as [NSAttributedString.Key : Any]
        let atter2 = [NSAttributedString.Key.foregroundColor:str2Color,
                      NSAttributedString.Key.font:str2font] as [NSAttributedString.Key : Any]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
        
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        combination.append(atterStr2)
        
        lbl.attributedText = combination
        
    }
    
    
    
   
}

