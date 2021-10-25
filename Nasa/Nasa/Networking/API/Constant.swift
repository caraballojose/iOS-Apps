//
//  ApiManager.swift
//  Nasa
//
//  Created by Jose Caraballo on 21/10/21.
//

import Foundation
import Combine

class Constant {
    
    static var apiKey: String {
        return "Ycm6WWDqqOgItd3a6g4dQxlL3fICBrlM7B3JAHiP"
    }
    
    static var baseUrl: String {
        return "https://api.nasa.gov/planetary/apod?"
    }
    
    static var url: URL {
        guard let url = URL(string: "\(baseUrl)api_key=\(apiKey)") else { fatalError() }
        return url
    }
    
    static var session: URLSession {
        let session = URLSession(configuration: .default)
        return session
    }
    
    static var request: URLRequest {
        let req = URLRequest(url: url)
        return req
    }
    
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
}

