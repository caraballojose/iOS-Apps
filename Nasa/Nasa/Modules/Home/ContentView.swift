//
//  ContentView.swift
//  Nasa
//
//  Created by Jose Caraballo on 21/10/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isShowingSettings : Bool = false
    @ObservedObject var presenter = ContentPresenter()
    
    var body: some View {
        NavigationView {
            
            TabView {
                ForEach(presenter.apods) { item in
                    ApodCardView(presenter: presenter, apod: item)
                    
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .navigationBarHidden(true)
//            .navigationBarItems(
//                trailing: Button(action: {
//                    isShowingSettings = true
//                }, label: {
//                    Image(systemName: "slider.horizontal.3")
//                })//: BUTTON
//                .sheet(isPresented: $isShowingSettings, content: {
//                    //SettingsView()
//                })
//            )
        }//: NAVIGATION
        .navigationViewStyle(StackNavigationViewStyle())
        .preferredColorScheme(.dark)
    }

}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(apods: )
//    }
//}
