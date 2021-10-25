//
//  ApodView.swift
//  Nasa
//
//  Created by Jose Caraballo on 24/10/21.
//

import SwiftUI
import Kingfisher
struct ApodView: View {
    
    @State var apod : Apod
    @State private var isAnimationImage: Bool = false
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20) {
                    //HEADER
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [Color.black, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        KFImage(URL(string: apod.url))
                                  .loadDiskFileSynchronously()
                                  .cacheMemoryOnly()
                                  .fade(duration: 0.25)
                                  .onProgress { receivedSize, totalSize in  }
                                  .onSuccess { result in  }
                                  .onFailure { error in }
                            .resizable()
                            .scaledToFit()
                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y: 8)
                            .padding(20)
                            .scaleEffect(isAnimationImage ? 1.0 : 0.6)
                    }// ZSTACK
                    //.frame(height: 350)
                    .padding(.top, 20)
                    .onAppear() {
                        withAnimation(.easeOut(duration: 1)) {
                            isAnimationImage = true
                        }
                    }
                    VStack(alignment: .leading, spacing: 20) {
                    //TITLE
                        Text(apod.title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            //.foregroundColor()
                    //HEADLINE
                        Text(apod.date)
                            .font(.headline)
                            .multilineTextAlignment(.leading)
                    //NUTRIENTS
                        //FruitNutrientsView(fruit: fruit)
                    //SUBHEADLINE
                        Text("Learn more about \(apod.title)".uppercased())
                            .fontWeight(.bold)
                            //.foregroundColor(fruit.gradientColors[1])
                        
                    //DESCRIPTION
                        Text(apod.explanation)
                            .multilineTextAlignment(.leading)
                    //LINK
//                        SourceLinkView()
//                            .padding(.top, 10)
//                            .padding(.bottom, 40)
                    }//VSTACK
                    .padding([.horizontal], 20)
                    .frame(maxWidth: 640, alignment: .center)
                }//VSTACK
                .navigationBarTitle(apod.title, displayMode: .inline)
                .navigationBarHidden(true)
            } // SCROLL
            .edgesIgnoringSafeArea(.top)
        }// NAVIGATION
    
        
    }
}

//struct ApodView_Previews: PreviewProvider {
//    static var previews: some View {
//        FruitDetailView(fruit: fruitsData[0])
//    }
//}
