//
//  FinishViewController.swift
//  ToBeMillionare
//
//  Created by Igor Ivanov on 16.06.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pressBack(_ sender: Any) {
        let controllers = self.navigationController?.viewControllers
         for vc in controllers! {
           if vc is ViewController {
             _ = self.navigationController?.popToViewController(vc as! ViewController, animated: true)
           }
        }
    }
    
}
