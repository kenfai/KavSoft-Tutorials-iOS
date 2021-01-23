//
//  LoginViewModel.swift
//  PhoneAuthFirebase
//
//  Created by Ginger on 23/01/2021.
//

import SwiftUI
import Firebase

class LoginViewModel: ObservableObject {
    @Published var phNo = ""
    
    @Published var code = ""
    
    // Getting country Phone Code
    
    // DataModel For Error View
    @Published var errorMsg = ""
    @Published var error = false
    
    // storing CODE for verification
    @Published var CODE = ""
    
    @Published var gotoVerify = false
    
    // User Logged Status
    @AppStorage("log_Status") var status = false
    
    // Loading View
    @Published var loading = false
    
    func getCountryCode() -> String {
        let regionCode = Locale.current.regionCode ?? ""
        
        return countries[regionCode] ?? ""
    }
    
    // sending Code To User
    func sendCode() {
        // enabling testing code
        // disable when you need to test with real device
        
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        
        let number = "+\(getCountryCode())\(phNo)"
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { (CODE, err) in
            if let error = err {
                self.errorMsg = error.localizedDescription
                withAnimation {
                    self.error.toggle()
                }
                return
            }
            
            self.CODE = CODE ?? ""
            self.gotoVerify = true
        }
    }
    
    func verifyCode() {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.CODE, verificationCode: code)
        
        loading = true
        
        Auth.auth().signIn(with: credential) { (result, err) in
            self.loading = false
            
            if let error = err {
                self.errorMsg = error.localizedDescription
                
                withAnimation {
                    self.error.toggle()
                }
                return
            }
            
            // else, user logged in successfully
            withAnimation {
                self.status = true
            }
        }
    }
    
    func requestCode() {
        sendCode()
        withAnimation {
            self.errorMsg = "Code Sent Successfully."
            self.error.toggle()
        }
    }
}
