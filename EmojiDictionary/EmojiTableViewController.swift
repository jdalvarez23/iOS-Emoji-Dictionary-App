//
//  EmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by student19 on 2/15/19.
//  Copyright © 2019 Jose Alvarez. All rights reserved.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    
    var emojis: [Emoji] = [] // initialize emoji array to display

    override func viewDidLoad() {
        super.viewDidLoad()
        
        emojis = Emoji.loadFromFile() // set value to returned array from file or sample emoji array

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        if (section == 0) {
            return emojis.count
        } else {
            return 0
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath)

        // Configure the cell...
        let emoji = emojis[indexPath.row]
        
        cell.textLabel?.text = "\(emoji.symbol) - \(emoji.name)"
        cell.detailTextLabel?.text = emoji.description
        
        cell.showsReorderControl = true // display reorder control (at right of its content) when editing mode is on
        */
        
        // Dequeue the cell... (update to use new custom cell)
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell") as! EmojiTableViewCell
        
        // Fetch model object to display...
        let emoji = emojis[indexPath.row]
        
        // Configure the cell...
        cell.update(with: emoji)
        cell.showsReorderControl = true // display reorder control (at right of its content) when editing mode is on
        
        // Return the cell...
        return cell
    }
    
    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let emoji = emojis[indexPath.row]
        
        print("\(emoji.symbol) \(indexPath)")
        
    }
    */
    
    // method that executes when the edit button is pressed
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        
        let tableViewEditingMode = tableView.isEditing
        
        tableView.setEditing(!tableViewEditingMode, animated: true)
        
        if (!tableViewEditingMode) {
            print("User is currently editing...")
            
            sender.title = "Done"
            
        } else {
            print("User stopped editing...")
            
            sender.title = "Edit"
            
            Emoji.saveToFile(emojis: emojis) // save new array to file
            
            
        }
        
    }
    
    // Override to support editing styles for rows of the table view.
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        // return .none
        return .delete
        
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the emoji from the array
            emojis.remove(at: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

        /* NOTE: the following code will remove the data within emojis at fromIndexPath.row and add it back at to.row */
        
        let movedEmoji = emojis.remove(at: fromIndexPath.row)
        
        emojis.insert(movedEmoji, at: to.row)
        
        tableView.reloadData()
        
    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
