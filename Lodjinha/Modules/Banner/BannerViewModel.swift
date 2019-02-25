//
//  BannerViewModel.swift
//  Lodjinha
//
//  Created by Adolfho Athyla on 24/02/19.
//  Copyright © 2019 a7hyla. All rights reserved.
//

import UIKit
import RxSwift

class BannerViewModel: NSObject {
    
    let disposeBag = DisposeBag()
    var slides = [Slide]()
    let provider = NetworkManager()
    
    // MARK: - create banners
    func createSlides(completion: @escaping (() -> ())) {
        BannerRepository.get(provider: provider, disposeBag: disposeBag) { (banners) in
            banners?.forEach({ (banner) in
                let slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
                _ = self.provider.getImage(url: banner.urlImagem ?? "", completion: { (image) in
                    slide.image.image = image
                })
                self.slides.append(slide)
            })
            completion()
        }
    }
}
