//
//  barTableViewController.swift
//  Appartoo
//
//  Created by chris 78 on 01/06/2016.
//  Copyright © 2016 Mei. All rights reserved.
//

import UIKit
import MapKit

class barTableViewController: UITableViewController
{
    // MARK: Properties
    
    var bars = [Bar]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBars()
}
    
    func loadBars()
    {
        let locations = parseJSON()
        let photo = UIImage(named: "beer")
        for dictionary in locations! {
            let latitude = CLLocationDegrees(dictionary["latitude"] as! Double)
            let longitude = CLLocationDegrees(dictionary["longitude"] as! Double)
            let name = dictionary["name"] as! String
            let tmp = dictionary["tags"]
            let tag: String
            if (tmp as? String) != nil
            {
                tag = tmp as! String
            }
            else
            {
                tag = " "
            }
            let image_URL = dictionary["image_url"] as! String
            let address = dictionary["address"] as! String
            let bar = Bar(name: name, tag: tag, address: address, photo: photo, image_URL: image_URL, latitude: latitude, longitude: longitude)
            
            bars += [bar]
        }
    }

    func load_image(urlString: String) -> UIImage?
    {
        if let url = NSURL(string: urlString)
        {
            if let data = NSData(contentsOfURL: url)
            {
                return UIImage(data: data)
            }
        }
        return nil
    }
    
    func parseJSON() -> [[String: AnyObject]]?
    {
        if let asset = NSDataAsset(name: "Data", bundle: NSBundle.mainBundle())
        {
            do
            {
                let json = try NSJSONSerialization.JSONObjectWithData(asset.data, options: .AllowFragments)
                
                if let bars = json["bars"] as? [[String: AnyObject]]
                {
                    return bars
                }
            }
            catch
            {
                print("error serializing JSON: \(error)")
            }
        }
        return nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bars.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "BarTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BarTableViewCell
        let bar = bars[indexPath.row]
        
        cell.nameLabel.text = bar.name
        cell.photoImageView.image = bar.photo
        cell.tagLabel.text = bar.tag
        cell.addressLabel.text = bar.address

        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "ShowDetail"
        {
            let barDetailViewControler = segue.destinationViewController as! DetailViewController
            
            if let selectedBarCell = sender as? BarTableViewCell
            {
                let indexPath = tableView.indexPathForCell(selectedBarCell)!
                let selectedBar = bars[indexPath.row]
                barDetailViewControler.bar = selectedBar
            }
        }
    }
    

}
