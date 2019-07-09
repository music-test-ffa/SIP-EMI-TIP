//
//  EMI_VC.swift
//  SIP Calc with History
//
//  Created by Lenin S on 04/05/19.
//  Copyright © 2019 Lenin. All rights reserved.
//
// EMI -SIP
// Amount - Investment
// Tenure - Period
// Interest Rate - Rate of Return
// Total interest payable - Actual Amount
// Total Payment - Times-rolled-over
// EMI - Net Amount

import UIKit
import Foundation

class EMI_VC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var netReturnLable: UILabel!
    @IBOutlet var actualAmountLable: UILabel!
    @IBOutlet var rolledOverLable: UILabel!
    @IBOutlet weak var saveBtn: UIButton!
    var isHistory = false
    var historyDatas = NSDictionary()
    
    var periodValue: NSInteger = 0;
    var rorValue: Float = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "EMI Calculator";
        self.addNavigationBarButton(title: "Home", direction: .left)
        self.addNavigationBarButton(title: "Share", direction: .right)
        saveBtn.isEnabled = isHistory ? true : false
        saveBtn.setTitleColor(UIColor.lightGray, for: .disabled)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.applyRedBorderOnAmount();
        if isHistory {
             setUpInitialValues()
        }
    }

    func returnCellForIndexPath(_ indexPath : IndexPath) -> UITableViewCell {
        return self.tableView.cellForRow(at: indexPath)! as UITableViewCell
    }
    
    func returnAmountField() -> UITextField {
        return self.returnCellForIndexPath(IndexPath.init(row: 0, section: 0)).viewWithTag(111) as! UITextField
    }
    
    func returnPeriodLabel() -> UILabel {
        return self.returnCellForIndexPath(IndexPath.init(row: 1, section: 0)).viewWithTag(221) as! UILabel
    }
    
    func returnPeriodSlider() -> UISlider {
        return self.returnCellForIndexPath(IndexPath.init(row: 1, section: 0)).viewWithTag(222) as! UISlider
    }
    
    func returnRateLabel() -> UILabel {
        return self.returnCellForIndexPath(IndexPath.init(row: 2, section: 0)).viewWithTag(331) as! UILabel
    }
    
    func returnRateSlider() -> UISlider {
        return self.returnCellForIndexPath(IndexPath.init(row: 2, section: 0)).viewWithTag(332) as! UISlider
    }
    
    func returnNetLabel() -> UILabel {
        return self.returnCellForIndexPath(IndexPath.init(row: 3, section: 0)).viewWithTag(441) as! UILabel
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch ((indexPath as NSIndexPath).row) {
        case 0:
            return 80;
        case 1:
            return 90;
        case 2:
            return 90;
        case 3:
            return 100;
        default:
            break;
        }
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = (self.tableView!.dequeueReusableCell(withIdentifier: "cell\((indexPath as NSIndexPath).row)")! as UITableViewCell)
        
        self.configureCellForTableView(tableView, withCell: cell, withIndexPath: indexPath)
        return cell
    }
    
    func configureCellForTableView(_ tableView: UITableView, withCell cell: UITableViewCell, withIndexPath indexPath: IndexPath) {
        switch ((indexPath as NSIndexPath).row) {
        case 0:
            let textField:UITextField = cell.viewWithTag(111) as! UITextField
            textField.delegate = self
            
            break;
        case 1:
            let periodSlider:UISlider = cell.viewWithTag(222) as! UISlider
            periodSlider.addTarget(self, action: #selector(EMI_VC.sliderValueDidChange(_:)), for: .valueChanged)
            break;
        case 2:
            let rateOfReturnSlider:UISlider = cell.viewWithTag(332) as! UISlider
            rateOfReturnSlider.addTarget(self, action: #selector(EMI_VC.sliderValueDidChange(_:)), for: .valueChanged)
        default:
            break;
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\((indexPath as NSIndexPath).row)!")
    }
    
    func applyRedBorderOnAmount() {
        self.returnAmountField().layer.borderColor = UIColor.red.cgColor
        self.returnAmountField().layer.borderWidth = 1;
        self.returnAmountField().layer.cornerRadius = 5;
    }
    
    func clearRedBorderOnAmount() {
        self.returnAmountField().layer.borderColor = UIColor.clear.cgColor
        self.returnAmountField().layer.borderWidth = 0;
        self.returnAmountField().layer.cornerRadius = 0;
    }
    
    @objc func sliderValueDidChange(_ sender: UISlider) {
        if (self.returnAmountField().text == nil || self.returnAmountField().text == "") {
            self.applyRedBorderOnAmount();
            self.tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: true)
            
            self.returnPeriodSlider().value = Float(self.periodValue)
            self.returnRateSlider().value = Float(self.rorValue)
            return;
        } else {
            self.clearRedBorderOnAmount();
        }
        
        switch (sender.tag) {
        case 222:
            self.periodValue = Int(floor(sender.value))
            self.returnPeriodLabel().text = String(format :"%.0f years", floor(sender.value)) //"\(floor(sender.value)) years"
            break;
        case 332:
            self.rorValue = Float(floor(sender.value))
            self.returnRateLabel().text = String(format : "%.0f%@", floor(sender.value), "%")
            break;
        default:
            break;
        }
        let amount = NumberFormatter().number(from: self.returnAmountField().text!)!.floatValue
        self.calculateNetReturn(Double(amount), period: Double(self.periodValue), rateOfReturn: Double(self.rorValue))
    }
    
    func calculateNetReturn(_ amount: Double, period: Double, rateOfReturn: Double) {
//        let periodMonthly = Double((period * 12));
//        let rateOfReturnMonthly = Double(rateOfReturn/12);
//
//        let netReturn = round(-self.futureSipValue(rateOfReturnMonthly, nper: periodMonthly, pmt: Double(amount), pv: 0, type: 1));
//        self.netReturnLable.text = String(format : "%.0f", floor(netReturn.isNaN ? 0 : netReturn))
//
//        let actualAmout = (Double(period) * 12 * Double(amount));
//        self.actualAmountLable.text = String(format : "%.0f", floor(actualAmout.isNaN ? 0 : actualAmout))
//
//        let finalValue = self.futureSipValue(Double(rateOfReturn), nper: 1/12,pmt: 0, pv: -100, type: 1)-100
//        let finalAmount = round(futureSipValue(finalValue, nper: Double(period) * 12, pmt: Double(amount), pv: 0, type: 1))
//
//        let timeRolledOver = -(finalAmount/actualAmout);
//        self.rolledOverLable.text = String(format : "%.0f", floor(timeRolledOver.isNaN ? 0 : timeRolledOver))
        self.saveBtn.isEnabled = true
        
        
        // EMI
        let interestRateVal = rateOfReturn / 1200
        let loanTenureVal = period * 12
        let interest = amount * interestRateVal / (1 - (pow(1/(1 + interestRateVal), loanTenureVal)))
         self.netReturnLable.text = "\(interest.round(to: 2))"
        
        let totalMonth = period * 12
        let totalPayment = interest * Double(totalMonth)
        self.rolledOverLable.text = "\(totalPayment.round(to: 2))"
        
        let net = totalPayment - amount
        self.actualAmountLable.text = "\(net.round(to: 2))"



        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.tableView.scrollRectToVisible(CGRect(x: 0, y: 48, width: self.tableView.frame.size.width, height: self.tableView.frame.size.width), animated: true)
        return true;
    }
    
    func futureSipValue(_ returnspercent: Double, nper: Double, pmt: Double, pv: Double, type: Double) -> Double {
        let rate: Double = returnspercent/100
        var finalValue: Double = 0;
        finalValue = pmt * (1+rate * type) * ((1 - pow(1 + rate, nper))/rate) - (pv * pow(1+rate, nper))
        return finalValue
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.clearRedBorderOnAmount();
        let filtered = string.components(separatedBy: CharacterSet(charactersIn:"0123456789").inverted).joined(separator: "")
        if (string == filtered) {
            var txtAfterUpdate: NSString = self.returnAmountField().text! as NSString
            txtAfterUpdate = txtAfterUpdate.replacingCharacters(in: range, with: string) as NSString
            
            let amount = NumberFormatter().number(from: txtAfterUpdate == "" ? "0" : txtAfterUpdate as String)!.floatValue
            self.calculateNetReturn(Double(amount), period: Double(self.periodValue), rateOfReturn: Double(self.rorValue))
            
            return true
        } else {
            return false
        }
    }
    
    @IBAction func didTapSave(_ sender: Any) {
        let dict = ["period":self.periodValue,
                    "rateOfReturn":self.rorValue,
                    "amount":self.returnAmountField().text ?? "0"] as [String : Any]
        if let arr = UserDefaults.standard.value(forKey: "savedList") as? NSArray {
            let array = arr.mutableCopy() as! NSMutableArray
            array.add(dict)
            UserDefaults.standard.setValue(array, forKey: "savedList")
        } else {
            let array = NSMutableArray()
            array.add(dict)
            UserDefaults.standard.setValue(array, forKey: "savedList")
        }
        Alert()
    }
    
    func Alert () {
        // create the alert
        let alert = UIAlertController(title: "EMI Calculator", message: "Data Saved Successfully", preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}

extension EMI_VC {
    func setUpInitialValues () {
        let dict = historyDatas
        let amount = Float(dict.value(forKey: "amount") as? String ?? "0")
        self.periodValue = dict.value(forKey: "period") as? NSInteger ?? 0
        self.rorValue = dict.value(forKey: "rateOfReturn") as? Float ?? 0
        self.returnAmountField().text = "\(amount ?? 0)"
        self.returnRateLabel().text = "\(self.rorValue)%"
        self.returnPeriodLabel().text = "\(self.periodValue) years"
        self.returnRateSlider().value = self.rorValue
        self.returnPeriodSlider().value = Float(self.periodValue)
        self.calculateNetReturn(Double(amount ?? 0), period: Double(self.periodValue), rateOfReturn: Double(self.rorValue))
    }
}
extension EMI_VC {
    func addNavigationBarButton(title:String,direction:direction){
        switch direction {
        case .left:
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: title, style:.plain, target: self, action: #selector(didTapLeft))
        case .right:
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: title, style:.plain, target: self, action: #selector(didTapRight))
        }
    }
    
    @objc func didTapLeft() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func didTapRight() {
        let bounds = UIScreen.main.bounds
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0.0)
        self.view.drawHierarchy(in: bounds, afterScreenUpdates: false)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let activityViewController = UIActivityViewController(activityItems: [img!], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    enum direction {
        case right
        case left
    }
}

extension Double {
    
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return Darwin.round(self * divisor) / divisor
    }
    
}
