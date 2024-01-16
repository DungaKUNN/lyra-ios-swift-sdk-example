//
//  LyraManager.swift
//  demoPayment
//
//  Created by Jeanpier Araujo on 18/12/23.
//

import Foundation
import LyraPaymentSDK

struct LyraManager {
    
    func initilize() {
        do {
            var configurations = [String : Any]()
            configurations[Lyra.apiServerName] = LyraKeys.serverName
            
            try Lyra.initialize(LyraKeys.publicKey, configurations)
            print("Lyra inicialiazdo correctamente")
            
        } catch { print("Error al inicializar Lyra") }
    }
    
    func buildWith(amount: Int,
                   currency: String,
                   orderId: String,
                   in controller: UIViewController,
                   withCompletion completion: @escaping (_ token: String) -> Void,
                   andWithError errorMessage: @escaping (_ errrorMessage: String) -> Void) {
        
        PaymentWebService().getFormToken(amount: amount, currency: currency, orderId: orderId) { tokenString in
            do {
                try Lyra.process(controller, tokenString, onSuccess: { lyraResponse in
                    completion(tokenString)
                }, onError: { error, lyraResponse in
                    errorMessage(error.errorMessage)
                    
                    
                })
            } catch { errorMessage("Error al construit la pasarella") }
        } andWithError: { messageError in
            errorMessage(messageError)
        }
    }
}
