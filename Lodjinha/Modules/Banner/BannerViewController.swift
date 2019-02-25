//
//  BannerViewController.swift
//  Lodjinha
//
//  Created by Adolfho Athyla on 24/02/19.
//  Copyright © 2019 a7hyla. All rights reserved.
//

import UIKit

class BannerViewController: UIViewController {

    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var scrollView: UIScrollView!
    
    let viewModel = BannerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        viewModel.createSlides {
            self.setupSlideScrollView(slides: self.viewModel.slides)
            self.configurePageControl()
        }
    }
    
    // MARK: - scroll view
    func setupSlideScrollView(slides: [Slide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0..<slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
    // MARK: - configure page control
    func configurePageControl() {
        pageControl.numberOfPages = viewModel.slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
    }
    
    // MARK: - update layout when change orientation
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setupSlideScrollView(slides: viewModel.slides)
        configurePageControl()
    }
}

extension BannerViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
}
