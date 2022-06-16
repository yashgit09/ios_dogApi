//
//  DogAPI_Helper.swift
//  API_Pick
//
//  Created by Cambrian on 2022-05-09.
//

import Foundation

class DogAPI_Helper{
    private static var baseURL = URL(string: "https://dog.ceo/api/breeds/list/all")
    
    private static let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    

    static func fetchData(callback: @escaping ([String:[String]]) -> Void){
        let request = URLRequest(url: baseURL!)
        let task = session.dataTask(with: request) {
            data, _, error in
            if let data = data {
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
//                    callback(jsonData)
                    
                    guard
                        let jsonDictionary = jsonData as? [AnyHashable:Any],
                        let message = jsonDictionary["message"] as? [String:[String]]
                   
                    else { preconditionFailure("Not working") }
                    

                    callback(message)
                    print(message)
                } catch let e {
                    print("something went wrong \(e)")
                }
            }
        }
        task.resume()
    }
    
}
