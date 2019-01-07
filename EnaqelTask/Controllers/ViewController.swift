//
//  ViewController.swift
//  EnaqelTask
//
//  Created by unitlabs on 1/4/19.
//  Copyright © 2019 BestOffer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var segemnentController: UISegmentedControl!
    @IBOutlet weak var allContainer: UIView!
    
    @IBOutlet weak var favouritesContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.allContainer.alpha = 1
        self.favouritesContainer.alpha = 0
        
    }
    
    
    @IBAction func changeContainers(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            UIView.animate(withDuration: 0.5, animations: {
                self.allContainer.alpha = 1
                self.favouritesContainer.alpha = 0
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.allContainer.alpha = 0
                self.favouritesContainer.alpha = 1
                let nc = NotificationCenter.default
                nc.post(name: Notification.Name("OpenFav"), object: nil)
            })
        }
    }
    


}

