//
//  TMPViewController.swift
//  AFNetworking
//
//  Created by Shilp_m on 3/3/17.
//  Copyright © 2017 Shilp_mphoton pho. All rights reserved.
//

import UIKit

class TMPViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}




/*import UIKit

import MessageUI

class OrderConfirmationViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource,MFMailComposeViewControllerDelegate {
    
    var orderConfirmationModel:OrderConfirmationModel?
    let driValidate = Validate()
    @IBOutlet weak var tableView: UITableView!
    var emailString = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.allowsSelection = false
        
        //Register Payment card type nib file to tableview
        registerCreditOrGiftCardUINib()
        
        ///Screen Title
        navigationItem.title = NSLocalizedString("CONFIRMATION", comment: "ORDER CONFIRMATION")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func registerCreditOrGiftCardUINib() {
        
        tableView.register(UINib.init(nibName: "PaymentCardCell", bundle: nil), forCellReuseIdentifier: "PaymentCardCell")
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 7
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0 {
            let cell: DRIOrderCell = tableView.dequeueReusableCell(withIdentifier: "OrderCell") as! DRIOrderCell
            
            //set the data here
            cell.orderCellConfiguration(orderConfirmationModel!)
            
            return cell
        }
        else if indexPath.row == 1 {
            
            let cell: DRIOrderSubTotalCell = tableView.dequeueReusableCell(withIdentifier: "OrderSubTotalCell") as! DRIOrderSubTotalCell
            
            //set the data here
            cell.subTotalCellConfiguration(orderConfirmationModel!)
            
            return cell
        }
        else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell")
            //set the data here
            
            return cell!
        }
        else if indexPath.row == 3 || indexPath.row == 4 {
            
            let cell: DRIPaymentCardCell = tableView.dequeueReusableCell(withIdentifier: "PaymentCardCell") as! DRIPaymentCardCell
            
            //set the data here
            //            cell.cardCellConfiguration(orderConfirmationModel!)
            
            return cell
        }
        else if indexPath.row == 5 {
            
            let cell: DRISendEmailCell = tableView.dequeueReusableCell(withIdentifier: "SendEmailCell") as! DRISendEmailCell
            DRIThemeEngine.sharedInstance.applyThemeFor(control: cell.emailTextField, style: "textField", inStyleFileName: String(describing: DRIOrderConfirmationViewController.self))
            var isEmailValid = true
            
            ////Handle email send action
            cell.sendEmailHandler = { (emailId: String) in
                print(emailId)
                cell.emailTextField.resignFirstResponder()
                if cell.emailTextField.text == "" || (cell.emailTextField.text?.isEmpty)! {
                    cell.emailInlineErrorLabel.isHidden = false
                    cell.emailTextField.text = DRICoreConstants.LoginGroup.CreateAccount.emailEmptyErrorText
                    DRIThemeEngine.sharedInstance.applyThemeFor(control: cell.emailTextField, style: "errorTextField", inStyleFileName: String(describing: DRICreateAccountViewController.self))
                    isEmailValid = false
                }else if !self.driValidate.isValidEmail(email: cell.emailTextField.text!){
                    cell.emailInlineErrorLabel.isHidden = false
                    cell.emailInlineErrorLabel.text = DRICoreConstants.LoginGroup.CreateAccount.emailInvalidErrorText
                    DRIThemeEngine.sharedInstance.applyThemeFor(control: cell.emailTextField, style: "errorTextField", inStyleFileName: String(describing: DRICreateAccountViewController.self))
                    isEmailValid = false
                }else {
                    cell.emailInlineErrorLabel.isHidden = true
                    isEmailValid = true
                    DRIThemeEngine.sharedInstance.applyThemeFor(control: cell.emailTextField, style: "textField", inStyleFileName: String(describing: DRICreateAccountViewController.self))
                    // Email Send
                    let mailComposeViewController = self.configuredMailComposeViewController()
                    if MFMailComposeViewController.canSendMail() {
                        self.emailString = cell.emailTextField.text!
                        self.present(mailComposeViewController, animated: true, completion: nil)
                    } else {
                        self.showSendMailErrorAlert()
                    }
                }
                
                
            }
            
            ////Handle signUp For EClub  action
            cell.signUpForEClubHandler = { (isSignForeClub: Bool) in
                
                //Perform email send action
            }
            
            return cell
            
        }
        else {
            
            
            let cell: DRIOrderSureyCell = tableView.dequeueReusableCell(withIdentifier: "OrderSureyCell") as! DRIOrderSureyCell
            
            //Perform survey  action
            cell.completeSurveyHandler = {
                
                //Perform survey  action
            }
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 128
        }
        else if indexPath.row == 1 {
            return 202
        }
        else if indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 {
            return 50
        }
        else if indexPath.row == 5 {
            return 280
        }
        else {
            return 180
        }
    }
    
    
    
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients([emailString])
        mailComposerVC.setSubject("Sending you an in-app e-mail...")
        mailComposerVC.setMessageBody("Sending e-mail in-app is not so bad!", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        self.alert(message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", title: "Could Not Send Email", ok: "OK")
        
    }
    
}

// MARK: MFMailComposeViewControllerDelegate

func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
    controller.dismiss(animated: true, completion: nil)
    
}*/

//extension DRIOrderConfirmationViewController: UITextFieldDelegate{
//    // MARK: - UITextFieldDelegate
//
//    /**
//     Triggers when user taps on textfields to start typing
//
//     - Hide inline error label and change border color of textfield
//
//     - parameter textField: textField which invokes this method
//
//     */
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        // change border color user when starts editing
//        let customTextField = textField as! DRIFloatLabelTextField
//        DRIThemeEngine.sharedInstance.applyThemeFor(control: customTextField, style: "textField", inStyleFileName: String(describing: DRIOrderConfirmationViewController.self))
////        errorEmailInlineLabel.isHidden = true
//    }
//}


/*import UIKit
import DRICore

class DRISendEmailCell: UITableViewCell, UITextFieldDelegate {
    
    var sendEmailHandler:((String)->Void)? = nil
    var signUpForEClubHandler: ((Bool)->Void)? = nil
    
    @IBOutlet weak var emailTextField: DRIFloatLabelTextField!
    @IBOutlet weak var emailInlineErrorLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        emailTextField.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        emailInlineErrorLabel.isHidden = true
        
        // change border color when starts editing
        let emailTextField = textField as! DRIFloatLabelTextField
        DRIThemeEngine.sharedInstance.applyThemeFor(control: emailTextField, style: "focussedTextField", inStyleFileName: String(describing: DRICreateAccountViewController.self))
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let emailTextField = textField as! DRIFloatLabelTextField
        DRIThemeEngine.sharedInstance.applyThemeFor(control: emailTextField, style: "textField", inStyleFileName: String(describing: DRICreateAccountViewController.self))
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // add respective pickers
        
        
        DRIThemeEngine.sharedInstance.applyThemeFor(control: emailTextField, style: "textField", inStyleFileName: String(describing: DRICreateAccountViewController.self))
        return true
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //Send email
    @IBAction func sendEmailAction(sender: UIButton) {
        
        if let sendEmailAction = self.sendEmailHandler {
            
            sendEmailAction(self.emailTextField.text!)
        }
    }
    
    
    /**
     
     Handle SignUp Toggle cases
     
     */
    @IBAction func signUp(_ isSign:Bool) {
        
        if let signUp = self.signUpForEClubHandler {
            
            signUp(isSign)
        }
        
    }
}*/




/*import UIKit



class DRIAddCardViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate, CellDelegate {
    
    var addCardCallbackHandler:((DRIAddCardModel)->Void)? = nil
    
    @IBOutlet weak var tableView: UITableView!
    
    var cellHeight: CGFloat? = nil
    let cell = AddCardTableViewCell()
    var cell1: CGFloat?
    var cell2: CGFloat?
    var cardnumber,expdate: String?
    var switchStatus: Bool?
    var services = DRIService.sharedInstance
    
    let addcardRequest = DRIAddCardModel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        switchStatus = false
        cellHeight = 230.0
        tableView.allowsSelection = false
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DRIAddCardViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AddCardTableViewCell
        
        cell1 = cell.ViewMoreDetails.frame.size.height
        cell2 = cell.viewCardDetails.frame.size.height
        //cellHeight = cell1
        cardnumber = cell.txtCardNumber.text
        
        cell.delegate = self
        
        return cell
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight!
    }
    
    //MARK:- TODO
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        
        //        let footerView = tableView.dequeueReusableCell(withIdentifier: "footerCell") as! FooterTableViewCell
        //        footerView.addCardHandler =  {
        //
        //        }
        //        //footerView.switchCard.setOn(true, animated: false)
        //        ////Handle view change
        //        footerView.showViewHandler = { (isView: AnyObject) in
        //
        //            if isView.isOn == false {
        //                self.switchStatus = true
        //                //footerView.switchCard.setOn(false, animated: false)
        //                self.cellHeight = 550.0
        //                //cellHeight = cell1
        //                tableView.reloadData()
        //            }
        //            else {
        //                self.switchStatus = false
        //                //footerView.switchCard.setOn(true, animated: false)
        //                self.cellHeight = 230.0
        //                //cellHeight = cell2
        //                tableView.reloadData()
        //            }
        //
        //        }
        
        
        
        
        let footerView = UIView(frame: CGRect(x: self.tableView.frame.origin.x, y: 20, width: self.tableView.frame.size.width, height: 140))
        footerView.backgroundColor = UIColor.white
        footerView.tag = 13
        let loginButton = UISwitch()
        loginButton.addTarget(self, action: #selector(DRIAddCardViewController.btnAction), for: .valueChanged)
        loginButton.setOn(true, animated: false);
        loginButton.tintColor = UIColor.blue
        loginButton.frame = CGRect(x: self.tableView.frame.size.width-80, y: 20, width: self.tableView.frame.size.width, height: 20)
        
        let lable = UILabel(frame: CGRect(x: 40, y: 20, width: self.tableView.frame.size.width, height: 20))
        lable.text = "Save Card to Profile"
        lable.textColor = UIColor.black
        lable.font = UIFont.boldSystemFont(ofSize: 15)
        
        let addCardButton = UIButton(frame: CGRect(x: footerView.frame.size.width/4, y: 100, width: 200, height: 50))
        
        addCardButton.backgroundColor = UIColor(red: 131/255, green: 26/255, blue: 46/255, alpha: 1.0)
        addCardButton.setTitle ("Add Card", for: UIControlState.normal)
        addCardButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        addCardButton.addTarget(self, action: #selector(DRIAddCardViewController.addbtnAction), for: .touchUpInside)
        
        footerView.addSubview(loginButton)
        footerView.addSubview(lable)
        footerView.addSubview(addCardButton)
        
        return footerView
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 160.0
    }
    
    
    
    func btnAction(sender: UISwitch) {
        
        if sender.isOn == true {
            switchStatus = true
            sender.isOn = false
            cellHeight = 550.0
            //cellHeight = cell1
            tableView.reloadData()
        }
        else {
            switchStatus = false
            sender.isOn = true
            cellHeight = 230.0
            //cellHeight = cell2
            tableView.reloadData()
        }
        
    }
    
    func cellDelegate(cardNumber: String, expDate: String, cvv: String, zipCode: String, address1: String, address2: String, city: String, state: String, county : String) {
        
        addcardRequest.cardNumber = cardNumber
        addcardRequest.expDate = expDate
        addcardRequest.cvv = cvv
        addcardRequest.zipcode = zipCode
        addcardRequest.city = city
        addcardRequest.state = state
        addcardRequest.country = county
    }
    
    
    
    func addbtnAction() {
        
        
        resignFirstResponder()
        let (type, formatted, valid) = checkCardNumber(input: addcardRequest.cardNumber!)
        print(type,formatted,valid)
        addcardRequest.cardtype = type.rawValue
        //        if((addcardRequest.cardNumber == "") || (((addcardRequest.cardNumber)?.characters.count)! != 14)) {
        //            //cell.carnumberInlineErrorLabel.isHidden = false
        //            //cell.txtCardNumber.isHidden = false
        //            //cell.txtCardNumber.text = DRICoreConstants.LoginGroup.CreateAccount.emailEmptyErrorText
        //            //DRIThemeEngine.sharedInstance.applyThemeFor(control: cell.txtCardNumber, style: "errorTextField", inStyleFileName: String(describing: DRICreateAccountViewController.self))
        //            alert(errorMessage: "INVALID CARD NUMBER")
        //        }
        if valid == false {
            alert(errorMessage: "INVALID CARD NUMBER")
        }
        else if((addcardRequest.expDate == "") || (((addcardRequest.expDate)?.characters.count)! != 5))  {
            cell.carnumberInlineErrorLabel.isHidden = false
            alert(errorMessage: "INVALID EXP DATE NUMBER")
        }
        else if((addcardRequest.cvv == "") || (((addcardRequest.cvv)?.characters.count)! != 3))  {
            alert(errorMessage: "INVALID CVV NUMBER")
        }
        else if (addcardRequest.zipcode == "")   {
            alert(errorMessage: "INVALID ZIPCODE NUMBER")
        }
        else if switchStatus == true {
            if addcardRequest.address1 == ""{
                alert(errorMessage: "ADDRESS CANNOT BE EMPTY")
            }
            else if addcardRequest.city == ""{
                alert(errorMessage: "CITY CANNOT BE EMPTY")
            }
            else if addcardRequest.state == ""{
                alert(errorMessage: "STATE CANNOT BE EMPTY")
            }
            else if addcardRequest.country == ""{
                alert(errorMessage: "COUNTRY CANNOT BE EMPTY")
            }
            else{
                if let addCardCallback = self.addCardCallbackHandler {
                    
                    addCardCallback(addcardRequest)
                    _ = navigationController?.popViewController(animated: true)
                }
                
            }
        }
        else {
            //MARK:- TODO API SPRINT 4
            //Call Json mockup for testing, it will be replaced by API
            //services.delegate = self
            //services.addCard(reqBody: addcardRequest.toJSON() as [String : AnyObject])
            
            
            
            if let addCardCallback = self.addCardCallbackHandler {
                //cell.cityInlineErrorLabel.isHidden = true
                addCardCallback(addcardRequest)
                _ = navigationController?.popViewController(animated: true)
            }
        }
        
        
    }
    
    
    // card validation
    func luhnCheck(number: String) -> Bool {
        var sum = 0
        let digitStrings = number.characters.reversed().map { String($0) }
        
        for tuple in digitStrings.enumerated() {
            guard let digit = Int(tuple.element) else { return false }
            let odd = tuple.offset % 2 == 1
            
            switch (odd, digit) {
            case (true, 9):
                sum += 9
            case (true, 0...8):
                sum += (digit * 2) % 9
            default:
                sum += digit
            }
        }
        
        return sum % 10 == 0
    }
    
    // card type check
    func checkCardNumber(input: String) -> (type: CardType, formatted: String, valid: Bool) {
        // Get only numbers from the input string
        let numberOnly = input.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        var type: CardType = .Unknown
        var formatted = ""
        var valid = false
        
        // detect card type
        for card in CardType.allCards {
            if (matchesRegex(regex: card.regex, text: numberOnly)) {
                type = card
                break
            }
        }
        
        // check validity
        valid = luhnCheck(number: numberOnly)
        
        // format
        var formatted4 = ""
        for character in numberOnly.characters {
            if formatted4.characters.count == 4 {
                formatted += formatted4 + " "
                formatted4 = ""
            }
            formatted4.append(character)
        }
        
        formatted += formatted4 // the rest
        
        // return the tuple
        return (type, formatted, valid)
    }
    
    enum CardType: String {
        case Unknown, Amex, Visa, MasterCard, Diners, Discover, JCB, Elo, Hipercard, UnionPay
        
        static let allCards = [Amex, Visa, MasterCard, Diners, Discover, JCB, Elo, Hipercard, UnionPay]
        
        var regex : String {
            switch self {
            case .Amex:
                return "^3[47][0-9]{5,}$"
            case .Visa:
                return "^4[0-9]{6,}([0-9]{3})?$"
            case .MasterCard:
                return "^(5[1-5][0-9]{4}|677189)[0-9]{5,}$"
            case .Diners:
                return "^3(?:0[0-5]|[68][0-9])[0-9]{4,}$"
            case .Discover:
                return "^6(?:011|5[0-9]{2})[0-9]{3,}$"
            case .JCB:
                return "^(?:2131|1800|35[0-9]{3})[0-9]{3,}$"
            case .UnionPay:
                return "^(62|88)[0-9]{5,}$"
            case .Hipercard:
                return "^(606282|3841)[0-9]{5,}$"
            case .Elo:
                return "^((((636368)|(438935)|(504175)|(451416)|(636297))[0-9]{0,10})|((5067)|(4576)|(4011))[0-9]{0,12})$"
            default:
                return ""
            }
        }
    }
    
    func matchesRegex(regex: String!, text: String!) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [.caseInsensitive])
            let nsString = text as NSString
            let match = regex.firstMatch(in: text, options: [], range: NSMakeRange(0, nsString.length))
            return (match != nil)
        } catch {
            return false
        }
    }
    
    
    func navigateToAmountDue(amountDue: DRIAddCardModel){
        let mobilePayStoryboard = UIStoryboard(name: "MobilePay", bundle: nil)
        let selectPaymentMethodVC = mobilePayStoryboard.instantiateViewController(withIdentifier: "DRISelectPaymentMethodViewController") as! DRISelectPaymentMethodViewController
        selectPaymentMethodVC.addCard = addcardRequest
        self.navigationController?.pushViewController(selectPaymentMethodVC, animated: true)
    }
    
}

//MARK:- Service related delegate, TODO API SPRINT 4
extension DRIAddCardViewController:DRIServiceDelegate {
    
    func onSuccess(responseModel: AnyObject, serviceIdentifier: String) {
        
        if serviceIdentifier == DRIServiceIdentity.addCard {
            
            let addCardModel = Mapper<DRIAddCardModel>().map(JSON: responseModel as! [String: AnyObject])
            print(addCardModel?.cardNumber ?? "$0.0")
            
            navigateToAmountDue(amountDue: addCardModel!)
        }
    }
    
    func onFailure(error: DRIServiceError, serviceIdentifier: String) {
        print("=====> mission failure <========")
    }
}*/

/*var cardArray = [DRIAddCardModel]()
var backgroundView = UIView()
var checked = [Bool]()
var amountDue:DRIAmountDueModel?
var addCard:DRIAddCardModel?
func addCreditCard() {
    
    let mobilePayStoryboard = UIStoryboard(name: "MobilePay", bundle: nil)
    let addCardVC = mobilePayStoryboard.instantiateViewController(withIdentifier: "DRIAddCardViewController") as! DRIAddCardViewController
    
    addCardVC.addCardCallbackHandler = { (cardType: DRIAddCardModel) in
        
        //update table card cell
        self.backgroundView.removeFromSuperview()
        
        //Add dynamic cell to table
        self.addCard = cardType
        self.cardArray.append(cardType)
        self.tableView.reloadData()
    }
    
    self.navigationController?.pushViewController(addCardVC, animated: true)
    
    
    
}*/

/*open class DRIAddCardModel: NSObject, Mappable {
    
    public var cardNumber: String?
    public var expDate: String?
    public var cvv: String?
    public var cardZipCode: String?
    public var address1: String?
    public var address2: String?
    public var city: String?
    public var state: String?
    public var zipcode: String?
    public var country: String?
    public var action:String?
    public var cardtype:String?
    
    
    public override init() {
        super.init()
    }
    
    public convenience required init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        
        cardNumber <- map["cardNumber"]
        expDate <- map["expDate"]
        cvv <- map["cvv"]
        cardZipCode <- map["cardZipCode"]
        address1 <- map["address1"]
        address2 <- map["address2"]
        city <- map["city"]
        state <- map["state"]
        zipcode <- map["zipcode"]
        country <- map["country"]
        cardtype <- map["cardstatus"]
    }
    
}*/





