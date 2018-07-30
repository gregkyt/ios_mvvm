//
//  ViewController.swift
//  SkyshiMVVM
//
//  Created by Skyshi on 7/19/18.
//  Copyright © 2018 Skyshi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var movieVM: MovieVM!
    @IBOutlet var tblMovie: UITableView!
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.navigationBar.isHidden = false
        movieVM.setNavBar(view: self, title: "List Movie")
        
        movieVM.getMovies {
            self.tblMovie.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: Table View Delegate, Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieVM.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.lblTitle.text = movieVM.titleOfRows(indexPath: indexPath, field: MovieField.name)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movie = movieVM.dataOfRows(indexPath: indexPath)
        self.performSegue(withIdentifier: "ToDetail", sender: self)
    }
    
     // MARK: - Navigation
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetail" {
            let destVC = segue.destination as! DetailViewController
            destVC.movie = movie
        }
     }
}

