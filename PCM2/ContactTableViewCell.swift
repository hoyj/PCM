//
//  ContactTableViewCell.swift
//  PCM2
//
//  Created by Youngjae Ho on 11/24/15.
//  Copyright © 2015 Youngjae Ho. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell
{
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
            contactTitleLabel?.text = contact.title
            contactNotesLabel?.text = contact.memo
            if let reminder = contact.reminder{
                contactReminderIndicator?.text = reminder.count == 0 ? "🔵" : "⚪️"
            }
        }
    }
}
