//
//  FlightListViewModel.swift
//  KuwaitWays
//
//  Created by FCI on 24/04/23.
//

import Foundation



protocol FlightListViewModelDelegate : BaseViewModelProtocol {
    func preFlightSearchResponse(response : pre_flight_search_Model)
    func getHitUrlResponse(response : Flight_search_hit_url_Model)
    func flightList(response : FlightListModel)
}

class FlightListViewModel {
    
    var view: FlightListViewModelDelegate!
    init(_ view: FlightListViewModelDelegate) {
        self.view = view
    }

    
    func CALL_PRE_FLIGHT_SEARCH_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.general_pre_flight_search,urlParams: parms as? Dictionary<String, String> , parameters: parms, resultType: pre_flight_search_Model.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
               // self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.preFlightSearchResponse(response: response)
                } else {
                    // Show alert
                    //  print("error === \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    func CALL_GET_HIT_URL_API(dictParam: [String: Any],url:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
       // self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: "\(url)",urlParams: parms as? Dictionary<String, String> , parameters: parms, resultType: Flight_search_hit_url_Model.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
              //  self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.getHitUrlResponse(response: response)
                } else {
                    // Show alert
                    //  print("error === \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    func CALL_GET_FLIGHT_LIST_API(dictParam: [String: Any],url:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
      //  self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: "\(url)",urlParams: parms as? Dictionary<String, String> , parameters: parms, resultType: FlightListModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.flightList(response: response)
                } else {
                    // Show alert
                    //  print("error === \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    
}
