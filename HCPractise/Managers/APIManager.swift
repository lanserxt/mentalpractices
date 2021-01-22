//
//  APIManager.swift
//  HCPractise
//
//  Created by Anton Gubarenko on 21.01.2021.
//

import UIKit
import SwiftyJSON

enum HTTPMethod: String {
    case get, post, put, delete, patch
}

final class APIManager: NSObject {
    
    static let shared = APIManager()
    
    //MARK:- General Request
    
    private let timeoutInterval = 60.0
    
    func makeRequest<T: Codable>(url: String, httpMethod: HTTPMethod, params: JSON?, typeOf: T.Type, completionHandler: @escaping (Swift.Result<T, NetworkError>) -> Void) {
        
        var request = URLRequest(url: URL(string: url, relativeTo: nil)!)
        request.httpMethod = httpMethod.rawValue.uppercased()
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(Constants.APIKeys.bearer)", forHTTPHeaderField: "Authorization")
        request.timeoutInterval = timeoutInterval
        if let params = params {
            do {
                let body = try params.rawData()
                request.httpBody = body
            }
            catch {
                print("Error making body: \(error)")
            }
        }
        
        DispatchQueue.main.async {UIApplication.shared.isNetworkActivityIndicatorVisible = true}
        let dataTask =  URLSession.shared.dataTask(with: request) {[unowned self] (data, response, respError) in
            
            DispatchQueue.main.async {UIApplication.shared.isNetworkActivityIndicatorVisible = false}
            
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {completionHandler(.failure(NetworkError(error: respError)))}
                return
            }
            
            if let respError = respError {
                    DispatchQueue.main.async {completionHandler(.failure(NetworkError(error: respError)))}
                    return
            }
            
            if let rawData = data {
                do {
                    let cardsResponse = try JSONDecoder().decode(T.self, from: rawData)
                    DispatchQueue.main.async {completionHandler(.success(cardsResponse))}
                    return
                } catch {
                    if let errorObj = try? JSONDecoder().decode(NetworkError.self, from: rawData) {
                        DispatchQueue.main.async {completionHandler(.failure(errorObj))}
                    } else {
                        DispatchQueue.main.async {completionHandler(.failure(NetworkError(error: error)))}
                    }
                }
            }
            else {
                DispatchQueue.main.async { completionHandler(.failure(NetworkError()))}
                return
            }
            
        }
        dataTask.resume()
        
    }
    
    
    
    
    
}

//MARK:- Profile
extension APIManager {
    
    func getUser(completionHandler: @escaping (Swift.Result<User, NetworkError>) -> Void ) {
        
        let requestString = APIInfo.userInfo
        makeRequest(url: requestString,
                    httpMethod: .get,
                    params: nil,
                    typeOf: ResponseContainer<User>.self) { (result) in
            switch result {
            case .success(let response):
                completionHandler(.success(response.data))
                break
            case .failure(let error):
                completionHandler(.failure(error))
                break
            }
        }
    }
}

//MARK:- Practices
extension APIManager {
    
    func getPractices(completionHandler: @escaping (Swift.Result<[Practice], NetworkError>) -> Void ) {
        
        let requestString = APIInfo.practices
        makeRequest(url: requestString,
                    httpMethod: .get,
                    params: nil,
                    typeOf: ResponseArrayContainer<Practice>.self) {(result) in
            switch result {
            case .success(let response):
                completionHandler(.success(response.data))
                break
            case .failure(let error):
                completionHandler(.failure(error))
                break
            }
        }
    }
}
