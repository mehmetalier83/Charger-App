//
//  CartPage.swift
//  BitirmeOdevi
//
//  Created by PRO10010 on 18.12.2022.
//

import SwiftUI

struct CartPage: View {
    @EnvironmentObject var sharedData: SharedDataModel
    
    @State var showDeleteOption: Bool = false
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        HStack {
                            Text("Sepetim")
                                .font(.custom("AmericanTypewriter-Bold", fixedSize: 24).bold())
                            Spacer()
                            
                            Button {
                                withAnimation {
                                    showDeleteOption.toggle()
                                }
                            } label: {
                                Image("delete")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: 30, maxHeight: 30)
                            }
                        }
                        if sharedData.cartProducts.isEmpty {
                            Group {
                                Image("Cart")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .padding()
                                    .padding(.top, 35)
                                Text("Henüz sepetinde ürünün yok")
                                    .font(.custom("AmericanTypewriter-Bold", fixedSize: 20))
                                    .fontWeight(.semibold)
                                Text("Ürün sayfasından sepetine ürün eklemelisin")
                                    .font(.custom("AmericanTypewriter-Bold", fixedSize: 15))
                                    .foregroundColor(.gray)
                                    .padding(.top, 5)
                                    .multilineTextAlignment(.center)
                            }
                        } else {
                            VStack {
                                ForEach($sharedData.cartProducts) { $product in
                                    HStack(spacing: 0) {
                                        if showDeleteOption {
                                            Button {
                                                deleteProduct(product: product)
                                            } label: {
                                                Image(systemName: "minus.circle.fill")
                                                    .font(.title2)
                                                    .foregroundColor(.red)
                                            }
                                            .padding(.trailing)
                                        } else {}
                                        
                                        CardView(product: $product)
                                    }
                                }
                            }
                            .padding(.top, 25)
                            .padding(.horizontal)
                        }
                    }
                    .padding()
                }
                if !sharedData.cartProducts.isEmpty {
                    Group {
                        HStack {
                            Text("Toplam:")
                                .font(.custom("AmericanTypewriter-Bold", fixedSize: 17))
                                .fontWeight(.semibold)
                            Spacer()
                            
                            Text(sharedData.getTotalPrice())
                                .font(.custom("AmericanTypewriter-Bold", fixedSize: 17))
                                .fontWeight(.bold)
                                .foregroundColor(Color("lila"))
                        }
                        Button {} label: {
                            Text("Ödeme")
                                .font(.custom("AmericanTypewriter-Bold", fixedSize: 18))
                                .foregroundColor(.white)
                                .frame(maxWidth: 500, maxHeight: 50)
                                .background(Color("lila"))
                                .cornerRadius(15)
                                .shadow(color: Color.black.opacity(0.5), radius: 5, x: 5, y: 5)
                        }
                       
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical)
                }
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }



    func deleteProduct(product: Product) {
        if let index = sharedData.cartProducts.firstIndex(where: { currentProduct in
            product.id == currentProduct.id
        }) {
            _ = withAnimation {
                sharedData.cartProducts.remove(at: index)
            }
        }
    }
}

struct CartPage_Previews: PreviewProvider {
    static var previews: some View {
        CartPage()
    }
}

struct CardView : View{
    @Binding var product : Product
    var body: some View{
            
            HStack(spacing:10){
                Image(product.productImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: 100, maxHeight: 100)
                VStack(alignment: .leading, spacing: 10) {
                    Text(product.title)
                        .lineLimit(1)
                        .font(.custom("AmericanTypewriter-Bold", fixedSize: 18))
                    Text(product.subtitle)
                        .font(.custom("AmericanTypewriter-Bold", fixedSize: 17))
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    HStack(spacing: 15){
                        Text("Adet")
                            .font(.custom("AmericanTypewriter-Bold", fixedSize: 17))
                            
                        Button{
                            product.quantity = (product.quantity > 0 ? (product.quantity - 1) : 0 )
                        }label: {
                            Image(systemName: "minus")
                                .font(.caption)
                                .frame(maxWidth: 20, maxHeight: 20)
                                .cornerRadius(4)
                        }
                        
                        Text("\(product.quantity)")
                            .font(.custom("AmericanTypewriter-Bold", fixedSize: 17))
                            .fontWeight(.semibold)
                        
                        Button{
                            product.quantity += 1
                        }label: {
                            Image(systemName: "plus")
                                .font(.caption)
                                .frame(maxWidth: 20, maxHeight: 20)
                                .cornerRadius(4)
                        }

                    }
                }
                
             
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color("lila").opacity(0.2)
                    .cornerRadius(35)
            )
            
        
    }
    
}
