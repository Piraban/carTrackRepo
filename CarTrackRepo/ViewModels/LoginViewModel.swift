//
//  LoginViewModel.swift
//  CarTrackPiraba
//
//  Created by Piraba Nagkeeran on 5/6/21.
//

import Foundation
import Combine


enum LoginStatus {
    case NoLogin
    case loggedIn
    case loginFail

}

final class LoginViewModel: ObservableObject {
    // MARK:- Subscribers
    private var cancellable: AnyCancellable?
    // MARK:- Publishers
    // MARK:- Publishers
    @Published var listUsers: [User] = []
    @Published var countries: [Country] = []
    @Published var status = false
    @Published var isLoading = false
    @Published var isLoginSuccess: LoginStatus = LoginStatus.NoLogin

}

extension LoginViewModel {

    func isValidAuthUser(username: String, userPas: String, country: String)  {
        isLoading = true
        isLoginSuccess =  DBManagerImpl().isAuthUserExist(userName: username.lowercased(), userPassword: userPas, countryName: country) ? LoginStatus.loggedIn : LoginStatus.loginFail
        isLoading = false
    }
    
    func fetchCountries() {
        isLoading = true
        countries = RealCountriesService().load()
        isLoading = false
    }
}
