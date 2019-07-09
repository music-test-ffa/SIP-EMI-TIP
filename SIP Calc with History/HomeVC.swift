//
//  HomeVC.swift
//  SIP Calc with History
//
//  Created by Lenin S on 01/07/19.
//  Copyright © 2019 Lenin. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
     var arrayValues = [SideMenuData]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        arrayValues.append(SideMenuData(title: "SIP Calculator", img:#imageLiteral(resourceName: "icon_sip_1024.png"), id: Identifier.SIP_VC))
        tableView.reloadData()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeVC {
    //MARK:- TableView Delegate
    func registerCell () {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayValues.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! UITableViewCell
        cell.textLabel?.text =  arrayValues[indexPath.row].title
       
        return cell
    }
}


class SideMenuData {
    var title:String?
    var img:UIImage?
    var id:Identifier?
    init(title:String,img:UIImage,id:Identifier) {
        self.title = title
        self.img = img
        self.id = id
    }
}
