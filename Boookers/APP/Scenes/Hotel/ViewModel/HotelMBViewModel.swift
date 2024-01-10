//
//  HotelMBViewModel.swift
//  KuwaitWays
//
//  Created by FCI on 04/05/23.
//

import Foundation



protocol HotelMBViewModelDelegate : BaseViewModelProtocol {
    func hotelMBDetails(response:HotelMBModel)
    func hotelMobilePreBookingDetails(response:HMPreBookingModel)
}

class HotelMBViewModel {
    
    var view: HotelMBViewModelDelegate!
    init(_ view: HotelMBViewModelDelegate) {
        self.view = view
    }
    
    
    //MARK: - CALL_GET_HOTEL_MOBILE_BOOKING_DETAILS_API
    func CALL_GET_HOTEL_MOBILE_BOOKING_DETAILS_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.hotelmobilebooking,parameters: parms ,resultType: HotelMBModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.hotelMBDetails(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    //MARK: - CALL_GET_HOTEL_MOBILE_PRE_BOOKING_DETAILS_API
    func CALL_GET_HOTEL_MOBILE_PRE_BOOKING_DETAILS_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.mobilehotelprebooking,parameters: parms ,resultType: HMPreBookingModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
               // self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.hotelMobilePreBookingDetails(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
}
