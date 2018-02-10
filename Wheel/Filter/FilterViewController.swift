//
//  FilterViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 10/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UITableViewDataSource {
    
    // MARK: - Subviews
    
    @IBOutlet weak var options: UITableView!
    
    // MARK: - UITableViewDataSource Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            
        //food preferences
        case 0:
            return 4
            
        //allergies
        case 1:
            return 4
        
        default:
            fatalError("section #\(section) does not exists at source")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        //food preferences
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngridientsCell", for: indexPath) as? UITableViewCell else {
                fatalError("no cell to dequeque for section #\(indexPath.section)")
            }
            return cell
        //allergies
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllergiesCell", for: indexPath) as? UITableViewCell else {
                fatalError("no cell to dequeque for section #\(indexPath.section)")
            }
            return cell
        default:
            fatalError("section #\(indexPath.section) does not exists at source")
        }
    }
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        options.translatesAutoresizingMaskIntoConstraints = false
        options.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        options.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        options.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        options.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
//        options.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
//        options.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
        
        options.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
