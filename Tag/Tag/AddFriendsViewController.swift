//
//  AddFriendsViewController.swift
//  
//
//  Created by Ankita Prasad on 10/19/15.
//
//

import UIKit

class AddFriendsViewController: UIViewController, UITableViewDataSource, UISearchResultsUpdating, UITableViewDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        filteredData = data
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "TableCell")
        
        tableView.delegate = self
        // Initializing with searchResultsController set to nil means that
        // searchController will use this view controller to display the search results
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        
        // If we are using this same view controller to present the results
        // dimming it out wouldn't make sense.  Should set probably only set
        // this to yes if using another controller to display the search results.
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchBar.sizeToFit()
        searchController.hidesNavigationBarDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        
        // Sets this view controller as presenting view controller for the search interface
        definesPresentationContext = true
        // Do any additional setup after loading the view.
        shareWithFriendsList.text = "Share this photo with..."
        shareWithFriendsList.textColor = UIColor.lightGrayColor()
        shareWithFriendsList.scrollRangeToVisible(NSMakeRange(shareWithFriendsList.text.characters.count,1))
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let data = ["Ankita Prasad", "Umang Jaipuria", "Amit Prasad", "Sushant Jaipuria", "Shubhda Kaushik"]
    var filteredData : [String]!
    var searchController : UISearchController!
    

    @IBOutlet var shareWithFriendsList: UITextView!
    
    @IBOutlet var tableView: UITableView!

    @IBAction func cancelOutOfAddFriends(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TableCell")
        cell!.textLabel?.text = filteredData[indexPath.row]
        if cell!.selected {
            cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        else {
            cell!.accessoryType = UITableViewCellAccessoryType.None
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        
        filteredData = searchText!.isEmpty ? data : data.filter({(dataString: String) -> Bool in
            return dataString.rangeOfString(searchText!, options: .CaseInsensitiveSearch) != nil
        })
        
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if cell!.selected == true {
            cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
            let temp = cell?.textLabel?.text
            var appendTextWithSpace = ", "
            if shareWithFriendsList.text == "Share this photo with..." {
                shareWithFriendsList.textColor = UIColor.blackColor()
                shareWithFriendsList.text = ""
                appendTextWithSpace = ""
            }
            shareWithFriendsList.text = shareWithFriendsList.text.stringByAppendingString(appendTextWithSpace + temp!)
            shareWithFriendsList.scrollRangeToVisible(NSMakeRange(shareWithFriendsList.text.characters.count,1))
        }
        else {
            cell!.accessoryType = UITableViewCellAccessoryType.None
        }
    }
    
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell!.accessoryType = UITableViewCellAccessoryType.None
        let unselectedRowText = cell?.textLabel?.text
        var editedText = shareWithFriendsList.text.stringByReplacingOccurrencesOfString(", " + unselectedRowText!, withString: "", options: [])
        
        // ??? This is ugly code. Have to rewrite
        if(editedText.characters.count == shareWithFriendsList.text.characters.count) {
            editedText = shareWithFriendsList.text.stringByReplacingOccurrencesOfString(unselectedRowText! + ", ", withString: "", options: [])
        }
        // ??? This is ugly code. Have to rewrite
        if(editedText.characters.count == shareWithFriendsList.text.characters.count) {
            editedText = shareWithFriendsList.text.stringByReplacingOccurrencesOfString(unselectedRowText! , withString: "", options: [])
        }

        if(editedText == "") {
            editedText = "Share this photo with..."
            shareWithFriendsList.textColor = UIColor.darkGrayColor()
        }
        shareWithFriendsList.text = editedText
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
