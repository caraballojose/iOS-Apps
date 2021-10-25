//
//  NasaApp.swift
//  Nasa
//
//  Created by Jose Caraballo on 21/10/21.
//

import SwiftUI

@main
struct NasaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(presenter: ContentPresenter())
        }
    }
}
