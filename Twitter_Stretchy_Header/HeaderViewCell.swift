//
//  HeaderViewCell.swift
//  DragVisualEffect
//
//  Created by Elser_10 on 3/4/20.
//  Copyright © 2020 Elser_10. All rights reserved.
//

import UIKit

class HeaderViewCell: UICollectionViewCell {
    
    let backgroundImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "taylor"))
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    
    let activityIndicator: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .white)
        aiv.alpha = 0
        aiv.hidesWhenStopped = true
        aiv.translatesAutoresizingMaskIntoConstraints = false
        return aiv
    }()
    
    let arrowImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "arrow").withRenderingMode(.alwaysTemplate))
        iv.tintColor = .white
        iv.alpha = 0
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(backgroundImageView)
        
        backgroundImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        setupVisualEffectBlur()
        setupArrowImageView()
        setupActivityIndicator()
    }
    
    var animator: UIViewPropertyAnimator!
    func setupVisualEffectBlur() {
        
        animator = UIViewPropertyAnimator(duration: 2.0, curve: .linear, animations: {[weak self] in
            self?.setupVisualEffectViewConstraints()
        })
    }
    
    var visualEffect = UIVisualEffectView()
    func setupVisualEffectViewConstraints() {
        
        let blurEffect = UIBlurEffect(style: .dark)
        
        visualEffect.effect = blurEffect
        visualEffect.alpha = 1
        
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(visualEffect)
        
        visualEffect.topAnchor.constraint(equalTo: topAnchor).isActive = true
        visualEffect.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        visualEffect.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        visualEffect.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    
    func setupArrowImageView() {
        
        addSubview(arrowImageView)
        
        arrowImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        arrowImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        arrowImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        arrowImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
    func setupActivityIndicator() {
        
        visualEffect.contentView.addSubview(activityIndicator)
        
        activityIndicator.centerXAnchor.constraint(equalTo: visualEffect.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: visualEffect.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
