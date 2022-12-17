//
//  ProductDetailView.swift
//  BitirmeOdevi
//
//  Created by PRO10010 on 17.12.2022.
//

import SwiftUI

struct ProductDetailView: View {
    var product : Product
    //Shared Data Model
    var animation : Namespace.ID
    
    @EnvironmentObject var sharedData : SharedDataModel
    var body: some View {
        VStack{
            
            //Title Bar and Product Image
            VStack{
                //Title Bar
                HStack{
                    Button{
                        //Closing View
                        withAnimation(.easeInOut){
                            sharedData.showDetailProduct = false
                        }
                    }label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(Color.white.opacity(0.9))
                    }
                    Spacer()
                    
                    Button{
                        
                    }label: {
                        Image("Liked")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode:.fit)
                            .matchedGeometryEffect(id: "(\(product.id)\(sharedData.fromSearchPage ? "SEARCH" : "IMAGE")", in: animation)
                            .frame(width: 30,height: 30)
                            .foregroundColor(Color.white.opacity(0.9))
                    }
                }
                .padding()
                //Product  Image
                
                Image(product.productImage)
                    .resizable()
                    .aspectRatio( contentMode: .fill)
                    .padding(.horizontal)
                    .offset(y: -12)
                    .frame(maxHeight: .infinity)
                
                
            }
            .frame(height: getRect().height/2.7)
            .zIndex(1)
            //Product Details
            ScrollView(.vertical,showsIndicators: false){
                //Product Data
                
                VStack(alignment:.leading,spacing: 15){
                    Text(product.title)
                        .font(.custom("AmericanTypewriter-Bold", fixedSize: 20).bold())
                    Text(product.subtitle)
                        .font(.custom("AmericanTypewriter-Bold", fixedSize: 18))
                        .foregroundColor(.gray)
                    Text("3 ay Apple TV+ ücretsiz kullanımı")
                        .font(.custom("AmericanTypewriter-Bold", fixedSize: 16))
                        .padding(.top)
                    Text("Herhangi bir ipad,mac veya iphone satın aldığınızda ücretsiz kullanımdan sonra ayda 85 TL")
                        .font(.custom("AmericanTypewriter-Bold", fixedSize: 16))
                        .foregroundColor(.gray)
                  
                    
                    Button{
                        
                    }label: {
                        Label{
                            Image(systemName: "arrow.right")
                        }icon: {
                            Text("Açıklamanın Devamı")
                        }
                        .font(.custom("AmericanTypewriter-Bold", fixedSize: 15).bold())
                        .foregroundColor(Color("mor"))
                    }
                    HStack{
                        Text("Toplam")
                            .font(.custom("AmericanTypewriter-Bold", fixedSize: 18).bold())
                            .foregroundColor(Color("mor"))
                        Spacer()
                        
                        Text("\(product.price)")
                            .font(.custom("AmericanTypewriter-Bold", fixedSize: 18).bold())
                            .foregroundColor(Color("mor"))
                    }
                    .padding(.vertical,20)
                    //Sepete ekle Butonu
                    
                    Button{
                        
                    }label: {
                        Text("Sepete ekle")
                            .font(.custom("AmericanTypewriter-Bold", fixedSize: 20).bold())
                            .foregroundColor(.white)
                            .padding(.vertical,20)
                            .frame(maxWidth: .infinity)
                            .background(
                                Color("lila")
                                    .cornerRadius(15)
                                    .shadow(color: Color.black.opacity(0.4), radius: 5, x:5, y:5)
                            )
                    }
                    
                }
                .padding([.horizontal,.bottom],20)
                .padding(.top,20)
                .frame(maxWidth: .infinity,maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(
                Color(.white)
                    .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 25))
                    .ignoresSafeArea()
                    .zIndex(0)
            )
        }
        .background(
            Color("lila").ignoresSafeArea()
        )
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
//        ProductDetailView(product: HomeViewModel().products[0])
      MainPage()
    }
}
