//
//  HSecureBookingViewModel.swift
//  KuwaitWays
//
//  Created by FCI on 21/09/23.
//

import Foundation


protocol HSecureBookingViewModelDelegate : BaseViewModelProtocol {
    func hotelVoucherDetails(response:HotelVoucherModel)
}

class HSecureBookingViewModel {
    
    var view: HSecureBookingViewModelDelegate!
    init(_ view: HSecureBookingViewModelDelegate) {
        self.view = view
    }
    

    
    
    
    //MARK:  CALL_HOTEL_VOUCHER_API
    func CALL_HOTEL_VOUCHER_API(dictParam: [String: Any],urlstr:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: urlstr,parameters: parms ,resultType: HotelVoucherModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.hotelVoucherDetails(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    
    
}
