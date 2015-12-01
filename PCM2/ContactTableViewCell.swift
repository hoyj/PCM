//
//  ContactTableViewCell.swift
//  PCM2
//
//  Created by Youngjae Ho on 11/24/15.
//  Copyright © 2015 Youngjae Ho. All rights reserved.
//

import UIKit
import EventKit

class ContactTableViewCell: UITableViewCell
{
    let eventStore = EKEventStore()
    var contact: Contact? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactTitleLabel: UILabel!
    @IBOutlet weak var contactNotesLabel: UILabel!
    @IBOutlet weak var contactReminderIndicator: UILabel!
    
    func updateUI() {
        contactNameLabel?.attributedText = nil
        contactTitleLabel?.text = nil
        contactNotesLabel?.text = nil
        contactReminderIndicator?.text = "⚪️"
        
        if let contact = self.contact
        {
            contactNameLabel?.text = contact.name
            contactNameLabel?.sizeToFit()
            contactTitleLabel?.text = contact.title
            contactNotesLabel?.text = contact.company
            if let _ = contact.reminder{
                let calendars = eventStore.calendarsForEntityType(EKEntityType.Reminder)
                let predicate = eventStore.predicateForIncompleteRemindersWithDueDateStarting(nil, ending: nil, calendars: calendars)
                eventStore.fetchRemindersMatchingPredicate(predicate) { result in
                    for reminder in result! {
                        if reminder.title.rangeOfString(self.contact!.name) != nil {
                            self.contactReminderIndicator?.text = "🔵"
                            break
                        }
                    }
                }
            }else{
                print("not able to retrieve reminder")
            }
        }
    }
}
