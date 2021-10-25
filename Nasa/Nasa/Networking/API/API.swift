//
//  API.swift
//  Nasa
//
//  Created by Jose Caraballo on 22/10/21.
//


import Foundation


class API {

    static let shared = API()

    public func loadData (_ onSuccess: @escaping ([Apod]) -> () ) {
    
        var urlComponents: URLComponents {
            
            guard var urlComponents = URLComponents(string: Constant.baseUrl) else { fatalError() }
            
            urlComponents.queryItems = [
                    //URLQueryItem(name: "date", value: "2021-10-23"),
                URLQueryItem(name: "start_date", value: Date.fiveDaysAgo()),
                URLQueryItem(name: "end_date", value: Date.getCurrentDate()),
                    //URLQueryItem(name: "count", value: "\(10)"),
                    URLQueryItem(name: "api_key", value: Constant.apiKey)
                ]
            return urlComponents
        }
        
        let task = URLSession.shared.dataTask(with: urlComponents.url!) { (data, res, error) in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                    print(json)
                }
                let apod = try Constant.decoder.decode([Apod].self, from: data)
                DispatchQueue.main.async {
                    onSuccess(apod)
                }

            } catch {
                fatalError(error.localizedDescription)
            }
        }
        task.resume()
    }
    
}

extension Date {

 static func getCurrentDate() -> String {

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd"

        return dateFormatter.string(from: Date())

    }

    static func fiveDaysAgo() -> String {
        
        let fromDate = Calendar.current.date(byAdding: .day, value: -5, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dayago = dateFormatter.string(from: fromDate!)
        return dayago
        
    }

}
