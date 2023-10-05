//
//  ViewController.swift
//  Swipe Image
//
//  Created by Admin on 23.09.23.
//

import UIKit

class ViewController: UIViewController {
    
    private let swipeImage = UIImageView(image: UIImage(named: "golovach"))
    
    private enum swipeDirections {
        case up, right, down, left
    }
    
    private let imageSize = (width: CGFloat(100), height: CGFloat(150))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initiateImage(withImage: swipeImage)
        view.addSubview(swipeImage)
    }
    
    private func initiateImage(withImage image: UIImageView) {
        image.frame = CGRect(x: view.center.x - imageSize.width / 2, y: view.center.y - imageSize.height / 2, width: imageSize.width, height: imageSize.height)
        image.layer.borderColor = .init(srgbRed: 255, green: 0, blue: 255, alpha: 0.6)
        image.layer.borderWidth = 4
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        image.isUserInteractionEnabled = true
        
        addAllSwipes(toImage: image)
    }
    
    private func addAllSwipes(toImage image: UIImageView) {
        let gestureSwipeUp = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe))
        let gestureSwipeRight = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe))
        let gestureSwipeDown = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe))
        let gestureSwipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe))
            
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
        switch gesture.direction {
        case .up:
            moveImageOnSwipe(withDirection: swipeDirections.up)
        case .right:
            moveImageOnSwipe(withDirection: swipeDirections.right)
        case .down:
            moveImageOnSwipe(withDirection: swipeDirections.down)
        case .left:
            moveImageOnSwipe(withDirection: swipeDirections.left)
        default:
            break
        }
    }
    
    private func moveImageOnSwipe(withDirection direction: swipeDirections) {
        let moveBy = CGFloat(50)
        let animationDuration = 0.25
        let maxX = view.bounds.maxX
        let maxY = view.bounds.maxY
        UIView.animate(withDuration: animationDuration, animations: {
            switch direction {
            case .up:
                guard self.swipeImage.frame.origin.y - moveBy > 0 else {
                    self.swipeImage.frame.origin.y = 0
                    return
                }
                self.swipeImage.frame.origin.y -= moveBy
            case .right:
                guard self.swipeImage.frame.origin.x + moveBy + self.imageSize.width < maxX else {
                    self.swipeImage.frame.origin.x = maxX - self.imageSize.width
                    return
                }
                self.swipeImage.frame.origin.x += moveBy
            case .down:
                guard self.swipeImage.frame.origin.y + moveBy + self.imageSize.height < maxY else {
                    self.swipeImage.frame.origin.y = maxY - self.imageSize.height
                    return
                }
                self.swipeImage.frame.origin.y += moveBy
            case .left:
                guard self.swipeImage.frame.origin.x - moveBy > 0 else {
                    self.swipeImage.frame.origin.x = 0
                    return
                }
                self.swipeImage.frame.origin.x -= moveBy
            }
        })
    }
}

