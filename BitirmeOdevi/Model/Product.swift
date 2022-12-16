//
//  Product.swift
//  BitirmeOdevi
//
//  Created by PRO10010 on 13.11.2022.
//

import SwiftUI

//Ürün Model

struct Product:Identifiable,Hashable{
    
    var id = UUID().uuidString
    var type : ProductType
    var title : String
    var subtitle : String
    var description : String = ""
    var price : String
    var productImage : String = ""
    var quantity : Int = 1
    
}

// Ürün Tipleri

enum ProductType : String,CaseIterable{
    case Wearable = "Giyilebilir Ürünler"
    case Laptops = "Laptoplar"
    case Phones = "Telefonlar"
    case Tablets = "Tabletler"
}
