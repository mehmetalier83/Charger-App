//
//  LikedPage.swift
//  BitirmeOdevi
//
//  Created by PRO10010 on 17.12.2022.
//

import SwiftUI

struct LikedPage: View {
    
    @EnvironmentObject var sharedData : SharedDataModel
    
    @State var showDeleteOption : Bool = false
    var body: some View {
        NavigationView{
            
            ScrollView(.vertical,showsIndicators: false){
                VStack{
                    HStack{
                        Text("Favorilerim")
                            .font(.custom("AmericanTypewriter-Bold", fixedSize: 24).bold())
                        Spacer()
                        
                        Button{
                            withAnimation {
                                showDeleteOption.toggle()
                            }
                        }label: {
                            Image("delete")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: 30,maxHeight: 30)
                        }
                    }
                    if sharedData.likedProducts.isEmpty{
                        Group{
                            Image("nolike")
                                .resizable()
                                .aspectRatio( contentMode: .fill)
                                .padding()
                                .padding(.top,35)
                            Text("Henüz favori ürünün yok")
                                .font(.custom("AmericanTypewriter-Bold", fixedSize: 20))
                                .fontWeight(.semibold)
                            Text("Ürün sayfasından favori ürününü seçmelisin")
                                .font(.custom("AmericanTypewriter-Bold", fixedSize: 15))
                                .foregroundColor(.gray)
                                .padding(.top,10)
                                .multilineTextAlignment(.center)
                        }
                    }else{
                        VStack{
                            ForEach(sharedData.likedProducts){product in
                                HStack(spacing: 0){
                                    if showDeleteOption{
                                        Button{
                                            deleteProduct(product: product)
                                        }label: {
                                            Image(systemName: "minus.circle.fill")
                                                .font(.title2)
                                                .foregroundColor(.red)
                                        }
                                        .padding(.trailing)
                                    }else{
                                        
                                    }
                                    
                                    CardView(product:product)
                                }
                            }
                        }
                        .padding(.top,25)
                        .padding(.horizontal)
                    }
                    
                }
                .padding()
                
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            
        }
      
    }
    @ViewBuilder
    func CardView(product: Product)->some View{
        Image(product.productImage)
            .resizable()
            .aspectRatio( contentMode: .fill)
            .frame(maxWidth: 100,maxHeight: 100)
        VStack(alignment: .leading, spacing: 10){
            Text(product.title)
                .lineLimit(1)
                .font(.custom("AmericanTypewriter-Bold", fixedSize: 18))
            Text(product.subtitle)
                .font(.custom("AmericanTypewriter-Bold", fixedSize: 17))
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            Text("Kategori : \(product.type.rawValue)")
                .font(.custom("AmericanTypewriter-Bold", fixedSize: 15))
                .foregroundColor(.gray)
        }
        
        .padding(.horizontal,10)
        .padding(.vertical,20)
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(
            Color("lila").opacity(0.2)
                .cornerRadius(35)
        )
    }
    func deleteProduct(product : Product){
        if let index = sharedData.likedProducts.firstIndex(where: { currentProduct  in
            return product.id == currentProduct.id
        }){
           let _ = withAnimation {
                sharedData.likedProducts.remove(at: index)
            }
        }
    }
    
}

struct LikedPage_Previews: PreviewProvider {
    static var previews: some View {
        LikedPage()
            .environmentObject(SharedDataModel())
        
    }
}
