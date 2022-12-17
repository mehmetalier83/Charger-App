//
//  SharedDataModel.swift
//  BitirmeOdevi
//
//  Created by PRO10010 on 17.12.2022.
//

import SwiftUI

class SharedDataModel: ObservableObject {
    @Published var detailProduct : Product?
    @Published var showDetailProduct :Bool = false
    @Published var fromSearchPage : Bool = false
}


