//
//  NSManagedObjectContext+Extension.swift
//  KinoCircle
//
//  Created by Jan Madera on 05/06/2020.
//  Copyright © 2020 Jan Madera. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension NSManagedObjectContext {
    
    static var current: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
