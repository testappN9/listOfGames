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
    private var selectedIndex = 1
    private var arrayOfSections: [String] = []
    private var sizeOfFont: CGFloat = 23
    
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
        
        let selectorWidth = (width - 20) / CGFloat(arrayOfSections.count)
        let selectorPosition = selectorWidth * CGFloat(selectedIndex - 1)
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
    
    private func createSection(mainFont: UIFont?, height: CGFloat, fullWidth: CGFloat) {
        if arrayOfSections.count == 0 {
            return
        }
        let width = fullWidth / CGFloat(arrayOfSections.count)
        
        for (index, text) in arrayOfSections.enumerated() {
            let xPoint = width * CGFloat(index)
            let label = UILabel()
            label.textAlignment = .center
            label.textColor = UIColor.lightGray
            label.text = text
            label.font = mainFont
            label.frame = CGRect(x: xPoint, y: 0, width: width, height: height)
            viewForSections.addSubview(label)
        }
    }
    
    @objc private func handleTap(sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut]) {
            if self.selectedIndex == self.arrayOfSections.count {
                self.selectedIndex = 1
                self.selector.frame.origin.x = 0
            } else {
                self.selectedIndex += 1
                self.selector.frame.origin.x += self.selector.frame.width
            }
        }
        self.sendActions(for: UIControl.Event.touchUpInside)
    }
    
    func getSelectedIndex() -> Int {
        return selectedIndex
    }
    
    func setFont(size: CGFloat) {
        sizeOfFont = size
    }
    
    func setSections(labels: [String]) {
        arrayOfSections += labels
    }
    
    func changeLabel(index: Int, labelText: String) {
        if index < arrayOfSections.count {
            arrayOfSections[index] = labelText
        }
    }
}


