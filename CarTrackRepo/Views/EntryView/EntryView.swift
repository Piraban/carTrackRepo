//
//  EntryView.swift
//  CarTrackPiraba
//
//  Created by Piraba Nagkeeran on 5/6/21.
//

import SwiftUI


struct EntryView: View {
    // MARK:- ENV variable declaration
    @EnvironmentObject var appState: AppState
    
    // MARK:- state variable declaration
    @State private var timeRemaining = 5
    @State var isSplashShown : Bool = true
    
    // MARK:- variable declaration
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        appContentStatus
            
            .onReceive(timer) { time in
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                }else{
                    isSplashShown = false
                }
            }
    }

    private  var appContentStatus: AnyView {
        if(isSplashShown){
            return AnyView(SplashView())
        }else if(appState.isSessionExpired){
            return AnyView(LoginView())
        }else if(appState.isLoggedUser) {
            return AnyView(ListUsersView())
        }else{
            return AnyView(LoginView())
        }
    }
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView()
            .environmentObject(AppState())
    }
}
