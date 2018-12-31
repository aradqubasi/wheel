//
//  HistoryViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 26/10/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class HistoryViewController: SWTransitioningViewController {
    
    var assembler: SWHistoryAssembler!
    
    // MARK: - Dependencies
    
    private var recipies: SWRecipyRepository!
    
    private var cellAligner: SWHistoryCellAligner!
    
    private var ingredients: SWIngredientRepository!
    
    // MARK: - Private Properties
    
    private var history: UITableView!
    
    private var tableIndex: [Int] = []
    
//    private var swiper: SWDismissHistoryGestureRecognizer!
    
//    private var transitioning: UIPercentDrivenInteractiveTransition!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ingredients = assembler.resolve()

        self.segues = assembler.resolve()
        
        self.recipies = assembler.resolve()
        
        self.cellAligner = assembler.resolve()
        
        self.tableIndex = recipies.getAll().sorted(by: {
            (prev, next) -> Bool in
            return prev.timestamp > next.timestamp
        }).map({
            $0.id!
        })
        
        do {
            history = UITableView(frame: CGRect(origin: CGPoint(x: 0, y: 40), size: CGSize(width: self.view.bounds.width, height: self.view.bounds.height - 40)))
            history.register(SWHistoryViewCell.self, forCellReuseIdentifier: String(describing: SWHistoryViewCell.self))
            history.separatorStyle = .none
            history.dataSource = self
            history.delegate = self
            self.view.addSubview(history)
        }

        do {
            navigationItem.titleView = UILabel.historyTitle
            
            let back = UIBarButtonItem.back
            navigationItem.leftBarButtonItem = back
            back.action = #selector(onBackClick(sender:))
            back.target = self
        }
        
        //swipe to recipy
        do {
            self.swiper = SWDismissHistoryGestureRecognizer()
            self.view.addGestureRecognizer(self.swiper)
            self.swiper.addTarget(self, action: #selector(onSwipe(sender:)))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    // MARK: - Private Methods
    
    // MARK: - Actions
    
//    @IBAction func onBackButtonClick(sender: Any) {
//        perform(segue: segues.getHistoryToWheels())
//    }
    
//    var lastChanged: Date = Date()
    
//    @IBAction func onSwipe(sender: SWDismissHistoryGestureRecognizer) {
//        if sender.state == .began {
//            print("began")
//            perform(segue: segues.getHistoryToWheelsWithSwipe())
//        }
//        else if sender.state == .changed {
//            print("changed \(sender.Progress)")
//            self.transitioning.update(sender.Progress)
//        }
//        else if sender.state == .cancelled {
//            print("cancelled")
//            self.transitioning.cancel()
//        }
//        else if sender.state == .ended {
//            print("ended")
//            self.transitioning.finish()
//        }
//    }
    
    // MARK: - Navigation
    @IBAction func unwindToHistory(segue: UIStoryboardSegue) {
        self.tableIndex = recipies.getAll().sorted(by: {
            (prev, next) -> Bool in
            return prev.timestamp > next.timestamp
        }).map({
            $0.id!
        })
        self.history.reloadData()
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case segues.getHistoryToRecipy().identifier?:
            if let recipyViewController = (segue.destination as? RecipyViewController) {
                recipyViewController.assembler = assembler.resolve()
                recipyViewController.selection = self
                    .recipies
                    .get(by: self.tableIndex[self.history.indexPathForSelectedRow!.row])!
                recipyViewController.backSegue = self.segues.getRecipyToHistory()
                recipyViewController.backWithSwipeSegue = self.segues.getRecipyToHistoryWithSwipe()
                recipyViewController.showLikeButton = true
                recipyViewController.showDeleteButton = true
            }
            self.history.deselectRow(at: self.history.indexPathForSelectedRow!, animated: true)
        case segues.getHistoryToWheels().identifier?, segues.getHistoryToWheelsWithSwipe().identifier?:
            print("back to wheels")
        default:
            fatalError("Unhandled segue \(segue.identifier ?? "")")
        }
    }

}

extension HistoryViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableIndex.count
//        return 16
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SWHistoryViewCell.self), for: indexPath) as! SWHistoryViewCell
        cell.setRecipy(self.recipies.get(by: tableIndex[indexPath.row])!, cellAligner, {
            (recipy) -> Void in
            var recipy = recipy
            recipy.liked = !recipy.liked
            self.recipies.save(recipy)
            tableView.reloadRows(at: [indexPath], with: .none)
        })
        return cell
    }
    
}

extension HistoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let calculated = self.cellAligner.calculatePositions(for: self.cellAligner.generateView(for: self.recipies.get(by: tableIndex[indexPath.row])!)).height
        return calculated
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.recipies.removeBy(id: tableIndex[indexPath.row])
            self.tableIndex = recipies.getAll().sorted(by: {
                (prev, next) -> Bool in
                return prev.timestamp > next.timestamp
            }).map({
                $0.id!
            })
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        perform(segue: self.segues.getHistoryToRecipy())
    }
    
}

//extension HistoryViewController: SWDismissableViewController {
//
//    func interactionControllerForDismissal() -> UIViewControllerInteractiveTransitioning? {
//        return self.transitioning
//    }
//
//}

