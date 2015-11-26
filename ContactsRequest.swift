//
//  ContactRequest.swift
//  PCM2
//
//  Created by Youngjae Ho on 11/25/15.
//  Copyright © 2015 Youngjae Ho. All rights reserved.
//

import Foundation

public class ContactsRequest {
    public var search: String = ""
    
    init (search: String = "")
    {
        self.search = search
    }
    
    func fetchContacts(contacts: [[Contact]]) -> [Contact] {
        var handler = [Contact]()
        if self.search == "" {
            for section in contacts {
                for contact in section{
                    handler.insert(contact, atIndex: 0)
                }
            }
        } else {
            print("\nsearch from \(contacts.count)")
            for section in contacts {
                print("section")
                for contact in section {
                    print("\nsearch: \(self.search)")
                    print("contact: \(contact.description)")
                    if contact.description.lowercaseString.rangeOfString(search.lowercaseString) != nil {
                        handler.insert(contact, atIndex: 0)
                    }
                }
            }
        }
        print("found: \(handler.count)")
        return handler
    }
}