//
//  JournalDetailViewController.swift
//  DayOneClone
//
//  Created by Ricardo Hui on 5/6/2019.
//  Copyright © 2019 Ricardo Hui. All rights reserved.
//

import UIKit

class JournalDetailViewController: UIViewController {

    @IBOutlet var stackView: UIStackView!
    
    @IBOutlet var journalTextLabel: UILabel!
    
    var entry: Entry?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let entry = self.entry {
            title = entry.datePrettyString()
            
            journalTextLabel.text = entry.text
            
            for picture in entry.pictures {
                let imageView = UIImageView()
                imageView.contentMode = .scaleAspectFit
                let ratio = picture.fullImage().size.height / picture.fullImage().size.width
                imageView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1.0)
                imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: ratio).isActive = true
                imageView.image = picture.fullImage()
                stackView.addArrangedSubview(imageView)
            }
        } else {
            journalTextLabel.text = ""
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
