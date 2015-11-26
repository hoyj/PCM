//
//  Contacts.swift
//  PCM2
//
//  Created by Youngjae Ho on 11/25/15.
//  Copyright © 2015 Youngjae Ho. All rights reserved.
//

import Foundation
import UIKit

public class Contact: CustomStringConvertible
{
    public var name: String
    public var title: String
    public var company: String
    public var industry: String
    public var memo: String
    public var number: String
    public var email: String
    public var reminder: [NSDate]?
    public var image: UIImage?
    
    init(){
        self.name = ""
        self.title = ""
        self.company = ""
        self.industry = ""
        self.memo = ""
        self.number = ""
        self.email = ""
        self.image = UIImage(named: "defaultPhoto")
    }
    
    init (name: String, title: String = "", company: String = "", industry: String = "", memo: String = "", number: String, email: String = "", image:UIImage? = UIImage(named: "defaultPhoto"))
    {
        self.name = name
        self.title = title
        self.company = company
        self.industry = industry
        self.memo = memo
        self.number = number
        self.email = email
        self.image = image
    }
    
    public var description: String
    {
        return "\(self.name), \(self.title), \(self.company), \(self.industry), \(self.memo), \(self.number), \(self.email)"
    }
    
}