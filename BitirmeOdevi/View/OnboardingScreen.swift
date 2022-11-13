//
//  OnboardingScreen.swift
//  BitirmeOdevi
//
//  Created by PRO10010 on 19.10.2022.
//

import SwiftUI

struct OnboardingScreen: View {
    @State var showLoginPage: Bool = false
    var body: some View {
        VStack {
            Text("Zubi'ye Hoşgeldin 🖐")
                .font(.custom("AmericanTypewriter-Bold", fixedSize: 32))
                .foregroundColor(.white)
            Text("Teknolojinin marketi...")
                .font(.custom("AmericanTypewriter-Bold", fixedSize: 18))
                .foregroundColor(.white)
            Image("onboarding")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Button {
                withAnimation{
                    showLoginPage = true
                }
            } label: {
                Text("Hadi Başlayalım")
                    .font(.custom("AmericanTypewriter-Bold", fixedSize: 18))
                    .padding(.vertical, 18)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(14)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                    .foregroundColor(Color("lila"))
                Spacer()
            }
            .padding(.horizontal, 25)
            .offset(y: getRect().height < 750 ? 20 : 40)
        }
        .padding(.top, getRect().height < 750 ? 20 : 0)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color("lila")
        )
        .overlay(
            Group {
                if showLoginPage {
                    LoginPage()
                        .transition(.move(edge: .bottom))
                }
            }
        )
    }
}

struct OnboardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreen()
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
