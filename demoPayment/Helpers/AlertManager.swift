//
//  AlertManager.swift
//  demoPayment
//
//  Created by Jeanpier Araujo on 18/12/23.
//

import UIKit

extension UIViewController {
    
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "Lyra (demo)", message: message, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                alertController.dismiss(animated: true)
            })
        })
    }
}
