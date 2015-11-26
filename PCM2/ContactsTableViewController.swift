//
//  ContactsTableViewController.swift
//  PCM2
//
//  Created by Youngjae Ho on 11/24/15.
//  Copyright © 2015 Youngjae Ho. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController, UITextFieldDelegate {

    
    var contacts = [[Contact]]()
    var db = [[Contact]]()
    
    var searchText: String? = "" {
        didSet {
            searchTextField?.text = searchText
            //contacts.removeAll()
            tableView.reloadData()//blankout tableview
            refresh()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        refresh()
        title="Contacts"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contacts"
        let rightReminderBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Bookmarks, target: self, action: "showReminders:")
        let rightAddBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addContact:")
        self.navigationItem.setRightBarButtonItems([rightAddBarButtonItem, rightReminderBarButtonItem], animated: true)
        
        //sample contacts
        db =
            [[Contact(name: "Chad", title: "Junior", industry: "HOD", number: "615-275-9304"),
            Contact(name: "Jacob", title: "Senior", industry: "Computer Science", number: "615-275-9346"),
            Contact(name: "Andy", title: "Junior", industry: "Psychology", number: "615-275-9304")]]
        print("\(contacts)")
        refresh()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func showReminders(sender: UIBarButtonItem) {
        performSegueWithIdentifier("showReminders", sender: self)
    }
    
    func addContact(sender: UIBarButtonItem) {
        performSegueWithIdentifier("addContact", sender: self)
    }
    
    func refresh() {
        if searchText != nil {
            let request = ContactsRequest(search: searchText!)
            let newContacts = request.fetchContacts(db)
            if newContacts.count >= 0 {
                self.contacts.removeAll()
                self.contacts.insert(newContacts, atIndex: 0)
                self.tableView.reloadData()
            }
        }
    }


    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            searchTextField.delegate = self
            searchTextField.text = searchText
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == searchTextField {
            textField.resignFirstResponder()
            searchText = textField.text
        }
        return true
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return contacts.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts[section].count
    }

    private struct Storyboard {
        static let CellReuseIdentifier = "Contact"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as! ContactTableViewCell

        // Configure the cell...
        cell.contact = contacts[indexPath.section][indexPath.row]

        return cell
    }
    

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("Main prepareforsegue")
        print("\(segue.identifier)")
        if let identifier = segue.identifier {
            switch identifier {
                case "showReminders":
                    if let rtvc = segue.destinationViewController as? RemindersTableViewController {
                        print("preparing for reminderstableviewcontroller")
                        rtvc.searchText = self.searchText
                    }
                case "addContact":
                    if let _ = segue.destinationViewController as? EditContactViewController {
                        print("preparing for editcontactviewcontroller")
                }
                case "showContactDetailMain":
                    print("preparing for showdetail from main")
                    let dcvc = segue.destinationViewController as! DetailContactViewController
                    if let selectedContactCell = sender as? ContactTableViewCell {
                        let indexPath = tableView.indexPathForCell(selectedContactCell)!
                        let selectedContact = contacts[indexPath.section][indexPath.row]
                        print("in DB: \(db[0])")
                        print("selected Contact at section \(indexPath.section), row \(indexPath.row): \(selectedContact)")
                        dcvc.contact = selectedContact
                }
                
                default: break
            }
        }
    }
    
    @IBAction func unwindToContactsTableViewController(unwindSegue: UIStoryboardSegue) {//important: this must be in destination to unwind
        if let dcvc = unwindSegue.sourceViewController as? DetailContactViewController {
            print("unwinding from dcvc: \(dcvc.newData)")
            //if true, it is returning a new data. We should add to the db
            let newContact = dcvc.contact
            print("new Contact data: \(newContact)")
            if dcvc.newData {
                db[0].append(newContact)//this should allocate to appropriate section
            }else{
                print("data was edited: update cell")
                if let selectedIndexPath = tableView.indexPathForSelectedRow{
                    print("selectedIndexPath.row: \(selectedIndexPath.row)")
                    db[0][db[0].count - selectedIndexPath.row - 1] = newContact
                }
            }
            dcvc.newData = false
            refresh()
        }
        
    }

}
