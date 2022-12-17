//
//  MainPage.swift
//  BitirmeOdevi
//
//  Created by PRO10010 on 25.10.2022.
//

import SwiftUI

struct MainPage: View {
    // Current Tab
    @State var currentTab: Tab = .Home
    @StateObject var sharedData : SharedDataModel = SharedDataModel()
    // Hiding Tab
    @Namespace var animation
    init() {
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        VStack(spacing: 0) {
            // Tab View
            TabView(selection: $currentTab) {
                Home(animation: animation)
                    .environmentObject(sharedData)
                    .tag(Tab.Home)
                Text("Favoriler")
                    .tag(Tab.Liked)
               ProfilePage()
                    .tag(Tab.Profile)
                Text("Sepet")
                    .tag(Tab.Cart)
            }
            //Custom Tab Bar
            HStack(spacing: 0){
                ForEach(Tab.allCases,id: \.self){tab in
                    Button{
                        currentTab = tab
                    } label: {
                        Image(tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24,height: 24)
                        // shadow ekliyoruz
                            .background(
                            Color("mor")
                                .opacity(0.1)
                                .cornerRadius(5)
                                .blur(radius: 5)
                                .padding(-7)
                                .opacity(currentTab == tab ? 1: 0)
                            )
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ? Color("mor") : Color.black.opacity(0.3))
                    }
                }
            }
            .padding([.horizontal,.bottom])
            .padding(.bottom,10)
        }
        
        .background().ignoresSafeArea()
        .overlay(
            ZStack{
                //Detail Page
                if let product = sharedData.detailProduct,sharedData.showDetailProduct{
                    ProductDetailView(product: product, animation: animation)
                        .environmentObject(sharedData)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                }
            }
        )
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

// Tab Seçenekleri
enum Tab: String,CaseIterable{
    case Home = "Home"
    case Liked = "Liked"
    case Profile = "Profile"
    case Cart = "Cart"
}
