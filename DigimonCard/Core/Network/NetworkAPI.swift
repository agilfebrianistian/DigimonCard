//
//  NetworkAPI.swift
//  Network Manager Framework
//
//  Created by Agil Febrianistian on 04/02/19.
//  Copyright © 2019 agil. All rights reserved.
//

import UIKit
import Moya
import Foundation
import Alamofire

enum NetworkAPI {
    case getDigimonList(param: DigimonListParameter)
    case getDigimonDetail(name: String)
}

// MARK: - TargetType Protocol Implementation
extension NetworkAPI: NetworkTarget {
    var baseURL: URL {
        return URL(string: NetworkConstant.APIConstant.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getDigimonList:
            return "digimon"
        case .getDigimonDetail(name: let name):
            return "digimon/\(name)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getDigimonList(let param):
            return .requestParameters(parameters: param.asDictionary ?? [:],
                                      encoding: URLEncoding.default)
        default :
            return .requestPlain
        }
    }
    
    var sampleData: Data {
        switch self {
        default:
            return "".utf8Encoded
        }
    }
    
    var headers: [String: String]? {
        return ["Accept":"application/json"]
    }
    
}
