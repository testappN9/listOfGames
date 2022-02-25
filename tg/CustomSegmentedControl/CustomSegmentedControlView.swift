//
//  CustomSegmentedControl.swift
//  tg
//
//  Created by Anton Chirkov on 22.02.22.
//

import UIKit

class CustomSegmentedControl: UIControl {
    
    private let viewForSections = UIView()
    private let backgroundView = UIView()
    private let selector = UIView()
    private var internalState = 1
    var arrayOfNames = Array(repeating: "empty", count: 10)
    var currentState = 1
    var numberOfSection = 2
    var sizeOfFont: CGFloat = 23
    
    override func draw(_ rect: CGRect) {
        
        let width = self.bounds.maxX
        let height = self.bounds.maxY
        let mainFont = UIFont(name: "Chalkduster", size: sizeOfFont)
        
        backgroundView.frame = CGRect(x: 0, y: height / 10, width: width, height: height * 0.8)
        backgroundView.layer.cornerRadius = height / 4
        backgroundView.layer.borderWidth = 3
        backgroundView.layer.borderColor = UIColor.systemGray4.cgColor
        self.addSubview(backgroundView)
        
        viewForSections.frame = CGRect(x: 10, y: 0, width: width - 20, height: height)
        self.addSubview(viewForSections)
    
        createSection(mainFont: mainFont, height: height, fullWidth: width - 20)
        
        let selectorWidth = (width - 20) / CGFloat(numberOfSection)
        let selectorPosition = selectorWidth * CGFloat(internalState - 1)
        selector.frame = CGRect(x: selectorPosition, y: 0, width: selectorWidth, height: height)
        selector.layer.cornerRadius = height / 2
        selector.layer.borderColor = UIColor.lightGray.cgColor
        selector.layer.borderWidth = 2
        selector.layer.shadowOffset = CGSize(width: 4, height: 4)
        selector.layer.shadowRadius = 4
        selector.layer.shadowOpacity = 0.4
        viewForSections.addSubview(selector)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    func createSection(mainFont: UIFont?, height: CGFloat, fullWidth: CGFloat) {
        if numberOfSection == 0 {
            return
        }
        let width = fullWidth / CGFloat(numberOfSection)
        var count = numberOfSection
        while count != 0 {
            let xPoint = width * CGFloat(numberOfSection - count)
            let label = UILabel()
            label.textAlignment = .center
            label.textColor = UIColor.lightGray
            label.text = arrayOfNames[numberOfSection - count]
            label.font = mainFont
            label.frame = CGRect(x: xPoint, y: 0, width: width, height: height)
            viewForSections.addSubview(label)
            count -= 1
        }
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut]) {
            if self.internalState == self.numberOfSection {
                self.internalState = 1
                self.selector.frame.origin.x = 0
            } else {
                self.internalState += 1
                self.selector.frame.origin.x += self.selector.frame.width
            }
        }
        currentState = internalState
        self.sendActions(for: UIControl.Event.touchUpInside)
    }
}


