//
//  Product.swift
//  demoPayment
//
//  Created by Jeanpier Araujo on 18/12/23.
//

import Foundation


struct ProductData {
    func getProducts() -> [Product] {
        let bundle      = Bundle.main
        guard let path  = bundle.path(forResource: "products", ofType: "json") else { return [] }
        let data        = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let products    = try? JSONDecoder().decode([Product].self, from: data ?? Data())
        return products ?? []
    }
}

struct Product: Decodable {
    let orderId : String?
    let image   : String?
    let name    : String?
    let price   : Int?
}
