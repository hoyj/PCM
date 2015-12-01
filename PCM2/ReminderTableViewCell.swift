//
//  ReminderTableViewCell.swift
//  PCM2
//
//  Created by Youngjae Ho on 11/25/15.
//  Copyright © 2015 Youngjae Ho. All rights reserved.
//

import UIKit
import EventKit

class ReminderTableViewCell: UITableViewCell {
    
    var dateFormatter = NSDateFormatter()
    
    var contact: Contact?
    
    var reminder: EKReminder? {
        didSet{
            updateUI()
        }
    }
    @IBOutlet weak var reminderDateLabel: UILabel!
    @IBOutlet weak var reminderTitleLabel: UILabel!

    func updateUI() {
        dateFormatter.dateFormat = "MM/dd/yy"
        if reminder != nil{
            print("contact? :\(contact)")
            let str = reminder!.title
            let ind = str.startIndex.advancedBy(contact!.name.characters.count + 1)
            reminderTitleLabel.text = str.substringFromIndex(ind)
            if let alarm = reminder!.alarms {
                reminderDateLabel?.text = dateFormatter.stringFromDate(alarm[0].absoluteDate!)
            }
        }
    }
}
