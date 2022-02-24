//
//  CustomSegmentedControl.swift
//  tg
//
//  Created by Anton Chirkov on 22.02.22.
//

import UIKit

class CustomSegmentedControl: UIControl {
    
    private let backgroundView = UIView()
    private let selector = UIView()
    private let textOfBackFirst = UILabel()
    private let textOfBackSecond = UILabel()
    private var internalState = 1
    var firstText = "test"
    var secondText = "passed"
    var currentState = 1
    
    override func draw(_ rect: CGRect) {
        
        let width = self.bounds.maxX
        let height = self.bounds.maxY
        let mainFont = UIFont(name: "Chalkduster", size: height / 2.82)
        
        backgroundView.frame = CGRect(x: 0, y: height / 10, width: width, height: height * 0.8)
        backgroundView.layer.cornerRadius = height / 4
        backgroundView.layer.borderWidth = 3
        backgroundView.layer.borderColor = UIColor.systemGray4.cgColor
        self.addSubview(backgroundView)
        
        textOfBackFirst.textAlignment = .center
        textOfBackFirst.textColor = UIColor.lightGray
        textOfBackFirst.text = firstText
        textOfBackFirst.font = mainFont
        textOfBackFirst.frame = CGRect(x: 10, y: 0, width: width / 2, height: height)
        self.addSubview(textOfBackFirst)
    
        textOfBackSecond.textAlignment = .center
        textOfBackSecond.textColor = UIColor.lightGray
        textOfBackSecond.text = secondText
        textOfBackSecond.font = mainFont
        textOfBackSecond.frame = CGRect(x: width / 2 - 10, y: 0, width: width / 2, height: height)
        self.addSubview(textOfBackSecond)
        
        var selectorPosition: CGFloat = 10
        if internalState == 2 {
            selectorPosition += self.selector.frame.width - 20
        }
    
        selector.frame = CGRect(x: selectorPosition, y: 0, width: width / 2, height: height)
        selector.layer.cornerRadius = height / 2
        selector.layer.borderColor = UIColor.lightGray.cgColor
        selector.layer.borderWidth = 2
        selector.layer.shadowOffset = CGSize(width: 4, height: 4)
        selector.layer.shadowRadius = 4
        selector.layer.shadowOpacity = 0.4
        self.addSubview(selector)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        internalState = internalState == 1 ? 2 : 1
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut]) {
            if self.internalState == 1 {
                self.selector.frame.origin.x -= (self.selector.frame.width - 20)
            } else {
                self.selector.frame.origin.x += (self.selector.frame.width - 20)
            }
        }
        currentState = internalState
        self.sendActions(for: UIControl.Event.touchUpInside)
    }
}


