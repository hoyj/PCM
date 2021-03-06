//
//  EditContactViewController.swift
//  PCM2
//
//  Created by Youngjae Ho on 11/25/15.
//  Copyright © 2015 Youngjae Ho. All rights reserved.
//

import UIKit
import MobileCoreServices

class EditContactViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var industryTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var editData: Contact?
    var newMedia: Bool?
    var newData: Bool = false
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title="NewContact"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "NewContact"
        let rightDoneBarButtonItem:UIBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.Plain, target: self, action: "showContactDetail:")//UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: "showContactDetail:")
        self.navigationItem.setRightBarButtonItem(rightDoneBarButtonItem, animated: true)
        self.navigationController!.navigationBar.topItem!.title = ""
        numberTextField.keyboardType = UIKeyboardType.DecimalPad
        if editData != nil {//there is data coming from detail
            nameTextField.text = editData?.name
            titleTextField.text = editData?.title
            emailTextField.text = editData?.email
            numberTextField.text = editData?.number
            companyTextField.text = editData?.company
            industryTextField.text = editData?.industry
            imageView.image = editData?.image
        }
    }
    
    func showContactDetail(sender: UIBarButtonItem) {
        performSegueWithIdentifier("showContactDetail", sender: self)
    }
    
    // MARK: - TextField
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
    }
    // MARK: - Image
    
    @IBAction func useCamera() {
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.Camera) {
                
                let imagePicker = UIImagePickerController()
                
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
                imagePicker.mediaTypes = [kUTTypeImage as NSString as String]
                imagePicker.allowsEditing = false
                
                self.presentViewController(imagePicker, animated: true, 
                    completion: nil)
                newMedia = true
        }
    }
    
    @IBAction func useAlbum() {
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.SavedPhotosAlbum) {
                let imagePicker = UIImagePickerController()
                
                imagePicker.delegate = self
                imagePicker.sourceType =
                    UIImagePickerControllerSourceType.PhotoLibrary
                imagePicker.mediaTypes = [kUTTypeImage as NSString as String]
                imagePicker.allowsEditing = false
                self.presentViewController(imagePicker, animated: true,
                    completion: nil)
                newMedia = false
        }
    }
    
    @IBAction func useDefault() {
        imageView.image = UIImage(named: "defaultPhoto")
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo:UnsafePointer<Void>) {
        
        if error != nil {
            let alert = UIAlertController(title: "Save Failed",
                message: "Failed to save image",
                preferredStyle: UIAlertControllerStyle.Alert)
            
            let cancelAction = UIAlertAction(title: "OK",
                style: .Cancel, handler: nil)
            
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true,
                completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        if mediaType == (kUTTypeImage as String) {
            let image = info[UIImagePickerControllerOriginalImage]
                as! UIImage
            
            imageView.image = image
            
            if (newMedia == true) {
                UIImageWriteToSavedPhotosAlbum(image, self,
                    "image:didFinishSavingWithError:contextInfo:", nil)
            } else if mediaType == (kUTTypeMovie as String) {
                // Code to support video here
            }
            
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("in prepare for segue")
        if let identifier = segue.identifier {
            switch identifier {
            case "showContactDetail":
                /*var destination = segue.destinationViewController as UIViewController
                if let navCon = destination as? UINavigationController {
                    destination = navCon.visibleViewController!
                }*/
                if let dcvc = segue.destinationViewController as? DetailContactViewController {
                    print("preparing for detailcontactviewcontroller")
                    dcvc.contact = Contact(name: nameTextField.text!, title: titleTextField.text!, company: companyTextField.text!, industry: industryTextField.text!, memo: "", number: numberTextField.text!, email: emailTextField.text!, image: imageView.image)
                    if newData {
                        dcvc.newData = false
                    } else {
                        dcvc.newData = true
                    }
                    dcvc.unwind = true
                    print("current contact status: \(dcvc.contact.description)")
                }
            default: break
            }
        }
    }
}
