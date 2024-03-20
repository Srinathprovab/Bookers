//
//  IndexPageViewModel.swift
//  KuwaitWays
//
//  Created by FCI on 25/04/23.
//

import Foundation



protocol IndexPageViewModelDelegate : BaseViewModelProtocol {
    func indexPageDetails(response : IndexPageModel)
    func preFlightSearchResponse(response:pre_flight_search_Model)
}

class IndexPageViewModel {
    
    var view: IndexPageViewModelDelegate!
    init(_ view: IndexPageViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_INDEX_PAGE_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
       // self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: "https://boookers.com/webservice/", parameters: parms, resultType: IndexPageModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.indexPageDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    func CALL_PRE_FLIGHT_SEARCH_API(dictParam: [String: Any],url:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: url, parameters: parms, resultType: pre_flight_search_Model.self, p:dictParam) { sucess, result, errorMessage in
            
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
    
    
}
