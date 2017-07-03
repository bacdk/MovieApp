//
//  History.swift
//  MovieApp-master
//
//  Created by Zwart on 6/21/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit

class History: UITableViewController {
    var tickets = [Ticket]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        self.tableView.separatorStyle = .none
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    func loadData()  {
        TMDb.getTicket(completionHandler: { (tickets, error) in
            if(error != nil) {
                print(error!)
            } else {
                self.tickets = tickets!.sorted { $0.day > $1.day }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        // #warning Incomplete implementation, return the number of rows
        return tickets.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryCell
        cell.poster.image = #imageLiteral(resourceName: "default")
        print(tickets.count)
        if(tickets.count != 0)
        {
            cell.poster.loadImageUsingCacheWithUrlString("\(prefixImage)w185\(self.tickets[indexPath.row].image!)")
            cell.name.text = tickets[indexPath.row].name
            cell.date.text = "📅 \(tickets[indexPath.row].day!)"
            cell.time.text = "⏰ \(tickets[indexPath.row].time!)"
        }
        return cell
    }
    // MARK: - Segues
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showDetail" {
//            if let indexPath = tableView.indexPathForSelectedRow {
//                //data send to detail view
//                let detailVC = segue.destination as! DetailTicketVC
//                detailVC.ticket = tickets[indexPath.row]
//                detailVC.screen = "History"
//                
//            }
//        }
//    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                //data send to detail view
                let detailVC = segue.destination as! TicketVC
                detailVC.ticket = tickets[indexPath.row]
                detailVC.screen = "History"
                
            }
        }
    }
}
