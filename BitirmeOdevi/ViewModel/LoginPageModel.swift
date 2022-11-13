//
//  LoginPageModel.swift
//  BitirmeOdevi
//
//  Created by PRO10010 on 20.10.2022.
//

import SwiftUI

class LoginPageModel: ObservableObject {
    // Login Properties
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false
    // Register Properties
    
    @Published var registerUser: Bool = false
    @Published var re_enter_password: String = ""
    @Published var showReEnterPassword: Bool = false
    // Log Status
    @AppStorage("log_Status") var log_Status: Bool = false
    // Login call
    func login() {
        withAnimation {
            log_Status = true
        }
    }

    // Register call
    func register() {
        withAnimation {
            log_Status = true
        }
    }

    func ForgotPassword() {}
}
