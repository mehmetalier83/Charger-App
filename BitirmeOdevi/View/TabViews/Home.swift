//
//  Home.swift
//  BitirmeOdevi
//
//  Created by PRO10010 on 26.10.2022.
//

import SwiftUI

struct Home: View {
    var animation: Namespace.ID
    @EnvironmentObject var sharedData: SharedDataModel
    @StateObject var homeData: HomeViewModel = .init()
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                // Arama Kutucuğu
                ZStack {
                    if homeData.searchActivated {
                        SearchBar()
                    }
                    else {
                        SearchBar()
                            .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                    }
                }
                .frame(width: getRect().width / 1.6)
                .padding(.horizontal, 25)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        homeData.searchActivated = true
                    }
                }
                Text("Online Sipariş Ver\n Aynı Gün Kargoda")
                    .font(.custom("AmericanTypewriter-Bold", fixedSize: 28))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .padding(.horizontal, 15)

                // ÜrÜnler Tabı
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(ProductType.allCases, id: \.self) { type in
                            ProductTypeView(type: type)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.top, 15)

                // Ürünler Sayfası
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(homeData.filteredProducts) { product in
                            // ürün sepet ekranı
                            ProductCardView(product: product)
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.bottom)
                    .padding(.top, 80)
                }
                .padding(.top, 30)
                // daha fazla buton için
                Button {
                    homeData.showMoreProductsOnType.toggle()
                } label: {
                    Label {
                        Image(systemName: "arrow.right")
                    } icon: {
                        Text("Daha fazlasını Gör")
                    }
                    .font(.custom("AmericanTypewriter-Bold", fixedSize: 16).bold())
                    .foregroundColor(Color("mor"))
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing)
                .padding(.top, 10)
            }
            .padding(.vertical)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)


        .onChange(of: homeData.productType) { _ in
            homeData.filterProductByType()
        }
        // Preview Issue
        .sheet(isPresented: $homeData.showMoreProductsOnType) {} content: {
            MoreProductView()
        }
        // Displaying Search View
        .overlay {
            ZStack {
                if homeData.searchActivated {
                    SearchView(animation: animation)
                        .environmentObject(homeData)
                }
            }
        }
    }

    // Since we're adding matched geometry effect
    // avoiding code replication
    @ViewBuilder
    func SearchBar() -> some View {
        HStack(spacing: 15) {
            Image(systemName: "magnifyingglass")
                .font(.title2)
                .foregroundColor(.gray)
            TextField("Arama", text: .constant(""))
                .textCase(.lowercase)
                .disableAutocorrection(true)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 12)
        .background(
            Capsule()
                .strokeBorder(Color.gray, lineWidth: 0.8)
        )
    }

    @ViewBuilder
    func ProductCardView(product: Product) -> some View {
        VStack(spacing: 10) {
            ZStack {
                if sharedData.showDetailProduct {
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                else {
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "\(product.id)IMAGE", in: animation)
                }
            }
            .frame(width: getRect().width / 2.5, height: getRect().width / 2.5)

            // Resmin görünüşünü taşıttık

            .offset(y: -80)
            .padding(.bottom, -80)

            Text(product.title)
                .font(.custom("AmericanTypewriter-Bold", fixedSize: 18))
                .fontWeight(.semibold)
                .padding(.top)
            Text(product.subtitle)
                .font(.custom("AmericanTypewriter-Bold", fixedSize: 14))
                .fontWeight(.semibold)
                .foregroundColor(Color.gray)
            Text(product.price)
                .font(.custom("AmericanTypewriter-Bold", fixedSize: 16))
                .fontWeight(.bold)
                .padding(.top, 5)
                .foregroundColor(Color("mor"))
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 22)
        .background(
            Color("mor")
                .opacity(0.1)
                .cornerRadius(26)
        )
        .onTapGesture {
            withAnimation {
                sharedData.detailProduct = product
                sharedData.showDetailProduct = true
            }
        }
    }

    @ViewBuilder
    func ProductTypeView(type: ProductType) -> some View {
        Button {
            withAnimation {
                homeData.productType = type
            }
        } label: {
            Text(type.rawValue)
                .font(.custom("AmericanTypewriter-Bold", fixedSize: 16))
                .fontWeight(.semibold)
                // Changing Color based on Current Product Type
                .foregroundColor(homeData.productType == type ? Color("mor") : Color.gray)
                .padding(.bottom, 10)
                .overlay {
                    // gemometrik animasyon eklendi
                    ZStack {
                        if homeData.productType == type {
                            Capsule()
                                .fill(Color("mor"))
                                .frame(height: 2)
                                .matchedGeometryEffect(id: "PRODUCTTAB", in: animation)
                                .padding(.top, 10)
                        }
                        else {
                            Capsule()
                                .fill(Color.clear)
                                .frame(height: 2)
                        }
                    }
                }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
