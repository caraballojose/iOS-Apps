//
//  HeaderView.swift
//  Nasa
//
//  Created by Jose Caraballo on 24/10/21.
//

import SwiftUI
import Kingfisher

struct HeaderView: View {
    
    @Binding var apod: Apod
    
    @State private var isAnimationImage: Bool = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
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
                .padding([.vertical], 20)
                .scaleEffect(isAnimationImage ? 1.0 : 0.6)
        }// ZSTACK
        //.frame(height: 440)
        .onAppear() {
            withAnimation(.easeOut(duration: 1)) {
                isAnimationImage = true
            }
        }
    }
}

