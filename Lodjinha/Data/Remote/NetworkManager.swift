//
//  NetworkManager.swift
//  Lodjinha
//
//  Created by Adolfho Athyla on 24/02/19.
//  Copyright © 2019 a7hyla. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import Alamofire

class NetworkManager: Networkable {
    
    var provider = MoyaProvider<LodjinhaApi>(plugins:
        [NetworkLoggerPlugin(verbose: true),
         NetworkActivityPlugin(networkActivityClosure: { (networkChangeType, targetType) in
            switch networkChangeType {
            case .began:
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            case .ended:
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
         })]
    )
    
    func getBanner(disposeBag: DisposeBag, completion: @escaping (([Banner]?, Bool, Error?) -> ())) {
        provider.rx.request(.getBanner()).Rmap(to: DataRequest.self).subscribe { (event) in
            switch event {
            case .success(let data):
                completion(data.data, true, nil)
            case .error(let error):
                completion(nil, false, error)
            }
        }.disposed(by: disposeBag)
    }
    
    func getImage(url: String, completion: @escaping ((UIImage?) -> ())) {
        Alamofire.request(url).responseData(completionHandler: { (data) in
            guard let data = data.data else {
                completion(nil)
                return
            }
            completion(UIImage(data: data))
        })
    }

}
