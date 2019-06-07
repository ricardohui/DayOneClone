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
    
    var entries :  Results<Entry>? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        plusButton.imageView?.contentMode = .scaleAspectFit
        cameraButton.imageView?.contentMode = .scaleAspectFit
        
       getEntries()
    }

    func getEntries(){
        if let realm  = try? Realm(){
         entries = realm.objects(Entry.self).sorted(byKeyPath: "date", ascending: false)
            tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getEntries()
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        performSegue(withIdentifier: "goToNew", sender: "camera")
    }
    
    @IBAction func plustapped(_ sender: Any) {
        performSegue(withIdentifier: "goToNew", sender: nil)
    }
    

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let entries = self.entries{
            return entries.count
        }else{
                return 0
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath) as? JournalCell{
            if let entry = entries?[indexPath.row]{
                cell.previewTextLabel.text = entry.text
                if let image = entry.pictures.first?.thumbnail(){
                    cell.imageViewWidth.constant = 100
                    cell.previewImageView.image = image
                }else{
                    cell.imageViewWidth.constant = 0
                }
            }
            
            
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
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

class JournalCell : UITableViewCell{
    
    @IBOutlet var previewTextLabel: UILabel!
    @IBOutlet var previewImageView: UIImageView!

    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var monthLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!

    @IBOutlet var imageViewWidth: NSLayoutConstraint!
    
}
