//
//  ContentView.swift
//  CarTrackPiraba
//
//  Created by Piraba Nagkeeran on 5/6/21.
//

import SwiftUI

struct SplashView: View {
    //MARK:- Env Variable
    @EnvironmentObject var appState: AppState

    //MARK:- Variable
    let verticalPaddingForForm = 16.0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    //MARK:- State Variable
    @State var play = 0
    @State private var username: String = ""
    @State private var password: String = ""

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text("splash.descriptionStart")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                Text("splash.descriptionEnd")
                    .font(.title3)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                Spacer()
                LottieView(name: "carAnimation", play: $play)
                    .frame(height:200)

            }
        } .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color("CarBlue"))
        .edgesIgnoringSafeArea(.all)

        .onAppear {
            if(UserUtils.setupDB()) {
                appState.hasSetDB = true
            }else{
                //Set Error Screen
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
            .environmentObject(AppState())
    }
}
