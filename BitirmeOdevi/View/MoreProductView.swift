//
//  MoreProductView.swift
//  BitirmeOdevi
//
//  Created by PRO10010 on 13.11.2022.
//

import SwiftUI

struct MoreProductView: View {
    var body: some View {
        
        VStack{
            Text("Daha Fazla Ürün")
                .font(.custom("AmericanTypewriter-Bold", fixedSize: 24).bold())
                .foregroundColor(.black)
                .frame(maxWidth: .infinity,alignment: .leading)
        }
        .padding()
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)
        .background().ignoresSafeArea()
        
    }
}

struct MoreProductView_Previews: PreviewProvider {
    static var previews: some View {
        MoreProductView()
    }
}
