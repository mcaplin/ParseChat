//
//  ChatViewController.swift
//  Parse Chat
//
//  Created by Michelle Caplin on 2/22/18.
//  Copyright © 2018 Michelle Caplin. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var chatField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var messages: [PFObject] = []
    
    

    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        
        tableView.separatorStyle = .none
        
        
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    
    
    @IBAction func onSend(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")

        chatMessage["text"] = chatField.text ?? ""
        chatMessage["user"] = PFUser.current()
        
        if chatMessage["text"] as! String != "" {
            chatMessage.saveInBackground { (success, error) in
                if success {
                    print("The message was saved!")
                    self.chatField.text = ""
                } else if let error = error {
                    print("Problem saving message: \(error.localizedDescription)")
                }
            }
        }

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        let message = self.messages[indexPath.row]
        if let user = message["user"] as? PFUser {
            cell.user.text = user.username
        }
        else {
            cell.user.text = "🅱️"
        }

        cell.message.text = (message["text"] as! String)
        return cell
    }
    
    func onTimer() {
        // Add code to be run periodically
        // refresh
        let query = PFQuery(className: "Message")
        query.includeKey("user")
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground { (messages, error) in
            if let messages = messages {
                
                self.messages = messages
                self.tableView.reloadData()
            }
            else {
                print(error?.localizedDescription as Any)
            }
            
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
