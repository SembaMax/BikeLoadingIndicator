//
//  LoadingIndicatorView.swift
//  TayarIndicator
//
//  Created by SeMbA on 7/17/19.
//  Copyright © 2019 SeMbA. All rights reserved.
//

import UIKit
import InfiniteLayout

class LoadingIndicatorView: UIView {
    
    @IBOutlet weak var backgroundCollectionView: InfiniteCollectionView!
    @IBOutlet weak var foregroundCollectionView: InfiniteCollectionView!
    @IBOutlet weak var tayarImage: UIImageView!
    
    var bgOffSet = 0
    var fgOffSet = 0
    
    /*override init(frame: CGRect) {
        super.init(frame: frame)
        
        initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initViews()
    }*/
    
    func initViews()
    {
        Bundle.main.loadNibNamed("LoadingIndicatorView", owner: self, options: nil)
        addSubview(backgroundCollectionView)
        addSubview(foregroundCollectionView)
        addSubview(tayarImage)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundCollectionView.register(UINib(nibName: "BackgroundCell", bundle: nil), forCellWithReuseIdentifier: "BackgroundCell")
        backgroundCollectionView.delegate = self
        backgroundCollectionView.dataSource = self
        
        foregroundCollectionView.register(UINib(nibName: "ForegroundCell", bundle: nil), forCellWithReuseIdentifier: "ForegroundCell")
        foregroundCollectionView.delegate = self
        foregroundCollectionView.dataSource = self
        
        autoScrollBackground()
        autoScrollForeground()
    }
    
    func startAnimation(withSound: Bool)
    {
        tayarImage.bikeEnteranceAnimation()
    }
    
    func stopAnimation(withSound: Bool)
    {
        tayarImage.bikeExitAnimation()
    }

    func autoScrollBackground()
    {
        let timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(backgroundTimerAction), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    func autoScrollForeground()
    {
        let timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(foregroundTimerAction), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    @objc func backgroundTimerAction() {
        bgOffSet += 4;
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, animations: {
                self.backgroundCollectionView.contentOffset.x = CGFloat(self.bgOffSet)
            })
        }
    }
    
    @objc func foregroundTimerAction() {
        fgOffSet += 8;
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, animations: {
                self.foregroundCollectionView.contentOffset.x = CGFloat(self.fgOffSet)
            })
        }
    }
}


extension LoadingIndicatorView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView == self.backgroundCollectionView) ?  collectionView.dequeueReusableCell(withReuseIdentifier: "BackgroundCell", for: indexPath) as! BackgroundCell : collectionView.dequeueReusableCell(withReuseIdentifier: "ForegroundCell", for: indexPath) as! ForegroundCell
        return cell
    }
}

extension LoadingIndicatorView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
    }
}

extension LoadingIndicatorView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 800, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView.frame.height
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}


