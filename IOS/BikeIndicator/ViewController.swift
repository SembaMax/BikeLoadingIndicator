//
//  ViewController.swift
//  TayarIndicator
//
//  Created by SeMbA on 7/16/19.
//  Copyright © 2019 SeMbA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var indicatorView: UIView!
    var loadingNib: LoadingIndicatorView? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        initIndicatorView()
        
        self.loadingNib?.startAnimation(withSound: true)
        
        let now = DispatchTime.now()
        DispatchQueue.main.asyncAfter(deadline: now + 7) {
            self.loadingNib?.stopAnimation(withSound: true)
        }
    }
    
    
    func initIndicatorView()
    {
        loadingNib = UINib(nibName: "LoadingIndicatorView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! LoadingIndicatorView
        
        indicatorView.addSubview(loadingNib! as UIView)
        loadingNib?.frame = indicatorView.bounds
        loadingNib?.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
}
