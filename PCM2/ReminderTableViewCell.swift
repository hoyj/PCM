//
//  ReminderTableViewCell.swift
//  PCM2
//
//  Created by Youngjae Ho on 11/25/15.
//  Copyright © 2015 Youngjae Ho. All rights reserved.
//

import UIKit

class ReminderTableViewCell: UITableViewCell {
    
    var contact: Contact? {
        didSet {
            updateUI()
        }
    }
    @IBOutlet weak var reminderNameLabel: UILabel!
    @IBOutlet weak var reminderTitleLabel: UILabel!
    @IBOutlet weak var reminderDateLabel: UILabel!

    func updateUI() {
        reminderNameLabel?.attributedText = nil
        reminderTitleLabel?.text = nil
        reminderDateLabel?.text = nil
        
        if let contact = self.contact
        {
            if let reminder = contact.reminder{
                reminderNameLabel?.text = contact.name
                reminderTitleLabel?.text = contact.title
                reminderDateLabel?.text = "Reminder exists"
            }
        }
    }
}
