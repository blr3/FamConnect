//
//  Network.swift
//  FamConnect
//
//  Created by Brianna R on 7/29/20.
//  Copyright © 2020 Brianna Richard. All rights reserved.
//

import Foundation

protocol Downloadable: class {
    func didReceiveData(data: Any)
}

enum URLServices {
    static let getAncestors: String = "https://famconnect.web.illinois.edu/service2.php"
    static let insertAncestors: String = "https://famconnect.web.illinois.edu/insert.php"
    static let updateAncestors: String = "https://famconnect.web.illinois.edu/update.php"
    static let deleteAncestors: String = "https://famconnect.web.illinois.edu/delete.php"
    static let familyTree: String = "https://famconnect.web.illinois.edu/testAlgo.php"
}

class Network{
    func request(parameters: [String: Any], url: String) -> URLRequest {
        var request = URLRequest(url: URL(string: url)!)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = parameters.percentEscaped().data(using: .utf8)
        return request
    }
    
    func insert(parameters: [String: Any], url: String) -> URLRequest {
        var request = URLRequest(url: URL(string: url)!)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = parameters.percentEscaped().data(using: .utf8)
        return request
    }
    
    func update(parameters: [String: Any], url: String) -> URLRequest {
        var request = URLRequest(url: URL(string: url)!)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = parameters.percentEscaped().data(using: .utf8)
        return request
    }
    
    func delete(parameters: [String: Any], url: String) -> URLRequest {
        var request = URLRequest(url: URL(string: url)!)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = parameters.percentEscaped().data(using: .utf8)
        return request
    }
    
    func familyTree(parameters: [String: Any], url: String) -> URLRequest {
        var request = URLRequest(url: URL(string: url)!)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = parameters.percentEscaped().data(using: .utf8)
        return request
    }

    func response(request: URLRequest, completionBlock: @escaping (Data) -> Void) -> Void {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {   // check for fundamental networking error
                    print("error", error ?? "Unknown error")
                    return
            }
            guard (200 ... 299) ~= response.statusCode else { //check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            // data will be available for other models that implements the block
            completionBlock(data);
        }
        task.resume()
    }
}

extension Dictionary {
    func percentEscaped() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
            }
            .joined(separator: "&")
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
