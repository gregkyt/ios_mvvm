//
//  HomeViewController.swift
//  SkyshiMVVM
//
//  Created by Skyshi on 7/20/18.
//  Copyright © 2018 Skyshi. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NVActivityIndicatorViewable {

    @IBOutlet var loginVM: LoginVM!
    @IBOutlet var tblLogin: UITableView!
    @IBOutlet var heightTbl: NSLayoutConstraint!
    let helper = Helper()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.isHidden = true
        
        tblLogin.rowHeight = UITableViewAutomaticDimension
        tblLogin.estimatedRowHeight = 44
        
        self.tblLogin.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Table View Delegate, Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loginVM.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: loginVM.cellIdentifier(indexPath: indexPath))! as! TableViewCell
        
        return cell
    }
    
    // MARK: Login
    
    @IBAction func login() {
        self.view.endEditing(true)
        for i in 0..<loginVM.numberOfRowsInSection(section: 0) {
            let cell: TableViewCell = tblLogin.cellForRow(at: IndexPath(row: i, section: 0)) as! TableViewCell
            
            if i == 0 {
                loginVM.setEmail(email: cell.txtTable.text ?? "")
            } else {
                loginVM.setPassword(password: cell.txtTable.text ?? "")
            }
        }
        
        loginVM.showLoading()
        loginVM.userLogin { error, message in
            self.loginVM.hideLoading()
            if error {
                self.helper.toast(view: self, header: "Warning", body: message!)
            } else {
                self.performSegue(withIdentifier: "ToMain", sender: self)
            }
        }
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
