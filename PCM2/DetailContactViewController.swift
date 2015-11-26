//
//  DetailContactViewController.swift
//  PCM2
//
//  Created by Youngjae Ho on 11/25/15.
//  Copyright © 2015 Youngjae Ho. All rights reserved.
//

import UIKit

class DetailContactViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var industryLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var memoView: UITextView!
    
    var contact = Contact()
    var newData: Bool = false
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = "\(contact.name.uppercaseString)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(contact.name.uppercaseString)"
        companyLabel.text = contact.company
        industryLabel.text = contact.industry
        titleLabel.text = contact.title
        nameLabel.text = contact.name
        imageView.image = contact.image
        numberLabel.text = contact.number
        emailLabel.text = contact.email
        self.navigationController!.navigationBar.topItem!.title = ""
        memoView!.layer.borderWidth = 1
        memoView!.layer.borderColor = UIColor.grayColor().CGColor
        let backButton: UIBarButtonItem = UIBarButtonItem(title: "List", style: UIBarButtonItemStyle.Plain, target: self, action: "unwindToContactsTableViewController:")
        self.navigationItem.setLeftBarButtonItem(backButton, animated: true)
        //unwind
        // Do any additional setup after loading the view.
    }

    func unwindToContactsTableViewController(sender: UIBarButtonItem){
        print("pressed back from detailcontactviewcontroller")
        self.performSegueWithIdentifier("back", sender: self)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
