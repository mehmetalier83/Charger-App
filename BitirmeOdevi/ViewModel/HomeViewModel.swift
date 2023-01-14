//
//  HomeViewModel.swift
//  BitirmeOdevi
//
//  Created by PRO10010 on 13.11.2022.
//

import Combine
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var productType: ProductType = .Wearable
    
    // Örnek Ürünler
    @Published var products: [Product] = [
        Product(type: .Wearable, title: "Apple Watch 6", subtitle: "Series 6 Red", price: "₺5000", productImage: "applewatch6"),
        Product(type: .Wearable, title: "Apple Watch 7", subtitle: "Ultra : Beyaz", price: "₺2000", productImage: "applewatch7"),
        Product(type: .Wearable, title: "Apple Watch 3", subtitle: "Ultra : Beyaz", price: "₺3000", productImage: "applewatch3"),
        Product(type: .Wearable, title: "Apple Max Kulaklık", subtitle: "Max : Siyah", price: "₺17000", productImage: "applemaxsiyah"),
        Product(type: .Phones, title: "Apple İphone 12 Mini", subtitle: "64 Gb ", price: "₺3000", productImage: "iphone12mini64"),
        Product(type: .Phones, title: "Apple İphone 12", subtitle: "64 Gb ", price: "₺4000", productImage: "iphone1264gb"),
        Product(type: .Phones, title: "Apple İphone Se", subtitle: "64 Gb ", price: "₺2700", productImage: "iphonese64"),
        Product(type: .Phones, title: "Apple İphone XR ", subtitle: "128 GB ", price: "₺2400", productImage: "iphonexr128"),
        Product(type: .Laptops, title: "Apple Macbook Air", subtitle: "M2 İşlemci", price: "₺4400", productImage: "macbookair"),
        Product(type: .Laptops, title: "Apple Macbook Air", subtitle: "M1 İşlemci", price: "₺4400", productImage: "macbookm1"),
        Product(type: .Laptops, title: "Apple Macbook Pro", subtitle: "M2 İşlemci", price: "₺6400", productImage: "macbookpro"),
        Product(type: .Laptops, title: "Apple Macbook Pro", subtitle: "M2 İşlemci 2021", price: "₺7400", productImage: "macbookprom2162021"),
        Product(type: .Tablets, title: "Apple Ipad", subtitle: " 10.9 inç 64 Gb", price: "₺2400", productImage: "ipad"),
        Product(type: .Tablets, title: "Apple Ipad", subtitle: "10.9 inç 128 Gb", price: "₺2400", productImage: "ipad109"),
        Product(type: .Tablets, title: "Apple Ipad Gümüş", subtitle: "10.9 inç 128 Gb", price: "₺3100", productImage: "ipad109gumus"),
        Product(type: .Tablets, title: "Apple Ipad Mini", subtitle: "64 Gb", price: "₺3400", productImage: "ipadmini64"),
        Product(type: .Tablets, title: "Apple Ipad Pro", subtitle: "64 Gb", price: "₺4400", productImage: "ipadpro"),
        Product(type: .Tablets, title: "Apple Ipad Pro", subtitle: "12.3 inç 128 Gb", price: "₺5400", productImage: "ipadpro12.3"),
    ]
    
    // Filtreleme İşlemi
    
    @Published var filteredProducts: [Product] = []
    // Daha fazla ürün tipi
    @Published var showMoreProductsOnType: Bool = false
    
    //
    @Published var searchText: String = ""
    @Published var searchActivated: Bool = false
    
    @Published var searchedProducts: [Product]?
    var searchCancellable: AnyCancellable?
    
    init() {
        filterProductByType()
        
        searchCancellable = $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str != "" {
                    self.filterProductBySearch()
                } else {
                    self.searchedProducts = nil
                }
            })
    }
    
    func filterProductByType() {
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.products
                .lazy
                .filter { product in
                    product.type == self.productType
                }
                // İlk gösterim limiti
                .prefix(4)
            DispatchQueue.main.async {
                self.filteredProducts = results.compactMap { product in
                    product
                }
            }
        }
    }

    func filterProductBySearch() {
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.products
                .lazy
                .filter { product in
                    product.title.lowercased().contains(self.searchText.lowercased())
                }
            DispatchQueue.main.async {
                self.searchedProducts = results.compactMap { product in
                    product
                }
            }
        }
    }
}
