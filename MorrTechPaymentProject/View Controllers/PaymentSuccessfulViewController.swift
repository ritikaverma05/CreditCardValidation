//
//  PaymentSuccessfulViewController.swift
//  MorrTechPaymentProject
//
//  Created by RITIKA VERMA on 08/01/21.
//

import UIKit

class PaymentSuccessfulViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
       super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        containerView.isOpaque = true
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }

    @IBAction func CloseBtn(_ sender: Any) {
        
        self.dismiss(animated: false, completion: nil)
    }
    
}
