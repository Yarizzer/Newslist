//
//  BackButton.swift
//  NewsList
//
//  Created by Yarr!zzeR on 30/01/2019.
//  Copyright © 2019 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class BackButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        animateButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        animateButton()
    }
    
    private func setupView() {
        self.frame = CGRect(origin: .zero, size: CGSize(width: Constants.frameWidth, height: Constants.frameHeight))
        self.setTitle(Constants.title, for: .normal)
        self.backgroundColor = Constants.firstBackgroundColor
        self.layer.cornerRadius = Constants.cornerRadius
        self.layer.masksToBounds = true
        self.layer.borderColor = Constants.borderColor.cgColor
        self.layer.borderWidth = Constants.borderWidth
    }
    
    private func animateButton() {
        
        let backgroundColorAnimation = CAKeyframeAnimation(keyPath: Constants.backgroundColorAnimationKeyPath)
        backgroundColorAnimation.duration = Constants.animationDuration
        backgroundColorAnimation.values = [Constants.firstBackgroundColor.cgColor,
                                           Constants.firstBackgroundColor.cgColor,
                                           Constants.secondBackgroundColor.cgColor,
                                           Constants.secondBackgroundColor.cgColor,
                                           Constants.firstBackgroundColor.cgColor]
        backgroundColorAnimation.keyTimes = Constants.keyTimes
        backgroundColorAnimation.timingFunctions = Constants.timingFunctions
        backgroundColorAnimation.repeatCount = Constants.repeatCount
        backgroundColorAnimation.beginTime = Constants.startMoment
        backgroundColorAnimation.isRemovedOnCompletion = Constants.removedOnCompletionFlag
        self.layer.add(backgroundColorAnimation, forKey: Constants.backgroundColorAnimationKeyPath)
        
        
        let rotationTransformForTitle = CATransform3DMakeRotation(Constants.rotationAngle, 1, 0, 0)
        self.titleLabel?.layer.transform = rotationTransformForTitle
        
        let titleRotationAnimation = CAKeyframeAnimation(keyPath: Constants.titleRotationAnimationKeyPath)
        titleRotationAnimation.duration = Constants.animationDuration
        
        titleRotationAnimation.values = Constants.titleRotationValues
        titleRotationAnimation.keyTimes = Constants.titleRotationKeyTimes
        
        titleRotationAnimation.timingFunctions = Constants.timingFunctions
        titleRotationAnimation.repeatCount = Constants.repeatCount
        titleRotationAnimation.beginTime = Constants.startMoment
        titleRotationAnimation.isRemovedOnCompletion = Constants.removedOnCompletionFlag
        self.titleLabel?.layer.add(titleRotationAnimation, forKey: Constants.titleRotationAnimationKeyPath)
    }
    
}

extension BackButton {
    private struct Constants {
        static let title = "Back"
        static let cornerRadius: CGFloat = 15.0
        static let borderColor: UIColor = .orange
        static let borderWidth: CGFloat = 1.0
        static let frameWidth: CGFloat = 100.0
        static let frameHeight: CGFloat = 30.0
        static let firstBackgroundColor: UIColor = .red
        static let secondBackgroundColor: UIColor = .clear
        
        //Back sign shape
        static let shapeLineWidth: CGFloat = 3.0
        static let shapeLineCapStyle: CAShapeLayerLineCap = .round
        static let shapeFillColor: UIColor = .clear
        static let shapeStrokeEnd: CGFloat = 1.0
        static let shapeOpacity: Float = 1.0
        static let shapeStrokeColor: UIColor = .red
        
        //-------Common animation properties-------
        static let startMoment: Double = 0
        static let animationDuration: Double = 15
        static let timingFunctions = [CAMediaTimingFunction(name: .linear)]
        static let repeatCount: Float = HUGE
        static let removedOnCompletionFlag = false
        //Backgroud color animation
        static let backgroundColorAnimationKeyPath = "backgroundColor"
        static let keyTimes: [NSNumber] = [0.000, 0.300, 0.500, 0.800, 1.000]
        //Title animation
        static let rotationAngle = CGFloat(90 * Double.pi / 180)
        static let titleRotationAnimationKeyPath = "transform.rotation.x"
        static let titleRotationValues: [Float] = [0.000, 0.000, -1.571, -1.571, 0.000]
        static let titleRotationKeyTimes: [NSNumber] = [0.000, 0.300, 0.500, 0.800, 1.000]
    }
}
