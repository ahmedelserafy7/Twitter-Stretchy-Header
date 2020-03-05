//
//  ViewController.swift
//  DragVisualEffect
//
//  Created by Elser_10 on 12/18/18.
//  Copyright © 2018 Elser_10. All rights reserved.
//

import UIKit

class StretchyHeaderController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let headerCellId = "headerCellId"
    fileprivate let cellId = "cellId"
    fileprivate let padding: CGFloat = 16
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionViewLayout()
        
        setupCollectionView()
    }
    
    fileprivate func setupCollectionView() {
        
        collectionView?.backgroundColor = .white
        
        collectionView.contentInsetAdjustmentBehavior = .never
        
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(HeaderViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellId)
    }
    
    fileprivate func setupCollectionViewLayout() {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            
            layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - padding * 2, height: 50)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        
        // to prevent header from blurring up, when dragging down.. so Use return
        if contentOffsetY >= 0 {
            
            headerCell?.activityIndicator.stopAnimating()
            headerCell?.activityIndicator.alpha = 0
            
            headerCell?.visualEffect.alpha = 0
            
            // make sure to get the fractionComplete back to zero when dragging down
            headerCell?.animator.fractionComplete = 0
            
            headerCell?.arrowImageView.alpha = 0
            
            return
        }
            
        else {
            
            headerCell?.visualEffect.alpha = 1
            headerCell?.animator.fractionComplete = abs(contentOffsetY) / 10
            
            self.headerCell?.arrowImageView.alpha = 1
            
            UIView.animate(withDuration: 0.5, delay: 0.6, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                
                self.headerCell?.activityIndicator.alpha = 1
                self.headerCell?.activityIndicator.startAnimating()
                
            }, completion: { (_) in
                self.headerCell?.arrowImageView.alpha = 0
            })
            
        }
        
    }
    
    func delay(_ delay: Double, closure: @escaping ()->()) {
        let time = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: time, execute: closure)
        
    }
    
    var headerCell: HeaderViewCell?
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCellId, for: indexPath) as? HeaderViewCell
        return headerCell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let height = view.frame.width * (9 / 16)
        return CGSize(width: view.frame.width, height: height)
    }

}


