//
//  ScoreBoard.swift
//  BrainTeaser
//
//  Created by Stefan Blos on 24.03.16.
//  Copyright © 2016 Stefan Blos. All rights reserved.
//

import UIKit

class ScoreBoard: UIView {
    
    @IBOutlet weak var correctLbl: UILabel!
    @IBOutlet weak var wrongLbl: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!
    
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
    }
    
    func setResult(correct: Int, wrong: Int) {
        correctLbl.text = String(correct)
        wrongLbl.text = String(wrong)
        scoreLbl.text = String(correct - wrong)
    }
    
    func setupView() {
        self.layer.shadowRadius = 10.0
        self.layer.shadowOpacity = 0.8
        self.layer.shadowColor = UIColor(red: 157.0/255.0, green: 157.0/255.0, blue: 157.0/255.0, alpha: 1.0).CGColor
        self.layer.shadowOffset = CGSizeMake(0.0, 5.0)
        
        self.layer.cornerRadius = cornerRadius
        
        self.setNeedsLayout()
    }
    
}