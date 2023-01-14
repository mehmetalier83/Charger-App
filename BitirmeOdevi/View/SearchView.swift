//
//  SearchView.swift
//  BitirmeOdevi
//
//  Created by PRO10010 on 14.11.2022.
//

import SwiftUI

struct SearchView: View {
    var animation: Namespace.ID
    @EnvironmentObject var homeData: HomeViewModel
    @EnvironmentObject var sharedData: SharedDataModel
    @FocusState var starTF: Bool
    var body: some View {
        VStack(spacing: 0) {
            // Search Bar
            HStack(spacing: 20) {
                // Kapalı buton
                Button {
                    withAnimation {
                        homeData.searchActivated = false
                    }
                    homeData.searchText = ""
                    // RESET
                    sharedData.fromSearchPage = false
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(Color.black.opacity(0.7))
                }

                HStack(spacing: 15) {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    TextField("Arama", text: $homeData.searchText)
                        .focused($starTF)
                        .textCase(.lowercase)
                        .disableAutocorrection(true)
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 12)
                .background(
                    Capsule()
                        .strokeBorder(Color("lila"), lineWidth: 1.5)
                )
                .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                .padding(.trailing, 20)
            }
            .padding([.horizontal])
            .padding(.top)
            
            if let products = homeData.searchedProducts {
                if products.isEmpty {
                    // MARK: Sonuç Yok ÇALIŞMIYOR

                    // Sonuç yok
                    VStack(spacing: 10) {
                        Image("sonucyok")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.top, 60)
                        Text("Ürün bulunamadı")
                            .font(.custom("AmericanTypewriter-Bold", fixedSize: 22))
                            .fontWeight(.bold)
                        Text("Daha genel bir arama terimi deneyin veya alternatif ürünler aramayı deneyin")
                            .font(.custom("AmericanTypewriter-Bold", fixedSize: 16))
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                    }
                    padding()
                } else {
                    // Filter Result
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            // Found Result
                            Text("\(products.count) sonuç bulundu.")
                                .padding(.top, 30)
                                .font(.custom("AmericanTypewriter-Bold", fixedSize: 24))
                                .fontWeight(.semibold)
                                
                            // Staggered Grid
                            StaggeredGrid(columns: 2, spacing: 40, list: products) { product in
                                // CardView
                                ProductCardView(product: product)
                            }
                            .padding()
                        }
                    }
                }
            } else {
                ProgressView()
                    .padding(.top, 30)
                    .opacity(homeData.searchText == "" ? 0 : 1)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
            Color(.white).ignoresSafeArea()
        )
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                starTF = true
            }
        }
    }

    @ViewBuilder
    func ProductCardView(product: Product) -> some View {
        VStack(spacing: 10) {
            ZStack {
                if sharedData.showDetailProduct {
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
             
                } else {
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "\(product.id)SEARCH", in: animation)
                }
            }
            // Resmin görünüşünü taşıttık
            
            .offset(y: -50)
            .padding(.bottom, -50)
            
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
        .padding(.top, 20)
        .onTapGesture {
            withAnimation {
                sharedData.fromSearchPage = true
                sharedData.detailProduct = product
                sharedData.showDetailProduct = true
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
