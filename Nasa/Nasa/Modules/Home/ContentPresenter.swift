//
//  CotentPresenter.swift
//  Nasa
//
//  Created by Jose Caraballo on 21/10/21.
//

import Foundation
import Combine
import SwiftUI

class ContentPresenter: ObservableObject {
    
    @Published var apods : [Apod] = []
    
    init() {
        self.fetch()
    }

    func fetch() {
        API.shared.loadData { apod in
            self.apods = apod
        }
    }
    
}

