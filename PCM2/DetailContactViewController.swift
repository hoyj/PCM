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
    @IBOutlet weak var memoView: UITextView! //DO NOT ADD press recognizer for memoview
    
    var contact = Contact()
    var newData: Bool = false
    var unwind: Bool = false
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = "\(contact.name.uppercaseString)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        self.navigationController!.navigationBar.topItem!.title = ""
        //unwind
        let backButton: UIBarButtonItem = UIBarButtonItem(title: "List", style: UIBarButtonItemStyle.Plain, target: self, action: "unwindToContactsTableViewController:")
        self.navigationItem.setLeftBarButtonItem(backButton, animated: true)
        //gesture Recognizer
        //let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapped:")
        //self.titleLabel.addGestureRecognizer(tapGestureRecognizer)
        let namePressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "pressed:")
        self.nameLabel.addGestureRecognizer(namePressGestureRecognizer)
        let titlePressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "pressed:")
        self.titleLabel.addGestureRecognizer(titlePressGestureRecognizer)
        let industryPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "pressed:")
        self.industryLabel.addGestureRecognizer(industryPressGestureRecognizer)
        let companyPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "pressed:")
        self.companyLabel.addGestureRecognizer(companyPressGestureRecognizer)
        let imagePressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "pressed:")
        self.imageView.addGestureRecognizer(imagePressGestureRecognizer)
        let numberPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "pressed:")
        self.numberLabel.addGestureRecognizer(numberPressGestureRecognizer)
        let emailPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "pressed:")
        self.emailLabel.addGestureRecognizer(emailPressGestureRecognizer)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapped(sender: UITapGestureRecognizer)
    {
        print("tap noticed, going to edit screen")
        if sender.state == UIGestureRecognizerState.Began
        {
            self.performSegueWithIdentifier("edit", sender: self)
        }
    }
    
    @IBAction func pressed(sender: UILongPressGestureRecognizer)
    {
        print("Longpress noticed, going to edit screen")
        if sender.state == UIGestureRecognizerState.Ended
        {
            self.performSegueWithIdentifier("edit", sender: self)
        }
    }
    
    func setUI(){
        title = "\(contact.name.uppercaseString)"
        companyLabel.text = contact.company
        industryLabel.text = contact.industry
        titleLabel.text = contact.title
        nameLabel.text = contact.name
        imageView.image = contact.image
        numberLabel.text = contact.number
        emailLabel.text = contact.email
        memoView!.layer.borderWidth = 1
        memoView!.layer.borderColor = UIColor.grayColor().CGColor
    }
    override func canPerformUnwindSegueAction(action: Selector, fromViewController: UIViewController, withSender sender: AnyObject) -> Bool {
        print("can perform unwindsegue?: \(unwind)")
        if unwind {
            return true
        }else{
            return false
        }
    }
    func unwindToContactsTableViewController(sender: UIBarButtonItem){
        print("pressed back from detailcontactviewcontroller")
        self.performSegueWithIdentifier("back", sender: self)
    }
    
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            switch identifier {
            case "edit":
                if let ecvc = segue.destinationViewController as? EditContactViewController {
                    print("preparing for editcontactviewcontroller")
                    ecvc.editData = contact
                    print("current contact status: \(ecvc.editData!.description)")
                    if !newData {
                        ecvc.newData = true
                    }
                    unwind = false
                }
            default: break
            }
        }
    }
    

}
