//
//  LyraKeys.swift
//  demoPayment
//
//  Created by Jeanpier Araujo on 18/12/23.
//

import Foundation

struct LyraKeys {
    static let publicKey    = ""
    static let serverName   = "https://api.micuentaweb.pe"  //Nombre del servidor API REST
    static let urlServer    = ""         //Servidor 
    static let username     = "72043618"
    static let password     = "testpassword_Sqk9KAJzQQv7auyvnTGsoLAz48HPFLpAwfUxKF9WjHfh8"
    static let cureency     = "PEN"
    static let loginBase64  = String(format: "%@:%@", username, password).data(using: String.Encoding.utf8)?.base64EncodedString()
}
