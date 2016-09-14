//
//  AddViewController.swift
//  Scavenger Hunt
//
//  Created by Jean Tu on 11/13/15.
//  Copyright © 2015 Jean Tu. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    
    var newItem: ScavengerHuntItem? //optional ScavengerHuntItem b/c of the ? 
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DoneItem" {
            if let name = textField.text{
                if !name.isEmpty {
                    newItem = ScavengerHuntItem(name: name)
                }
            }
        }
    }
    
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

