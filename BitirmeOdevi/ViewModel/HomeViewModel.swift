//
//  HomeViewModel.swift
//  BitirmeOdevi
//
//  Created by PRO10010 on 13.11.2022.
//

import SwiftUI

class HomeViewModel: ObservableObject {
  
    @Published var productType : ProductType = .Wearable
    
    //Örnek Ürünler
    @Published var products : [Product] = [
    
        Product(type: .Wearable, title: "Apple Watch 7 Nike Serisi", subtitle: "Series 6 : Red", price: "5000",productImage: "applewatch7nike"),
        Product(type: .Wearable, title: "Apple Watch Ultra Serisi", subtitle: "Ultra : Beyaz", price: "5000",productImage: "applewatchultra")
    ]
    
    //Filtreleme İşlemi
    
    @Published var filteredProducts : [Product] = []
    // Daha fazla ürün tipi
    @Published var showMoreProductsOnType : Bool = false
    init(){
        filteProductByType()
    }
    
    func filteProductByType(){
        
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.products
                .lazy
                .filter { product in
                    return product.type == self.productType
                }
            // sonuç limiti
                .prefix(4)
            DispatchQueue.main.async {
                self.filteredProducts = results.compactMap({ product in
                    return product
                })
            }
        }
        
    }
    
    
}


