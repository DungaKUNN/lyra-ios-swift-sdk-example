//
//  PaymentWebService.swift
//  demoPayment
//
//  Created by Dominique Pérez on 23/02/23.
//

import UIKit
import Alamofire

struct PaymentWebService {
    
    func getFormToken(amount: Int,
                      currency: String,
                      orderId: String,
                      withCompletion completion: @escaping (_ tokenString: String) -> Void,
                      andWithError error: @escaping (_ messageError: String) -> Void) {
        
        let urlString   = LyraKeys.urlServer
        let parameters  : [String : Any] = ["amount"    : amount,
                                            "currency"  : currency,
                                            "orderId"   : orderId]
        
        // Headers para servicio sin auth
        let headers     = HTTPHeaders(arrayLiteral: HTTPHeader(name: "Content-Type", value: "application/json; charset=utf-8"))
        
        // Headers para servicio con auth
        /*let header      = HTTPHeaders(arrayLiteral: HTTPHeader(name: "Content-Type", value: "application/json; charset=utf-8"),
                                                    HTTPHeader(name: "Authorization", value: "Basic \(LyraKeys.loginBase64 ?? "")"))*/
        
        let request = AF.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        request.response { responseData in
 
            guard let data = responseData.data else {
                error("Error: No se pudo obtener data")
                return
            }
            
            if responseData.response?.statusCode == 200 {
                let token = try? JSONDecoder().decode(GetFormTokenResponse.self, from: data).answer.formToken
                completion(token ?? "")
            } else { error("Error: Code \(responseData.response?.statusCode ?? 0)") }
        }
    }
}
