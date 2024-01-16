//
//  GetFormTokenResponse.swift
//  demoPayment
//
//  Created by Jeanpier Araujo on 18/12/23.
//

import Foundation

struct GetFormTokenResponse: Decodable {
    let answer: answerType
    
    struct answerType: Decodable {
        let formToken: String
    }
}

extension GetFormTokenResponse {
   
}
