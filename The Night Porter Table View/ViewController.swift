//
//  ViewController.swift
//  The Night Porter Table View
//
//  Created by Chukhrai, Yurii on 1/25/20.
//  Copyright © 2020 Chukhrai, Yurii. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

//    let dailyTasks: [String] = [ "Check all windows",
//                     "Check all doors",
//                     "Is the boiler fueled?",
//                     "Check the mailbox",
//                     "Empty trash containers",
//                     "If freezing, check water pipes",
//                     "Document [strange and unusual occurrences]" ]
    //    let weeklyTasks: [String] = [ "Check inside all cabins",
    //                                "Flush all lavatories in cabins",
    //                                "Walk perimeter of property" ]
        
        //let monthlyTasks: [String] = [ "Test security alarm", "Test monitor detectors", "Test smoke alarms" ]
        
        //lazy var allTasks: [[String]] = [self.dailyTasks, self.weeklyTasks, self.monthlyTasks]
    

    @IBOutlet weak var taskTableView: UITableView!
    
    
    var dailyTasks: [Task] = [
        Task(name: "Check inside all cabins", type: .daily, completed: false, lastCompleted: nil),
        Task(name: "Check all windows", type: .daily, completed: false, lastCompleted: nil),
        Task(name: "Check all doors", type: .daily, completed: false, lastCompleted: nil),
        Task(name: "Is the boiler fueled?", type: .daily, completed: false, lastCompleted: nil ),
        Task(name: "Check the mailbox", type: .daily, completed: false, lastCompleted: nil),
        Task(name: "Empty trash containers", type: .daily, completed: false, lastCompleted: nil),
        Task(name: "If freezing, check water pipes", type: .daily, completed: false, lastCompleted: nil),
        Task(name: "Document \"strange and unusual\" occurrences", type: .daily, completed: false, lastCompleted: nil)
    ]
    
    var weeklyTasks = [
        Task(name: "Check inside all cabins", type: .weekly, completed: false, lastCompleted: nil ),
        Task(name:  "Flush all lavatories in cabins", type: .weekly, completed: false, lastCompleted: nil ),
        Task(name: "Walk the perimeter of property", type: .weekly, completed: false, lastCompleted: nil )
    ]
    
    var monthlyTasks = [
        Task(name:"Test security alarm", type: .monthly, completed: false, lastCompleted: nil ),
        Task(name:"Test motion detectors", type: .monthly, completed: false, lastCompleted: nil ),
        Task(name:"Test smoke alarms", type: .monthly, completed: false, lastCompleted: nil )
    ]

    lazy var allTasks: [[Task]] = [dailyTasks, weeklyTasks, monthlyTasks]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // UI Table View Data Source Protocol
    func numberOfSections(in tableView: UITableView) -> Int {
        
        // Clear Table view and make it clear
        tableView.backgroundColor = UIColor.clear
        return allTasks.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return allTasks[0].count
        case 1:
            return allTasks[1].count
        case 2:
            return allTasks[2].count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        // to hold the current task
        var currentTask: Task!
         
        switch indexPath.section {
        case 0:
            currentTask = allTasks[0][indexPath.row]
        case 1:
            currentTask = allTasks[1][indexPath.row]
        case 2:
            currentTask = allTasks[2][indexPath.row]
        default:
            break
        }
        
        // use the name property to set the value of the cell
        cell.textLabel?.text = currentTask.name
        
        // Check if completed
        if currentTask.completed {
            cell.textLabel?.textColor = UIColor.lightGray
            cell.accessoryType = .checkmark
        } else {
            cell.textLabel?.textColor = UIColor.black
            cell.accessoryType = .none
        }
        
        // Clear Table view Cell and make it clear
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    // Headers for sections
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "Daily Tasks"
        case 1:
            return "Weekly Tasks"
        case 2:
            return "Monthly Tasks"
        default:
            return nil
        }
        
    }
    
    // Delagate Protocol
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let completeAction = UIContextualAction(style: .normal, title: "Done") {(action: UIContextualAction, sourceView: UIView, actionPerformed: (Bool) -> Void) in
            
            //Find the right object and set it to completed
            
            switch indexPath.section {
                
            case 0:
                self.allTasks[0][indexPath.row].completed = true
            case 1:
                self.allTasks[1][indexPath.row].completed = true
            case 2:
                self.allTasks[2][indexPath.row].completed = true
                
            default:
                break
            }
            
            // Refresh Table
            tableView.reloadData()
            
            actionPerformed(true)
        }
        return UISwipeActionsConfiguration (actions: [completeAction])
    }
    
    //IB - Interface Builder
    @IBAction func toggleDarkMode(_ sender: Any) {
//        view.backgroundColor = switchColorMode(view.backgroundColor!, UIColor.systemBackground, UIColor.darkGray)
//        
//        // get everything contained in the top-level view
//        let everything = view.subviews
//        
//        for eachView in everything {
//            //eachView.backgroundColor = UIColor.systemGreen
//            //is it a label?
//            if eachView is UILabel {
//                //downcast as UILabel
//                let currentLabel = eachView as! UILabel
//                currentLabel.textColor = switchColorMode(currentLabel.textColor, UIColor.darkText, UIColor.lightGray )
//            }
//            
//        }
        
        let mySwitch = sender as! UISwitch
        
        if mySwitch.isOn {
            view.backgroundColor = UIColor.darkGray
        }
        else{
            view.backgroundColor = UIColor.white
        }
    }//toggleDarkMode
    
    func switchColorMode(_ objectColor: UIColor, _ defaultColorMode: UIColor, _ darkColorMode: UIColor) -> UIColor {
        return (objectColor != darkColorMode ? darkColorMode : defaultColorMode)
    }
    

    @IBAction func resetTasks(_ sender: Any) {
        
        let confirm = UIAlertController(title: "Are you sure?", message: "Really reset the list?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) {
            action in
            
            for i in 0..<self.allTasks.count {
                for j in 0..<self.allTasks[i].count {
                    self.allTasks[i][j].completed = false
                }
            }
            
            self.taskTableView.reloadData()
            
        }
        

        let noAction = UIAlertAction(title: "No", style: .cancel) {
            action in
            print("That was a close one!")
        }
        
        // add actions to Alert controller
        confirm.addAction(yesAction)
        confirm.addAction(noAction)
        
        //show it
        present(confirm, animated: true, completion: nil)
        
    }//resetTasks
    
    
    
    
}

