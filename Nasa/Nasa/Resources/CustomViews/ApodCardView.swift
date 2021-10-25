//
//  ApodCardView.swift
//  Nasa
//
//  Created by Jose Caraballo on 23/10/21.
//

import SwiftUI
import Kingfisher

struct ApodCardView: View {
    
    @State private var  isAnimating : Bool = false
    @ObservedObject var presenter : ContentPresenter
    var apod: Apod
    
    var body: some View {
        ZStack {
            VStack (spacing: 20) {
                //IMAGE
                KFImage(URL(string: apod.url))
                    .loadDiskFileSynchronously()
                    .cacheMemoryOnly()
                    .fade(duration: 0.25)
                    .onProgress { receivedSize, totalSize in  }
                    .onSuccess { result in  }
                    .onFailure { error in }
                    .resizable()
                    .scaledToFit()
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.6), radius: 8, x: 6, y: 8)
                    .scaleEffect(isAnimating ? 1.0 : 0.6)
                    .cornerRadius(10)
                    .padding(10)
                //Title
                Text(apod.title)
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.8), radius: 10, x: 6, y: 8)
                    .padding(.horizontal, 5)
                //Date
                Text(apod.date)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding([.horizontal], 16)
                    .frame(maxWidth: 480)
                //START
                NavigationLink(destination: ApodView(apod: apod)) {
                    HStack (spacing: 8) {
                        Text("View More")
                        
                        Image(systemName: "arrow.right.circle")
                            .imageScale(.large)
                    }
                    .padding([.horizontal], 16)
                    .padding([.vertical], 10)
                    .background(
                        Capsule().strokeBorder(Color.white, lineWidth: 1.3)
                    )
                    .padding([.vertical], 4)
                }
            }

        } //: ZSTACK
        .onAppear(perform: {
            withAnimation(.easeOut(duration: 1.0)) {
                isAnimating = true
            }
        })
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(LinearGradient(gradient: Gradient(colors: [Color.blue,Color.black]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(20)
        .padding(.horizontal, 20)
    }
}

