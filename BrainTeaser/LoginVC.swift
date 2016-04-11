//
//  LoginVC.swift
//  BrainTeaser
//
//  Created by Stefan Blos on 19.03.16.
//  Copyright © 2016 Stefan Blos. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var passwordConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var loginConstraint: NSLayoutConstraint!
    
    var animEngine: AnimationEngine!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.animEngine = AnimationEngine(constraints: [emailConstraint, passwordConstraint, loginConstraint])
        
    }

    override func viewDidAppear(animated: Bool) {
        animEngine.animateOnScreen(1)
    }
    
}

