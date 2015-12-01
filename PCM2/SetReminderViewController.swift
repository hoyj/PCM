//
//  SetReminderViewController.swift
//  PCM2
//
//  Created by Youngjae Ho on 11/26/15.
//  Copyright © 2015 Youngjae Ho. All rights reserved.
//
import UIKit
import EventKit

class SetReminderViewController: UIViewController {
    
    @IBOutlet weak var myDatePicker: UIDatePicker!
    @IBOutlet weak var reminderText: UITextField!
    var contact: Contact?
    let eventStore = EKEventStore()
    
    var appDelegate: AppDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventStore.requestAccessToEntityType(EKEntityType.Reminder, completion: {
            (granted: Bool, error: NSError?) in
            if !granted {
                print("Access to store not granted")
            }
        })
        
        let calendars = eventStore.calendarsForEntityType(EKEntityType.Reminder)
        
        for calendar in calendars as [EKCalendar] {
            print("Calendar = \(calendar.title)")
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func setReminder(sender: UIButton) {
        appDelegate = UIApplication.sharedApplication().delegate
            as? AppDelegate
        
        if appDelegate!.eventStore == nil {
            appDelegate!.eventStore = EKEventStore()
            appDelegate!.eventStore!.requestAccessToEntityType(
                EKEntityType.Reminder, completion: {(granted, error) in
                    if !granted {
                        print("Access to store not granted")
                        print(error!.localizedDescription)
                    } else {
                        print("Access granted")
                    }
            })
        }
        
        if (appDelegate!.eventStore != nil) {
            self.createReminder()
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    func createReminder() {
        
        let reminder = EKReminder(eventStore: appDelegate!.eventStore!)
        reminder.title = contact!.name + ":" + reminderText.text!
        reminder.calendar =
            appDelegate!.eventStore!.defaultCalendarForNewReminders()
        let date = myDatePicker.date
        let alarm = EKAlarm(absoluteDate: date)
        
        reminder.addAlarm(alarm)
        
        do {
            try appDelegate!.eventStore!.saveReminder(reminder, commit: true)
            print("successfully set reminder")
        } catch let error as NSError {
            print("Reminder failed with error \(error.localizedDescription)")
        }
    }
    
    func removeReminder(sender: UIBarButtonItem)
    {
        print("pressed remove reminder")
    }
}