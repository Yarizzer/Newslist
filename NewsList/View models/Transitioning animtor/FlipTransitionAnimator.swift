//
//  FlipTransitionAnimator.swift
//  NewsList
//
//  Created by Yarr!zzeR on 29/01/2019.
//  Copyright © 2019 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class TransitionAnimator: NSObject {
    private var isPresenting: Bool
    init(isPresenting presenting: Bool) {
        self.isPresenting = presenting
    }
    
    private func present(withContext context: UIViewControllerContextTransitioning) {
        let containerView = context.containerView
        guard let currentView = context.view(forKey: .from), let destinationVC = context.viewController(forKey: .to), let destinationView = context.view(forKey: .to) else { return }
        
        currentView.layer.cornerRadius = Constants.minCornerRadiusValue
        currentView.layer.masksToBounds = true
        
        let finalFrame = context.finalFrame(for: destinationVC)
        
        destinationView.transform = CGAffineTransform(scaleX: Constants.minScale, y: Constants.minScale)
        destinationView.center.x = Constants.screenCenter.x * Constants.viewOffsetMultiplier
        containerView.addSubview(destinationView)
        
        let backgroundView = getBackgroundView()
        containerView.insertSubview(backgroundView, belowSubview: currentView)
        
        UIView.animate(withDuration: Constants.scalingOutAnimationDuration, delay: 0, options: [.curveEaseInOut], animations: {
            currentView.transform = CGAffineTransform(scaleX: Constants.minScale, y: Constants.minScale)
            
            let cornerAnimation = CAKeyframeAnimation(keyPath: Constants.cornerRadiusKeyPath)
            cornerAnimation.duration = Constants.scalingOutAnimationDuration + Constants.movingAsideDuration
            cornerAnimation.values = [Constants.minCornerRadiusValue, Constants.maxCornerRadiusValue, Constants.maxCornerRadiusValue]
            cornerAnimation.keyTimes = Constants.cornerRadiusAnimationKeyTimes
            cornerAnimation.timingFunctions = [CAMediaTimingFunction(name: .linear)]
            cornerAnimation.beginTime = Constants.animationStartMoment
            cornerAnimation.isRemovedOnCompletion = Constants.animationRemoveOnCompletionFlag
            currentView.layer.add(cornerAnimation, forKey: Constants.cornerRadiusKeyPath)
        }) { _ in
            destinationView.layer.cornerRadius = Constants.maxCornerRadiusValue
            destinationView.layer.masksToBounds = true
            
            UIView.animate(withDuration: Constants.movingAsideDuration, delay: 0, options: [.curveEaseInOut], animations: {
                currentView.center.x = -Constants.screenCenter.x
                destinationView.center.x = Constants.screenCenter.x
            }, completion: { (finished) in
                destinationView.layer.cornerRadius = Constants.minCornerRadiusValue
                
                UIView.animate(withDuration: Constants.scalingInAnimationDuration, delay: 0, options: [.curveEaseInOut], animations: {
                    destinationView.transform = CGAffineTransform(scaleX: Constants.maxScale, y: Constants.maxScale)
                    destinationView.frame = finalFrame
                    
                    let cornerAnimation = CAKeyframeAnimation(keyPath: Constants.cornerRadiusKeyPath)
                    cornerAnimation.duration = Constants.scalingInAnimationDuration
                    cornerAnimation.values = [Constants.maxCornerRadiusValue, Constants.minCornerRadiusValue]
                    cornerAnimation.keyTimes = Constants.cornerRadiusAnimationKeyTimes
                    cornerAnimation.timingFunctions = [CAMediaTimingFunction(name: .linear)]
                    cornerAnimation.beginTime = Constants.animationStartMoment
                    cornerAnimation.isRemovedOnCompletion = Constants.animationRemoveOnCompletionFlag
                    destinationView.layer.add(cornerAnimation, forKey: Constants.cornerRadiusKeyPath)
                }, completion: { (finished) in
                    context.completeTransition(finished)
                    backgroundView.removeFromSuperview()
                })
            })
            
        }
    }
    
    private func dismiss(withContext context: UIViewControllerContextTransitioning) {
        let containerView = context.containerView
        guard let currentView = context.view(forKey: .from), let destinationVC = context.viewController(forKey: .to), let destinationView = context.view(forKey: .to) else { return }
        
        let finalFrame = context.finalFrame(for: destinationVC)
        
        destinationView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        destinationView.center.x = -(Constants.screenCenter.x * 4)
        containerView.addSubview(destinationView)
        
        currentView.layer.cornerRadius = Constants.minCornerRadiusValue
        currentView.layer.masksToBounds = true
        
        destinationView.layer.cornerRadius = Constants.minCornerRadiusValue
        destinationView.layer.masksToBounds = true
        
        let backgroundView = getBackgroundView()
        containerView.insertSubview(backgroundView, belowSubview: currentView)
        
        UIView.animate(withDuration: Constants.scalingOutAnimationDuration, delay: 0, options: [.curveEaseInOut], animations: {
            currentView.transform = CGAffineTransform(scaleX: Constants.minScale, y: Constants.minScale)
            
            let cornerAnimation = CAKeyframeAnimation(keyPath: Constants.cornerRadiusKeyPath)
            cornerAnimation.duration = Constants.scalingOutAnimationDuration + Constants.movingAsideDuration
            cornerAnimation.values = [Constants.minCornerRadiusValue, Constants.maxCornerRadiusValue, Constants.maxCornerRadiusValue]
            cornerAnimation.keyTimes = Constants.cornerRadiusAnimationKeyTimes
            cornerAnimation.timingFunctions = [CAMediaTimingFunction(name: .linear)]
            cornerAnimation.beginTime = Constants.animationStartMoment
            cornerAnimation.isRemovedOnCompletion = Constants.animationRemoveOnCompletionFlag
            currentView.layer.add(cornerAnimation, forKey: Constants.cornerRadiusKeyPath)
        }) { _ in
            destinationView.layer.cornerRadius = Constants.maxCornerRadiusValue
            destinationView.layer.masksToBounds = true
            
            UIView.animate(withDuration: Constants.movingAsideDuration, delay: 0, options: [.curveEaseInOut], animations: {
                currentView.center.x = Constants.screenCenter.x + UIScreen.main.bounds.width
                destinationView.center.x = Constants.screenCenter.x
            }, completion: { _ in
                destinationView.layer.cornerRadius = Constants.minCornerRadiusValue
                
                UIView.animate(withDuration: Constants.scalingInAnimationDuration, delay: 0, options: [.curveEaseInOut], animations: {
                    destinationView.transform = CGAffineTransform(scaleX: Constants.maxScale, y: Constants.maxScale)
                    destinationView.frame = finalFrame
                    
                    let cornerAnimation = CAKeyframeAnimation(keyPath: Constants.cornerRadiusKeyPath)
                    cornerAnimation.duration = Constants.scalingInAnimationDuration
                    cornerAnimation.values = [Constants.maxCornerRadiusValue, Constants.minCornerRadiusValue]
                    cornerAnimation.keyTimes = Constants.cornerRadiusAnimationKeyTimes
                    cornerAnimation.timingFunctions = [CAMediaTimingFunction(name: .linear)]
                    cornerAnimation.beginTime = Constants.animationStartMoment
                    cornerAnimation.isRemovedOnCompletion = Constants.animationRemoveOnCompletionFlag
                    destinationView.layer.add(cornerAnimation, forKey: Constants.cornerRadiusKeyPath)
                }, completion: { (finished) in
                    context.completeTransition(finished)
                    backgroundView.removeFromSuperview()
                })
            })
        }
    }
    
    private func getBackgroundView() -> UIView {
        let backgroundView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Constants.screenWidth, height: Constants.screenHeight)))
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: Constants.screenWidth, height: Constants.screenHeight)))
        imageView.image = UIImage(named: Constants.backgroundImageName)
        backgroundView.addSubview(imageView)
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = backgroundView.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundView.addSubview(blurView)
        
        return backgroundView
    }

}

extension TransitionAnimator: UIViewControllerAnimatedTransitioning {
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            present(withContext: transitionContext)
        } else {
            dismiss(withContext: transitionContext)
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Constants.transitionDuration
    }
}

extension TransitionAnimator {
    private struct Constants {
        //-----Transitioning properties-----
        static let transitionDuration: Double = 1
        static let maxScale: CGFloat = 1
        static let minScale: CGFloat = 0.9
        
        //-----background view properties-----
        static let screenWidth = UIScreen.main.bounds.width
        static let screenHeight = UIScreen.main.bounds.height
        static let backgroundImageName = "BackgroundImage"
        
        //-----Animiations-----
        static let animationDuration: Double = Constants.transitionDuration
        static let animationStartMoment: Double = 0
        static let animationRemoveOnCompletionFlag = true
        
        static let cornerRadiusKeyPath = "cornerRadius"
        static let maxCornerRadiusValue: CGFloat = UIScreen.main.bounds.height / 30
        static let minCornerRadiusValue: CGFloat = 0
        static let cornerRadiusAnimationKeyTimes: [NSNumber] = [0.000, 0.500, 1.000]
        static let scalingOutAnimationDuration: Double = Constants.animationDuration / 3
        
        static let movingAsideDuration: Double = Constants.animationDuration / 3
        
        static let scalingInAnimationDuration: Double = Constants.animationDuration / 3
        
        static let screenCenter: CGPoint = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        static let viewOffsetMultiplier: CGFloat = 4
        
        
        
    }
    
}
