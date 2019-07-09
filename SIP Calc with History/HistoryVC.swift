//
//  HistoryVC.swift
//  SIP Calc with History
//
//  Created by Lenin S on 09/05/19.
//  Copyright © 2019 Lenin. All rights reserved.
//

import UIKit

class HistoryVC: UIViewController {
    var datas = NSMutableArray()
 var arrayValues = [SideMenuData]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SIP-EMI-TIP"
        if let arr = UserDefaults.standard.value(forKey: "savedList") as? NSArray {
            datas = arr.mutableCopy() as! NSMutableArray
        }
        
        arrayValues.append(SideMenuData(title: "SIP Calculator", img:#imageLiteral(resourceName: "icon_sip_1024.png"), id: Identifier.SIP_VC))
         arrayValues.append(SideMenuData(title: "EMI Calculator", img:#imageLiteral(resourceName: "icon_sip_1024.png"), id: Identifier.EMI_VC))
        arrayValues.append(SideMenuData(title: "TIP Calculator", img:#imageLiteral(resourceName: "icon_sip_1024.png"), id: Identifier.TIP_VC))
        tableView.reloadData()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
       // addNavigationBarButton(title: "Home", direction: .right)
        self.navigationController?.navigationItem.hidesBackButton = true
        self.navigationItem.hidesBackButton = true
       
        
    }
  
  
}
extension HistoryVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayValues.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text =  arrayValues[indexPath.row].title

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: arrayValues[indexPath.row].id!.rawValue)
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
}
extension HistoryVC {
    func addNavigationBarButton(title:String,direction:direction){
        switch direction {
        case .left:
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: title, style:.plain, target: self, action: #selector(didTapLeft))
        case .right:
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: title, style:.plain, target: self, action: #selector(didTapRight))
        }
    }
    
    @objc func didTapLeft() {
       
    }
    @objc func didTapRight() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    enum direction {
        case right
        case left
    }
}
