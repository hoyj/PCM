//
//  Contacts.swift
//  PCM2
//
//  Created by Youngjae Ho on 11/25/15.
//  Copyright © 2015 Youngjae Ho. All rights reserved.
//

import Foundation
import UIKit

public class Contact: NSObject, NSCoding
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
    
    init (name: String = "", title: String = "", company: String = "", industry: String = "", memo: String = "", number: String = "", email: String = "", image:UIImage? = UIImage(named: "defaultPhoto")!)
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
    
    required convenience public init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey("name") as! String
        let title = aDecoder.decodeObjectForKey("title") as! String
        let company = aDecoder.decodeObjectForKey("company") as! String
        let industry = aDecoder.decodeObjectForKey("industry") as! String
        let memo = aDecoder.decodeObjectForKey("memo") as! String
        let number = aDecoder.decodeObjectForKey("number") as! String
        let email = aDecoder.decodeObjectForKey("email") as! String
        let reminder = aDecoder.decodeObjectForKey("reminder") as? [NSDate]
        let image = aDecoder.decodeObjectForKey("image") as! UIImage
        self.init(name:name, title:title, company:company, industry:industry, memo:memo, number:number, email:email, image:image)
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(title, forKey: "title")
        aCoder.encodeObject(company, forKey: "company")
        aCoder.encodeObject(industry, forKey: "industry")
        aCoder.encodeObject(memo, forKey: "memo")
        aCoder.encodeObject(number, forKey: "number")
        aCoder.encodeObject(email, forKey: "email")
        aCoder.encodeObject(reminder, forKey: "reminder")
        aCoder.encodeObject(image, forKey: "image")
        
    }
    
    override public var description: String
    {
        return "\(self.name), \(self.title), \(self.company), \(self.industry), \(self.memo), \(self.number), \(self.email)"
    }
    
}