//
//  SharedDataModel.swift
//  BitirmeOdevi
//
//  Created by PRO10010 on 17.12.2022.
//

import SwiftUI

class SharedDataModel: ObservableObject {
    @Published var detailProduct: Product?
    @Published var showDetailProduct: Bool = false
    @Published var fromSearchPage: Bool = false

    @Published var likedProducts: [Product] = []
    @Published var cartProducts: [Product] = []
    
    func getTotalPrice()->String{
        var total : Int = 0
        cartProducts.forEach { product in
            let price = product.price.replacingOccurrences(of: "₺", with: "") as NSString
            let quantity = product.quantity
            let priceTotal = quantity * price.integerValue
            total += priceTotal
        }
        return "₺\(total)"
    }
}
