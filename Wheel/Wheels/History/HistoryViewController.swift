//
//  HistoryViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 26/10/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class HistoryViewController: SWViewController {
    
    var assembler: SWHistoryAssembler!
    
    // MARK: - Private Properties
    
    private var history: UITableView!
    
    private var recipies: SWRecipyRepository!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.segues = assembler.resolve()
        
        self.recipies = assembler.resolve()
        
        do {
            navigationItem.titleView = UILabel.historyTitle
        }
        
        do {
            history = UITableView(frame: CGRect(origin: CGPoint(x: 0, y: 40), size: CGSize(width: self.view.bounds.width, height: self.view.bounds.height - 40)))
            history.register(SWHistoryViewCell.self, forCellReuseIdentifier: String(describing: SWHistoryViewCell.self))
            history.dataSource = self
            self.view.addSubview(history)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
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

extension HistoryViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.recipies.getAll().count
        return 16
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SWHistoryViewCell.self), for: indexPath)
        return cell
    }
    
}


