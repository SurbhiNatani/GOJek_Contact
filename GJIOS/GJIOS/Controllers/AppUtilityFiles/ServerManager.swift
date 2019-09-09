//
//  ServerManager.swift
//  GJIOS
//
//  Created by Shurbhi Natani on 06/09/19.
//  Copyright © 2019 Surbhi Natani. All rights reserved.
//

import Foundation

class ServerManager {
  
    static let shared : ServerManager = ServerManager()
    
    static func getRequest(url: String, requestMethod: String, completion: @escaping (Error?, [[String: Any]]?) -> Void){
        
        let session = URLSession(configuration: .default)
        let urlString = String(format: url)
        
        var request : URLRequest = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = requestMethod
        request.timeoutInterval = 30
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        let dataTask =  session.dataTask(with: request) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse, let receivedData = data
                else {
                    print("error: not a valid http response")
                    return
            }
            
            switch (httpResponse.statusCode)
            {
            case 200:
                
                let res = String(data: receivedData, encoding: String.Encoding.ascii)
                print("response is \(String(describing: res))")
                let asciiData = res?.data(using: String.Encoding.utf8, allowLossyConversion: true)
                
                do {
                    let getResponse = try JSONSerialization.jsonObject(with: asciiData!, options: [])
                    completion(nil, getResponse as? [[String: Any]])
                    print(getResponse)
                    
                } catch {
                    print("error serializing JSON: \(error)")
                    completion(error, nil)
                }
            
            default:
                print("wallet GET request got response \(httpResponse.statusCode)")
            }
        }
        
        dataTask.resume()
    }
    
    
    static func postRequest(url: String, requestMethod: String, params: [String: Any] ,completion: @escaping (Error?, [String: Any]?) -> Void){
        
        let jsonData = try? JSONSerialization.data(withJSONObject: params)
        
        // create post request
        let urlString = URL(string: url)!
        var request = URLRequest(url: urlString)
        request.httpMethod = requestMethod
        request.timeoutInterval = 30
        
        // insert json data to the request
        request.httpBody = jsonData
        
        //insert header
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                completion(error, nil)
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                completion(nil, responseJSON)
            }
        }
        
        dataTask.resume()
    }
    
  
}
