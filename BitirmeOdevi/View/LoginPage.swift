//
//  LoginPage.swift
//  BitirmeOdevi
//
//  Created by PRO10010 on 20.10.2022.
//

import SwiftUI

struct LoginPage: View {
    @StateObject var loginData: LoginPageModel = .init()
    var body: some View {
        VStack {
            Text("Tekrar Hoşgeldiniz 👻")
                .font(.custom("AmericanTypewriter-Bold", fixedSize: 46))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: getRect().height / 4)
                .padding()
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    Text(loginData.registerUser ? "Kayıt" : "Giriş")
                        .font(.custom("AmericanTypewriter-Bold", fixedSize: 20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    customTextField(icon: "envelope", title: "Email", hint: "mehmetalier83@hotmail.com", value: $loginData.email, showPassword: $loginData.showPassword)
                        .padding(.top, 4)
                    customTextField(icon: "lock", title: "Şifre", hint: "12345678", value: $loginData.password, showPassword: $loginData.showPassword)
                        .padding(.top, 4)
                    // Register
                    if loginData.registerUser {
                        customTextField(icon: "lock", title: "Şifreyi yeniden giriniz", hint: "123456", value: $loginData.re_enter_password, showPassword: $loginData.showReEnterPassword)
                            .padding(.top, 4)
                    }
                    // Şifremi Unuttum
                    Button(action: {
                        loginData.ForgotPassword()
                    }, label: {
                        Text("Şifremi Unuttum")
                            .foregroundColor(Color("lila"))
                            .font(.custom("AmericanTypewriter-Bold", fixedSize: 14))
                    })

                    .padding(.top, 4)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Button(action: {
                        if loginData.registerUser {
                            loginData.register()
                        }
                        else {
                            loginData.login()
                        }
                    }, label: {
                        Text("Giriş Yap")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(Color("lila"))
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.07), radius: 5, x: 5, y: 5)
                            .font(.custom("AmericanTypewriter-Bold", fixedSize: 23))
                    })
                    .padding(.top, 5)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .center)

                    // Kullanıcı kaydı

                    Button(action: {
                        withAnimation {
                            loginData.registerUser.toggle()
                        }
                    }, label: {
                        Text(loginData.registerUser ? "Giriş yapın" : "Kayıt Oluştur")
                            .foregroundColor(Color("lila"))
                            .font(.custom("AmericanTypewriter-Bold", fixedSize: 16))
                    })
                    .padding(.top, 6)
                }

                .padding(30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                    .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25))
                    .ignoresSafeArea()
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("lila"))
        .onChange(of: loginData.registerUser) { _ in
            loginData.email = ""
            loginData.password = ""
            loginData.re_enter_password = ""
            loginData.showPassword = false
            loginData.showReEnterPassword = false
        }
    }

    @ViewBuilder
    func customTextField(icon: String, title: String, hint: String, value:
        Binding<String>, showPassword: Binding<Bool>) -> some View
    {
        VStack(alignment: .leading, spacing: 12) {
            Label {
                Text(title)
            } icon: {
                Image(systemName: icon)
            }
            .foregroundColor(Color.black.opacity(0.8))

            if title.contains("Şifre") && !showPassword.wrappedValue {
                SecureField(hint, text: value)
                    .padding(.top, 2)
            }
            else {
                TextField(hint, text: value)
                    .padding(.top, 2)
            }

            Divider()
                .background(Color.black.opacity(0.6))
        }
        .overlay {
            HStack {
                Spacer()
                if title.contains("Şifre") {
                    Button(action: {
                        showPassword.wrappedValue.toggle()
                    }, label: {
                        Text(showPassword.wrappedValue ? "Gizle" : "Göster")
                            .font(.custom("AmericanTypewriter-Bold", fixedSize: 12))
                            .foregroundColor(Color("lila"))

                    })
                    .offset(y: 8)
                }
            }
        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
