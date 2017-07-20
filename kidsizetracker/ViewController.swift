//
//  ViewController.swift
//  kidsizetracker
//
//  Created by Neota Moe on 7/20/17.
//  Copyright © 2017 Neota Moe. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var addName: UITextField!
  @IBOutlet weak var tableViewName: UITableView!
  
  var myNames: [String] = []
  var handle: DatabaseHandle?
  var ref: DatabaseReference!
  
  @IBAction func addNameBtn(_ sender: Any) {
    if addName.text != "" {
      ref?.child("name").childByAutoId().setValue(addName.text)
      addName.text = ""
    }
    
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return myNames.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
    cell.textLabel?.text = myNames[indexPath.row]
    return cell
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    ref = Database.database().reference()
    
    handle = ref?.child("name").observe(.childAdded, with: { (snapshot) in
      if let name = snapshot.value as? String {
        self.myNames.append(name)
        self.tableViewName.reloadData()
      }
    })

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

