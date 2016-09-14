//
//  ItemsManager.swift
//  Scavenger Hunt
//
//  Created by Jean Tu on 11/14/15.
//  Copyright © 2015 Jean Tu. All rights reserved.
//

import UIKit

class ItemsManager {
    var itemsList = [ScavengerHuntItem]() //empty array of ScavengerHuntItmes 
    
    func archivePath() -> String?{ //return optional String
        let directoryList = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        if let documentDirectory = directoryList.first {
            return documentDirectory + "/ScavengerHuntItem"
        }
        assertionFailure("Could not determine where to save the file")
        return nil
    }
    
    func save() {
        if let theArchivePath = archivePath(){
            if NSKeyedArchiver.archiveRootObject(itemsList, toFile: theArchivePath){
                print("Saved successfully!")
            }else {
                assertionFailure("Could not save to \(theArchivePath)")
            }
        }
    }
    
    func unarchiveSavedItems() {
        if let theArchivePath = archivePath() {
            if NSFileManager.defaultManager().fileExistsAtPath(theArchivePath){
                itemsList = NSKeyedUnarchiver.unarchiveObjectWithFile(theArchivePath) as! [ScavengerHuntItem]
            }
        }
    }
    
}
