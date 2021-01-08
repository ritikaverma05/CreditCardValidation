//
//  InputCardDetailsViewController.swift
//  MorrTechPaymentProject
//
//  Created by RITIKA VERMA on 08/01/21.
//

import UIKit
import MaterialComponents.MaterialTextFields

class InputCardDetailsViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var CardNumberTF: MDCTextField!
    @IBOutlet weak var ExpirationDateTF: MDCTextField!
    @IBOutlet weak var SecurityCodeTF: MDCTextField!
    @IBOutlet weak var FirstNameTF: MDCTextField!
    @IBOutlet weak var LastNameTF: MDCTextField!
    
    
    @IBOutlet weak var InvalidCardNo: UILabel!
    @IBOutlet weak var InvalidSecurityCode: UILabel!
    @IBOutlet weak var InvalidDate: UILabel!
    @IBOutlet weak var InvalidFirstName: UILabel!
    @IBOutlet weak var InvalidLastName: UILabel!
    
    var CardNumberTextController: MDCTextInputControllerOutlined!
    var ExpirationDateTextController: MDCTextInputControllerOutlined!
    var SecurityCodeTextController: MDCTextInputControllerOutlined!
    var FirstNameTextController: MDCTextInputControllerOutlined!
    var LastNameTextController: MDCTextInputControllerOutlined!
    var count=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContoller()
    }
    
    private func setupContoller(){
        
        self.CardNumberTextController = MDCTextInputControllerOutlined(textInput: CardNumberTF)
        self.ExpirationDateTextController = MDCTextInputControllerOutlined(textInput: ExpirationDateTF)
        self.SecurityCodeTextController = MDCTextInputControllerOutlined(textInput: SecurityCodeTF)
        self.FirstNameTextController = MDCTextInputControllerOutlined(textInput: FirstNameTF)
        self.LastNameTextController = MDCTextInputControllerOutlined(textInput: LastNameTF)
        
        
        CardNumberTextController.activeColor = .systemGreen
        CardNumberTextController.textInput?.textColor = .black
        CardNumberTextController.floatingPlaceholderActiveColor = .systemGreen
        CardNumberTF.clearButton.isHidden = true
        CardNumberTextController.errorColor = .red
        CardNumberTF.keyboardType = .numberPad
        
        
        ExpirationDateTextController.activeColor = .systemGreen
        ExpirationDateTextController.textInput?.textColor = .black
        ExpirationDateTextController.floatingPlaceholderActiveColor = .systemGreen
        ExpirationDateTF.clearButton.isHidden = true
        ExpirationDateTF.keyboardType = .numbersAndPunctuation
        
        
        SecurityCodeTextController.activeColor = .systemGreen
        SecurityCodeTextController.textInput?.textColor = .black
        SecurityCodeTextController.floatingPlaceholderActiveColor = .systemGreen
        SecurityCodeTF.clearButton.isHidden = true
        SecurityCodeTF.keyboardType = .numberPad
        
        
        FirstNameTextController.activeColor = .systemGreen
        FirstNameTextController.textInput?.textColor = .black
        FirstNameTextController.floatingPlaceholderActiveColor = .systemGreen
        FirstNameTF.clearButton.isHidden = true
        
        LastNameTextController.activeColor = .systemGreen
        LastNameTextController.textInput?.textColor = .black
        LastNameTextController.floatingPlaceholderActiveColor = .systemGreen
        LastNameTF.clearButton.isHidden = true
    }
    
    
    @IBAction func SubmitPaymentTap(_ sender: Any) {
        
        count=0
        if(checkValidity()){
            let viewController:UIViewController = UIStoryboard(name: "PaymentSuccessful", bundle: nil).instantiateViewController(withIdentifier: "PaymentSuccessfulViewController") as! PaymentSuccessfulViewController
            viewController.providesPresentationContextTransitionStyle = true
            viewController.definesPresentationContext = true
            viewController.modalPresentationStyle = .custom
            viewController.modalTransitionStyle = .crossDissolve
            self.present(viewController, animated: false, completion: nil)
        }
        
    }
    
    //MARK:- checkValidity
    
    func checkValidity() -> Bool{
        
        let cardNumberCheck = luhnCheck(number: "\(CardNumberTF.text!)")
        if (cardNumberCheck) {
            CardNumberTextController.setErrorText(nil, errorAccessibilityValue: nil)
            InvalidCardNo.isHidden = true
        }else{
            CardNumberTextController.setErrorText("", errorAccessibilityValue: "")
            count+=1
            InvalidCardNo.isHidden = false
        }
        CardBrand()
        
        if (!isValidSecurityCodeNumber()) {
            SecurityCodeTextController.setErrorText("", errorAccessibilityValue: "")
            count+=1
            InvalidSecurityCode.isHidden = false
        }else{
            SecurityCodeTextController.setErrorText(nil, errorAccessibilityValue: nil)
            InvalidSecurityCode.isHidden = true }
        
        if (!isValidFirstName()) {
            FirstNameTextController.setErrorText("", errorAccessibilityValue: "")
            count+=1
            InvalidFirstName.isHidden = false
        }else{
            FirstNameTextController.setErrorText(nil, errorAccessibilityValue: nil)
            InvalidFirstName.isHidden = true
        }
        
        if (!isValidLastName()) {
            LastNameTextController.setErrorText("", errorAccessibilityValue: "")
            count+=1
            InvalidLastName.isHidden = false
        }else{
            LastNameTextController.setErrorText(nil, errorAccessibilityValue: nil)
            InvalidLastName.isHidden = true
        }
        
        if(ExpirationDateTF.text! == ""){
            ExpirationDateTextController.setErrorText("", errorAccessibilityValue: "")
            count+=1
            InvalidDate.isHidden = false
        }else{
            ExpirationDateTextController.setErrorText(nil, errorAccessibilityValue: nil)
            InvalidDate.isHidden = true
        }
        
        if(count>0){
            return false
        }
        return true
        
    }
    
    //MARK:- Luhn Validation
    
    public func clearNumber(from cardNumber: String) -> String {
        let numbers = Set("0123456789")
        return cardNumber.filter {
            numbers.contains($0)
        }
    }
    
    func luhnCheck(number: String) -> Bool {
        
        let reversedDigits = clearNumber(from: number).reversed().map {
            Int(String($0))!
        }
        let checkSum = reversedDigits.enumerated().reduce(0) { sum, pair in
            let (reversedIndex, digit) = pair
            return sum + (reversedIndex % 2 == 0 ? digit : (((digit * 2 - 1) % 9) + 1))
        }
        return checkSum % 10 == 0
    }
    
    func CardBrand(){
        let formatter = CardNumberFormatter()
        //        let formattedCardNumber = formatter.number(from: CardNumberTF.text!)
        let cardBrandName = formatter.cardBrand(from: CardNumberTF.text!)
        print(cardBrandName)
        
    }
    
    //MARK:- CVV Number
    
    func isValidSecurityCodeNumber() -> Bool {
        
        if(CardNumberTF.text!.count == 15){
            if(SecurityCodeTF.text?.count == 4){
                return true  }
        }else if(CardNumberTF.text!.count == 16){
            if(SecurityCodeTF.text?.count == 3){
                return true  }
        }
        return false
    }
    
    
    //MARK:- Name Validity
    
    func isValidFirstName() -> Bool{
        if((FirstNameTF.text?.isNameValid)!){
            return true
        }else{
            print(" not valid")
        }
        return false
    }
    
    
    func isValidLastName() -> Bool{
        if((LastNameTF.text?.isNameValid)!){
            return true
        }else{
            print(" not valid")
        }
        return false
    }
    
    
    
}
