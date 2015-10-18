//
//  ViewController.swift
//  Lab5
//
//  Created by Michael Zarate on 9/30/15.
//  Copyright (c) 2015 Michael Zarate. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var maxPlace = 0

    var index = 0
    
   
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var recordTxtView: UITextView!
    @IBOutlet weak var numRecordTxtField: UITextField!
    
    @IBOutlet weak var placeTxtField: UITextField!
    
    @IBOutlet weak var dataOutTxtView: UITextView!
    
    
    let insertContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var viewContext: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func addButton(sender: UIButton) {
        
        let ent = NSEntityDescription.entityForName("PlacesData", inManagedObjectContext: self.insertContext!)
        let newItem = PlacesData(entity: ent!, insertIntoManagedObjectContext: self.insertContext!)
        newItem.name = nameTxtField.text
        newItem.placesDisc = recordTxtView.text
        self.insertContext?.save(nil)
        
    }
    
    @IBAction func prevButton(sender: UIButton) {
        //create fetch request
        
        let fetchRequest = NSFetchRequest(entityName: "PlacesData")
        
        let maxItems = getMaxPlaces()
        //perform fetch request
        
        
        
        if(index >= 0 && index <= maxItems)
        {
            if(index > 0)
            {
                index--
            }
            
            if  let fetchResults = viewContext.executeFetchRequest(fetchRequest, error: nil) as? [PlacesData]
            {
            
                let list = fetchResults[index]
                
                self.placeTxtField.text = list.name
                self.dataOutTxtView.text = list.placesDisc
            
            }
            self.numRecordTxtField.text =  "\(index + 1) of \(maxItems)"
            
            
        }
        else{
           return
        }
        
        
    }
   
    @IBAction func nextButton(sender: UIButton) {
        
        let fetchRequest = NSFetchRequest(entityName: "PlacesData")
        
        let maxItems = getMaxPlaces();
        
        if(index < maxItems && index >= 0)
        {
        
            if  let fetchResults = viewContext.executeFetchRequest(fetchRequest, error: nil) as? [PlacesData]
            {
            
                let list = fetchResults[index]
            
                self.placeTxtField.text = list.name
                self.dataOutTxtView.text = list.placesDisc
            }
            
            self.numRecordTxtField.text =  "\(index + 1) of \(maxItems)"
            index++
            
        }
        else
        {
            return
        }
        
    }
    
    func getMaxPlaces() -> Int
    {
        let fetchRequest = NSFetchRequest(entityName: "PlacesData")
        
        //perform fetch request
        
        if  let fetchResults = viewContext.executeFetchRequest(fetchRequest, error: nil) as? [PlacesData]
        {
            maxPlace = fetchResults.count
            
        }

        
        return maxPlace
    }

    


}

