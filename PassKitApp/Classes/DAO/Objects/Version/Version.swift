//
//  Version.swift
//  PassKitApp
//
//  Created by Michael Bielodied on 10/6/14.
//  Copyright (c) 2014 Michael Bielodied. All rights reserved.
//

import UIKit
import CoreData

class Version: NSManagedObject {

    @NSManaged var version: String
    @NSManaged var createdAt:Date
    @NSManaged var updatedAt:Date

}
