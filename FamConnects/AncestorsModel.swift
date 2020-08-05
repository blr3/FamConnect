//
//  Ancestors.swift
//  FamConnect
//
//  Created by Brianna R on 7/29/20.
//  Copyright © 2020 Brianna Richard. All rights reserved.
//

import Foundation

struct Ancestor: Decodable {
    var pid: Int
    var fullName: String?
    var sex: String?
    var birthLikeDate: Int
    var birthLikePlaceText: String?
}

class AncestorsModel {
    
    weak var delegate: Downloadable?
    let networkModel = Network()
    
    func downloadAncestors(parameters: [String: Any], url: String, completion: @escaping(_ completed: Bool)->()) {
        let request = networkModel.request(parameters: parameters, url: url)
        networkModel.response(request: request) { (data) in
            let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            print(json)
            let model = try! JSONDecoder().decode([Ancestor]?.self, from: data) as [Ancestor]?
            self.delegate?.didReceiveData(data: model! as [Ancestor])
            return completion(true)
        }
        
    }
    
    func insertAncestors(parameters: [String: Any], url: String, completion: @escaping(_ completed: Bool)->()) {
        let request = networkModel.insert(parameters: parameters, url: url)
        networkModel.response(request: request) { (data) in
            print(data)
            return completion(true)
        }
    }
    
    func deleteAncestor(parameters: [String: Any], url: String, completion: @escaping(_ completed: Bool)->()) {
        let request = networkModel.delete(parameters: parameters, url: url)
        networkModel.response(request: request) { (data) in
            print(data)
            return completion(true)
        }
    }
}
