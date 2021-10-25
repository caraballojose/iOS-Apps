//
//  APOD.swift
//  Nasa
//
//  Created by Jose Caraballo on 21/10/21.
//

import Foundation

// MARK: - Apod
struct Apod: Codable, Identifiable {
    let id = UUID()
    let explanation: String
    let date: String
    let title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case date = "date"
        case explanation = "explanation"
        case url = "url"
        case title = "title"
    }
    
    
}
