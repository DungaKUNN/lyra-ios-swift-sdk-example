//
//  LyraKeys.swift
//  demoPayment
//
//  Created by Jeanpier Araujo on 18/12/23.
//

import Foundation

struct LyraKeys {
    static let publicKey    = ""  //Contraseña Publica de Test o Producción
    static let serverName   = "https://api.micuentaweb.pe"  //Nombre del Servidor API REST
    static let urlServer    = ""         //Servidor 
    static let username     = ""  //Usuario
    static let password     = ""  //Contraseña de Test o Producción
    static let cureency     = "PEN"
    static let loginBase64  = String(format: "%@:%@", username, password).data(using: String.Encoding.utf8)?.base64EncodedString()
}

