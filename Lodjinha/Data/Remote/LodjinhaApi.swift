//
//  LodjinhaApi.swift
//  Lodjinha
//
//  Created by Adolfho Athyla on 24/02/19.
//  Copyright © 2019 a7hyla. All rights reserved.
//

import UIKit
import Moya

enum LodjinhaApi {
    case getBanner()
}

extension LodjinhaApi: TargetType {
    var baseURL: URL {
        return URL(string: "https://alodjinha.herokuapp.com")!
    }
    
    var path: String {
        switch self {
        case .getBanner():
            return "/banner"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getBanner():
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getBanner():
            return stubbedResponse("Banner")
        }
    }
    
    var task: Task {
        switch self {
        case .getBanner():
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}


extension LodjinhaApi {
    func stubbedResponse(_ filename: String) -> Data! {
        @objc class TestClass: NSObject { }
        
        let bundle = Bundle(for: TestClass.self)
        let path = bundle.path(forResource: filename, ofType: "json")
        return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
    }
}

