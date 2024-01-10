//
//  PreProcessBookingViewModel.swift
//  KuwaitWays
//
//  Created by FCI on 25/04/23.
//

import Foundation

protocol PreProcessBookingViewModelDelegate : BaseViewModelProtocol {
    
    func preProcessBookingDetails(response : PreProcessBookingModel)
    func mobileBookingDetails(response : MobileBookingModel)
    func processPassengerDetails(response : ProcessPassangerDetailModel)
    func preFlightBookingDetails(response : ProcessPassangerDetailModel)
    func flightPrePaymentDetails(response : PrePaymentConfModel)
    func sendtoPaymentDetails(response : sendToPaymentModel)
    func secureBookingDetails(response : sendToPaymentModel)
    func promocodeResult(response : ApplyPromocodeModel)
    
}

class PreProcessBookingViewModel {
    
    var view: PreProcessBookingViewModelDelegate!
    init(_ view: PreProcessBookingViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_PRE_PROCESS_BOOKING_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.preprocessbooking, parameters: parms, resultType: PreProcessBookingModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
             //   self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.preProcessBookingDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    func CALL_MOBILE_BOOKING_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        // self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.mobilebooking, parameters: parms, resultType: MobileBookingModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                   self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.mobileBookingDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    func CALL_PROCESS_PASSENGER_DETAIL_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.processpassengerdetail,parameters: parms, resultType: ProcessPassangerDetailModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
              //  self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.processPassengerDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    func CALL_PRE_FLIGHT_BOOKING_API(dictParam: [String: Any],key:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
           self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.prebooking + key,parameters: parms, resultType: ProcessPassangerDetailModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                //     self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.preFlightBookingDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    
    
    func CALL_FLIGHT_PRE_CONF_PAYMENT_API(dictParam: [String: Any],key:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        //  self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.prepaymentconfirmation + key,parameters: parms, resultType: PrePaymentConfModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                //  self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.flightPrePaymentDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    
    func CALL_SENDTO_PAYMENT_API(dictParam: [String: Any],key:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        //  self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.sendtopayment + key,parameters: parms, resultType: sendToPaymentModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                //  self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.sendtoPaymentDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    func CALL_SECURE_BOOKING_API(dictParam: [String: Any],key:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
     //   self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.securebooking + key,parameters: parms, resultType: sendToPaymentModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.secureBookingDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    
    func CALL_APPLY_PROMOCODE_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
       // self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.applypromocode, parameters: parms, resultType: ApplyPromocodeModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.promocodeResult(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
}
