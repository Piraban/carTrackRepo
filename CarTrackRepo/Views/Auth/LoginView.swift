//
//  LoginView.swift
//  CarTrackPiraba
//
//  Created by Piraba Nagkeeran on 5/6/21.
//

import SwiftUI
import Combine

struct LoginView: View {
    // MARK:- ENV variable declaration
    @EnvironmentObject var appState: AppState
    
    // MARK:- ENV variable declaration
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var countryName: String = ""
    @State private var isTextEditEnable = false
    @State private var isValidUsername = true
    @State private var isValidPassword = true
    @State private var isValidCountryName = true

    @State private var isShowCountryList = false
    @State private var selectedCountry: Country = .default
    @State private var isUserLogInFail = false
    @StateObject var authUserVM = LoginViewModel()
    
    // MARK:- variable declaration
    let verticalPaddingForForm = 16.0
    
    var selectedCountryName : String {
        return countryName.isEmpty ? "Select Country" : countryName
    }
    
    var isLoginButtonDisabled : Bool {
        return (username.isEmpty || password.isEmpty || countryName.isEmpty) ? true : false
    }
    
    //MARK:- Main View
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                if(authUserVM.isLoading) {
                    //TODO: - Show loading
                }
                
                loadView()
            }.padding(.horizontal , 16)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color("CarBlue"))
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            if authUserVM.countries.isEmpty {
                authUserVM.fetchCountries()
            }
        }
        
        .onReceive([self.authUserVM.isLoginSuccess].publisher) { newValue in
            print("---newValue----\(newValue)")
            if(newValue == LoginStatus.loggedIn){
                appState.isLoggedUser = true
            }else if(newValue == LoginStatus.loginFail){
                isUserLogInFail = true
            }
        }
    }
}

// MARK: - load UI view
private extension LoginView {
    func loadView() -> some View {
        VStack(alignment: .center) {
            headerView()
            if(isUserLogInFail){
                ErrorTextView(title: Text("usernameOrPassword"))
            }
            loginUsername
                .padding(.vertical, 16)
            loginPassword
                .padding(.bottom, 16)
            loginCountry
                .padding(.bottom, 16)
            loginButton
            
        }
    }
}
// MARK: - Header
private extension LoginView {
    
    func headerView() -> some View {
        VStack {
            Text("Login")
                .font(.title)
                .foregroundColor(.white)
                .fontWeight(.bold)
            
        }.padding(.top , 32)
        .padding(.bottom , 40)
        .padding(.horizontal , 45)
    }
}

// MARK: - Username
private extension LoginView {
    var loginUsername: some View {
        VStack {
            HStack {
                Image(systemName: "person")
                    .foregroundColor(.secondary)
                TextField("Enter Username" ,  text: self.$username)
                    .foregroundColor(Color.black)
                    .accentColor(Color("CarBlue"))
                    .textFieldStyle(PlainTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .foregroundColor(.black)
                    .onReceive(Just(self.username)) { newValue in
                        if(!newValue.isEmpty ){
                           
                        }
                    }
            }.padding()
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(!self.isValidUsername  ? Color("carRed") : Color("carGreyLigh") , lineWidth: 1))
            .background(Color.white)
            .cornerRadius(10)
            
            if(!self.isValidUsername){
                ErrorTextView(title: Text("emptyUsername"))
            }
        }
    }
}

// MARK: - Password
private extension LoginView {
    var loginPassword: some View {
        VStack {
            HStack {
                Image(systemName: "lock")
                    .foregroundColor(.secondary)
                SecureField("Enter password", text: $password)
                    .foregroundColor(Color.black)
            }.padding()
            .background(Color.white)
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(!self.isValidPassword  ? Color("carRed") : Color("carGreyLigh") , lineWidth: 1))
            
            if(!self.isValidPassword){
                ErrorTextView(title: Text("emptyPassword"))
            }
        }
      
    }
}

// MARK: - Country
private extension LoginView {
    var loginCountry: some View {
        VStack {
            HStack {
                Image(systemName: "paperplane")
                    .foregroundColor(.secondary)
                
                DisclosureGroup(selectedCountryName, isExpanded: $isShowCountryList) {
                    SearchBar(text: self.$countryName)
                        .frame(width: 300)
                    ForEach (filteredCountries , id: \.code){ country in
                        CountryRow(country: country)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                self.countryName = country.name
                                self.selectedCountry = country
                                self.isShowCountryList.toggle()
                            }
                    }
                    
                }
            }
            
            if(!self.isValidCountryName){
                ErrorTextView(title: Text("emptyCountry"))
            }
            
        }.padding()
        .background(Color.white)
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(!self.isValidPassword  ? Color("carRed") : Color("carGreyLigh") , lineWidth: 1))
    }
    
    
    private var filteredCountries: [Country] {
        if countryName.isEmpty {
            return authUserVM.countries
        } else {
            return authUserVM.countries.filter { $0.name.localizedCaseInsensitiveContains(countryName) }
        }
    }
}

// MARK: - Login Button
private extension LoginView {
    var loginButton: some View {
        VStack {
            Button(action: {
                if(username.isEmpty){
                    isValidUsername = false
                }else if(password.isEmpty){
                    isValidUsername = false
                }else if(countryName.isEmpty){
                    isValidCountryName = false
                }else {
                    //Call DB and check
                    authUserVM.isValidAuthUser(username: username, userPas: "\(password)", country: countryName)
                }

            }) {
                Text("Login").padding()
                
            }
            .background(Color.black)
            .cornerRadius(10)
            .frame(height: 48)
            .foregroundColor(Color.white)
            .background(isLoginButtonDisabled  ? Color.gray : Color.black)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke( Color.black, lineWidth: 1)
                    )
            .disabled(isLoginButtonDisabled)
            
        }.padding(.top, 25)
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
