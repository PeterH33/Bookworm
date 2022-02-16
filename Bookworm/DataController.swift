//
//  DataController.swift
//  Bookworm
//
//  Created by Peter Hartnett on 2/14/22.
//

import CoreData
import SwiftUI


class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "Bookworm")//prepares coredata named Bookworm for use
    
    init(){
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
            
        }
    }
}
