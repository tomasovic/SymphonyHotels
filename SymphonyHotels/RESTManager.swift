//
//  WebServiceManager.swift
//  SymphonyHotels
//
//  Created by Milan Tomasovic on 7/4/17.
//  Copyright © 2017 Milan Tomasovic. All rights reserved.
//

import UIKit


/// HTTP methods
///
/// - get: GET data
/// - post: POST data
/// - put: UPDATE data
/// - delete: DELETE data
enum HttpMethod: String {
    case get =      "GET"
    case post =     "POST"
    case put =      "PUT"
    case delete =   "DELETE"
}


/// HTTP response
///
/// - success: success
/// - created: created
/// - error: error
/// - serverError: serverError
/// - undefined: undefined
/// - notFound: notFound
/// - noContent: noContent
enum Status: Int {
    case success =      200
    case created =      201
    case error =        400
    case serverError =  500
    case undefined =    0
    case notFound =     404
    case noContent =    204
}

typealias JSON = [String: Any]
typealias JSONArray = [JSON]

class RESTManager: NSObject {
    
    // MARK: Properties
    static let shared = RESTManager()
    private override init() {}
    
    // MARK: Public Methods
    
    
    /// Checking Internet connection
    ///
    /// - Returns: Connected or not
    func hasInternetConnection() -> Bool {
        let reachability = Reachability()
        
        return reachability!.isReachable
    }
    
    
    /// Loading data from the REST.
    ///
    /// - Parameters:
    ///   - urlString: REST, API url
    ///   - method: Method for data request
    ///   - parameters: Parameters ( /?/ )
    ///   - completion: completion
    func loadData(from urlString: String, method: HttpMethod, parameters: JSON?, completion: @escaping (_ status: Status, _ data: Any?) -> ()) {
        if hasInternetConnection() {
            if let url = URL(string: urlString) {
                var request = URLRequest(url: url)
                let session = URLSession(configuration: URLSessionConfiguration.ephemeral)
                
                request.httpMethod = method.rawValue
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                if let token = UserDefaults.standard.object(forKey: TOKEN) as? String {
                    request.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
                }
                
                if let parameters = parameters {
                    do {
                        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
                
                let task = session.dataTask(with: request) { (data, response, error) in
                    var status = Status.undefined
                    if let httpResponse = response as? HTTPURLResponse {
                        status = Status.init(rawValue: httpResponse.statusCode)!
                    }
                    
                    if let error = error {
                        DispatchQueue.main.async(execute: {
                            completion(status, nil)
                            print("Error = \(String(describing: error))")
                        })
                    }
                    
                    // Data acquired
                    do {
                        if let data = data {
                            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                            
                            DispatchQueue.main.async(execute: {
                                completion(status, json)
                            })
                        } else {
                            DispatchQueue.main.async(execute: {
                                completion(status, nil)
                            })
                        }
                    } catch let error as NSError {
                        DispatchQueue.main.async(execute: {
                            completion(status, nil)
                        })
                        
                        print("JSON error: \(error.localizedDescription)")
                    }
                }
                
                task.resume()
            } else {
                DispatchQueue.main.async(execute: {
                    completion(Status.error, nil)
                })
            }
        }
    }
    
}
