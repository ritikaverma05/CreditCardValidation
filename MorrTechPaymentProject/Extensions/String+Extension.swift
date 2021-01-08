//  String+Extension.swift
//  MorrTechPaymentProject
//
//  Created by RITIKA VERMA on 08/01/21.
//

import Foundation
import UIKit

extension String {

    var isNameValid: Bool{
        
        let NameRegExp = "^[a-zA-Z ]{2,}$"
        let NameCheck = NSPredicate(format: "SELF MATCHES %@", NameRegExp)
        return NameCheck.evaluate(with: self)
    }
    
}
