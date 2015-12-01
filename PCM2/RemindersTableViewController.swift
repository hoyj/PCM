//
//  RemindersTableViewController.swift
//  PCM2
//
//  Created by Youngjae Ho on 11/25/15.
//  Copyright © 2015 Youngjae Ho. All rights reserved.
//

import UIKit
import EventKit

class RemindersTableViewController: UITableViewController {
    
    var userDefaults = NSUserDefaults.standardUserDefaults()
    let eventStore = EKEventStore()
    var contact = Contact()
    var reminders = [EKReminder]()
    
    override func viewWillAppear(animated: Bool) {
        reminders.removeAll()
        refresh()
        title="Reminders"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Reminders"
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        self.navigationController!.navigationBar.topItem!.title = ""
        let rightAddBarButtonItem:UIBarButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self,action: "addReminder:")
        let rightRemoveBarButtonItem = editButtonItem()
        self.navigationItem.setRightBarButtonItems([rightRemoveBarButtonItem, rightAddBarButtonItem], animated: true)
    }

    func addReminder(sender: UIBarButtonItem)
    {
        performSegueWithIdentifier("addReminder", sender: self)
    }
    
    func refresh() {
        let calendars = eventStore.calendarsForEntityType(EKEntityType.Reminder)
        let predicate = eventStore.predicateForIncompleteRemindersWithDueDateStarting(nil, ending: nil, calendars: calendars)
        eventStore.fetchRemindersMatchingPredicate(predicate) { result in
            //print("result: \(result!.count)")
            for reminder in result! {
                print("reminder.title: \(reminder.title)")
                if reminder.title.rangeOfString(self.contact.name) != nil {
                    self.reminders.append(reminder)
                }
            }
            print("REMINDERS: \(self.reminders.count)")
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminders.count
    }

    private struct Storyboard {
        static let CellReuseIdentifier = "Reminder"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as! ReminderTableViewCell
        
        // Configure the cell...
        cell.contact = contact
        cell.reminder = reminders[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        print("indexPath section: \(indexPath.section), row: \(indexPath.row)")
        if editingStyle == .Delete {
            let calendars = eventStore.calendarsForEntityType(EKEntityType.Reminder)
            let predicate = eventStore.predicateForIncompleteRemindersWithDueDateStarting(nil, ending: nil, calendars: calendars)
            eventStore.fetchRemindersMatchingPredicate(predicate) { result in
                for reminder in result! {
                    if reminder == self.reminders[indexPath.row] {
                        do {
                            try self.eventStore.removeReminder(reminder, commit: true)
                            print("successfully removed completed reminder")
                        } catch let error as NSError {
                            print("failed to remove completed reminder \(error.localizedDescription)")
                        }
                    }
                }
                print("REMINDERS: \(self.reminders.count)")
                dispatch_async(dispatch_get_main_queue()) {
                    self.reminders.removeAtIndex(indexPath.row)
                    self.contact.reminder = self.reminders
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                }
            }
        }
    }
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            switch identifier {
            case "addReminder":
                if let srvc = segue.destinationViewController as? SetReminderViewController {
                    print("preparing for setremindersviewcontroller")
                    srvc.contact = contact
                }
            default: break
            }
        }
    }

}
