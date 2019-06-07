//
//  JournalTableViewController.swift
//  DayOneClone
//
//  Created by Ricardo Hui on 5/6/2019.
//  Copyright © 2019 Ricardo Hui. All rights reserved.
//

import UIKit
import RealmSwift

class JournalTableViewController: UITableViewController {

    @IBOutlet var plusButton: UIButton!
    @IBOutlet var cameraButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        plusButton.imageView?.contentMode = .scaleAspectFit
        cameraButton.imageView?.contentMode = .scaleAspectFit
        
        if let realm = try? Realm(){
            let entries = realm.objects(Entry.self)
            print(entries.count)
            if entries.count > 0{
                print(entries[0].text)
                print(entries[0].date)
                print(entries[0].pictures.count)
            }
        }
    }

    
    @IBAction func cameraTapped(_ sender: Any) {
        performSegue(withIdentifier: "goToNew", sender: "camera")
    }
    
    @IBAction func plustapped(_ sender: Any) {
        performSegue(withIdentifier: "goToNew", sender: nil)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "goToNew"{
            if let text =  sender as? String{
                if text == "camera"{
                    let createVC = segue.destination as? CreateJournalViewController
                    createVC?.startWithCamera = true
                }
            }
        }
    }

}
