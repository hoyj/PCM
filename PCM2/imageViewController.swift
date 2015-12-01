//
//  imageViewController.swift
//  PCM2
//
//  Created by Youngjae Ho on 11/29/15.
//  Copyright © 2015 Youngjae Ho. All rights reserved.
//

import UIKit

class imageViewController: UIViewController {

    var scale: CGFloat = 0.90 { didSet{ view.setNeedsDisplay() }}
    var imageView: UIImageView! = UIImageView(image: UIImage(named: "defaultPhoto"))
    
    func scale(gesture: UIPinchGestureRecognizer)
    {
        print("in scale:")
        if gesture.state == .Changed {
            scale *= gesture.scale
            gesture.scale = 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.addGestureRecognizer(UIPinchGestureRecognizer(target: imageView, action: "scale:"))
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    func updateUI(){
        imageView.setNeedsDisplay()
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
