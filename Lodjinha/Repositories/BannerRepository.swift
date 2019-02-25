//
//  BannerRepository.swift
//  Lodjinha
//
//  Created by Adolfho Athyla on 24/02/19.
//  Copyright © 2019 a7hyla. All rights reserved.
//

import UIKit
import RxSwift

class BannerRepository: NSObject {
    
    static func get(provider: Networkable, disposeBag: DisposeBag, completion: @escaping ((_ banners: [Banner]?) -> ())) {
        provider.getBanner(disposeBag: disposeBag) { (banners, success, error) in
            guard let banners = banners, success, error == nil else {
                print(error ?? "error")
                completion(nil)
                return
            }
            completion(banners)
        }
    }
    
}
