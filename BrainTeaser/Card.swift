//
//  Card.swift
//  BrainTeaser
//
//  Created by Stefan Blos on 23.03.16.
//  Copyright © 2016 Stefan Blos. All rights reserved.
//

import UIKit

class Card: UIView {

    let shapes = ["shape1", "shape2", "shape3", "shape4", "shape5"]
    
    var currentShape: String!
    
    @IBOutlet weak var cardImg: UIImageView!
    @IBOutlet weak var resultImg: UIImageView!
    
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            setupView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    override func awakeFromNib() {
        setupView()
        selectShape()
    }
    
    func setupView() {
        self.layer.shadowRadius = 10.0
        self.layer.shadowOpacity = 0.8
        self.layer.shadowColor = UIColor(red: 157.0/255.0, green: 157.0/255.0, blue: 157.0/255.0, alpha: 1.0).CGColor
        self.layer.shadowOffset = CGSizeMake(0.0, 5.0)
        
        self.layer.cornerRadius = cornerRadius
        
        self.setNeedsLayout()
    }
    
    func selectShape() {
        currentShape = shapes[Int(arc4random_uniform(5))]
        cardImg.image = UIImage(named: currentShape)
    }
    
    func setResultImage(correct: Bool) {
        correct ? (resultImg.image = UIImage(named: "correct")) : (resultImg.image = UIImage(named: "wrong"))
        resultImg.hidden = false
    }

}
