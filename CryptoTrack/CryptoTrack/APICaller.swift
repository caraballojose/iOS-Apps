//
//  APICaller.swift
//  CryptoTrack
//
//  Created by Jose Caraballo on 10/5/21.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private struct Constants {
        static let apiKay = "A42B57A7-311F-4949-8B8B-B708D032210D"
        static let assestsEndpoint = "https://rest-sandbox.coinapi.io/v1/assets/"
    }
    
    private init() {}
    
    public var icons: [Icon] = []
    
    private var whenReadyBlock: ((Result<[Crypto], Error>) -> Void)?
    
    //MARK:- Public
    
    public func getAllCryptoData (completion: @escaping (Result<[Crypto], Error>) -> Void) {
        guard !icons.isEmpty else {
            whenReadyBlock = completion
            return
        }
        
        guard let url = URL(string: Constants.assestsEndpoint + "?apikey=" + Constants.apiKay) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                
                completion(.success(cryptos.sorted { first, second -> Bool in
                    return first.price_usd ?? 0 > second.price_usd ?? 00
                }))
                
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    public func getAllIcons() {
        guard let url = URL(string: "https://rest-sandbox.coinapi.io/v1/assets/icons/55/?apikey=A42B57A7-311F-4949-8B8B-B708D032210D") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                self?.icons = try JSONDecoder().decode([Icon].self, from: data)
                if let completion = self?.whenReadyBlock {
                    self?.getAllCryptoData(completion: completion)
                }
                
                
            } catch {
                print(error)
            }
        }
        task.resume()
        
    }

}
