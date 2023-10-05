//
//  imageInitializer.swift
//  Swipe Image
//
//  Created by Admin on 23.09.23.
//

import Foundation
import UIKit

class imageInitializer {
    
    init(withTarget target: UIViewController) {
        self.target = target
    }
    
    private let target: UIViewController
    
    private enum swipeDirections {
        case up, right, down, left
    }
    
    private let imageSize = (width: CGFloat(100), height: CGFloat(150))
    
    public func initiateImage(withImage image: UIImageView) {
        image.frame = CGRect(x: target.view.center.x - imageSize.width / 2, y: target.view.center.y - imageSize.height / 2, width: imageSize.width, height: imageSize.height)
        image.layer.borderColor = .init(srgbRed: 255, green: 0, blue: 255, alpha: 0.6)
        image.layer.borderWidth = 4
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
//        Будут вопросы
        image.isUserInteractionEnabled = true
        
        addAllSwipes(toImage: image)
    }
    
    private func addAllSwipes(toImage image: UIImageView) {
        let gestureSwipeUp = UISwipeGestureRecognizer(target: target, action: #selector(onSwipe))
        let gestureSwipeRight = UISwipeGestureRecognizer(target: target, action: #selector(onSwipe))
        let gestureSwipeDown = UISwipeGestureRecognizer(target: target, action: #selector(onSwipe))
        let gestureSwipeLeft = UISwipeGestureRecognizer(target: target, action: #selector(onSwipe))
            
        gestureSwipeUp.direction = .up
        gestureSwipeRight.direction = .right
        gestureSwipeDown.direction = .down
        gestureSwipeLeft.direction = .left
        
        image.addGestureRecognizer(gestureSwipeUp)
        image.addGestureRecognizer(gestureSwipeRight)
        image.addGestureRecognizer(gestureSwipeDown)
        image.addGestureRecognizer(gestureSwipeLeft)
    }
    
    @objc private func onSwipe(_ gesture: UISwipeGestureRecognizer) {
        print(gesture.direction)
    }
}
