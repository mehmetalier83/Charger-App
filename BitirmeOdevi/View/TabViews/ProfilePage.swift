//
//  ProfilePage.swift
//  BitirmeOdevi
//
//  Created by PRO10010 on 17.12.2022.
//

import SwiftUI

struct ProfilePage: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Text("Profilim")
                        .font(.custom("AmericanTypewriter-Bold", fixedSize: 28).bold())
                        .frame(maxWidth: .infinity, alignment:
                            .leading)
                    
                    VStack(spacing: 15) {
                        Image("profil")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .offset(y: -30)
                            .padding(.bottom, -30)
                        
                        Text("Mehmet Ali Er")
                            .font(.custom("AmericanTypewriter-Bold", fixedSize: 20))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .opacity(0.8)
                        
                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: "location.north.circle.fill")
                                .padding(.trailing)
                                .foregroundColor(.white)
                                .rotationEffect(.init(degrees: 180))
                            Text("Yenişehir,Mersin\nÇiftlikköy Mahallesi \nÖztürk apartmanı no:4\n")
                                .font(.custom("AmericanTypewriter-Bold", fixedSize: 15))
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .opacity(0.8)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .background(
                        Color("lila").cornerRadius(15)
                            .padding(.top)
                    )
                    .padding([.horizontal, .bottom])
                    CustomNavigationLink(title: "Profili Düzenle") {
                        Text("")
                            .background(
                                Color(.white).ignoresSafeArea())
                            .navigationTitle("Profili Düzenle")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundColor(.white)
                    }
                    CustomNavigationLink(title: "Adreslerim") {
                        Text("")
                            .background(
                                Color(.white).ignoresSafeArea())
                            .navigationTitle("Adreslerim")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundColor(.white)
                    }
                    CustomNavigationLink(title: "Beğendiklerim") {
                        Text("")
                            .background(
                                Color(.white).ignoresSafeArea())
                            .navigationTitle("Beğendiklerim")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundColor(.white)
                    }
                    CustomNavigationLink(title: "Siparişlerim") {
                        Text("")
                            .background(
                                Color(.white).ignoresSafeArea())
                            .navigationTitle("Siparişlerim")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundColor(.white)
                    }
                    CustomNavigationLink(title: "Müşteri Hizmetleri") {
                        Text("")
                            .background(
                                Color(.white).ignoresSafeArea())
                            .navigationTitle("Müşteri Hizmetleri")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundColor(.white)
                    }
                    CustomNavigationLink(title: "Çıkış Yap") {
                        Text("")
                            .background(
                                Color(.white).ignoresSafeArea())
                            .navigationTitle("Çıkış Yap")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal, 22)
                .padding(.vertical, 20)
                .navigationBarHidden(true)
                .frame(maxWidth:
                    .infinity, maxHeight: .infinity)
                .background(
                    Color(.white).ignoresSafeArea()
                )
            }
        }
    }

    @ViewBuilder
    func CustomNavigationLink<Detail: View>(title: String, @ViewBuilder content: @escaping ()->Detail) ->some View {
        NavigationLink {
            content()
        } label: {
            HStack {
                Text(title)
                    .font(.custom("AmericanTypewriter-Bold", fixedSize: 17))
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                Spacer()
                Image(systemName: "chevron.right").foregroundColor(.white)
            }
            .foregroundColor(.black)
            .padding()
            .background(
                Color("lila").cornerRadius(12)
            )
            
            .padding(.top, 12)
        }
    }

    struct ProfilePage_Previews: PreviewProvider {
        static var previews: some View {
            ProfilePage()
        }
    }
}
