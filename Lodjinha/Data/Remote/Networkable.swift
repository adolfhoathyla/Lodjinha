//
//  Networkable.swift
//  Lodjinha
//
//  Created by Adolfho Athyla on 24/02/19.
//  Copyright © 2019 a7hyla. All rights reserved.
//

import UIKit
import Moya
import RxSwift

protocol Networkable {
    var provider: MoyaProvider<LodjinhaApi> { get }
    func getBanner(disposeBag: DisposeBag, completion: @escaping ((_ banners: [Banner]?, _ success: Bool, _ error: Error?) -> ()))
    func getImage(url: String, completion: @escaping ((_ image: UIImage?) -> ()))
}
