//
//  ListViewController.swift
//  Scavenger Hunt
//
//  Created by Jean Tu on 11/14/15.
//  Copyright © 2015 Jean Tu. All rights reserved.
//

import Foundation
import UIKit //allows you to use Table 

class ListViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let myManager = ItemsManager() //calls initializer
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera){
            imagePicker.sourceType = .Camera
        } else {
            imagePicker.sourceType = .PhotoLibrary
        }
        imagePicker.delegate = self
        presentViewController(imagePicker, animated:true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let selectedItem = myManager.itemsList[indexPath.row]
            let photo = info[UIImagePickerControllerOriginalImage] as! UIImage
            selectedItem.photo = photo
            myManager.save()
            dismissViewControllerAnimated(true, completion: {() ->Void in
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            })
        }
    }
    
    @IBAction func unWindToList(segue: UIStoryboardSegue) {
        if segue.identifier == "DoneItem" {
            let addVC = segue.sourceViewController as! AddViewController
            if let newItem = addVC.newItem{
                myManager.itemsList += [newItem] //must add an array to an array
                myManager.save() //saving here because you can have interruptions
                let indexPath = NSIndexPath(forRow: myManager.itemsList.count - 1, inSection: 0)
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myManager.itemsList.count //number of data points
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //need a new cell from the reusable library 
        let cell = tableView.dequeueReusableCellWithIdentifier("ListViewCell", forIndexPath: indexPath)
        
        let item = myManager.itemsList[indexPath.row]
        
        if (item.isCompleted) {
            cell.accessoryType = .Checkmark
            cell.imageView?.image = item.photo
        } else {
            //reset the recycled cells 
            cell.accessoryType = .None
            cell.imageView?.image = nil
        }
        
        cell.textLabel?.text = item.name //getting the row out of the index path
        
        return cell
    }
    
}