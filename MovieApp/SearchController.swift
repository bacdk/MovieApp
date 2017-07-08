//
//  Search.swift
//  MovieApp-master
//
//  Created by Zwart on 6/23/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit

class Search: UITableViewController, UITextFieldDelegate{
    @IBOutlet weak var posterImage: UIImageView!
    
    var moviesSort = [Movie]()
    
    @IBOutlet weak var searchTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Fixing issues with Cell sizes
        tableView.rowHeight = (CGFloat) (140)
        loadData()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.backgroundColor = Constants.tintColor
        searchTextField.becomeFirstResponder()
        searchTextField.delegate = self
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchTextField.resignFirstResponder()
    }
    var elements = [AnyObject]()
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        moviesSort = []
        //If the change isn't meaningless make a search
        
        if string != " " {
            
            //Check what the change means
            
            let replaced = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
            if  replaced != "" {
                //Search for our new query!!!
                sort(_key: replaced)
                tableView.reloadData()
            } else {
                moviesSort = []
                tableView.reloadData()
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func loadData() {
        // movies = testMovie
        TMDb.getNowPlayListFireBase(completionHandler: { (movies, error) in
            if(error != nil) {
                print(error!)
            } else {
                listmovieNP = movies!
            }
        })
        TMDb.getPopularListFireBase(completionHandler: { (movies, error) in
            if(error != nil) {
                print(error!)
            } else {
                listmoviePP = movies!
            }
        })
        TMDb.getUpcomingListFireBase(completionHandler: { (movies, error) in
            if(error != nil) {
                print(error!)
            } else {
                
                listmovieUC = movies!
            }
        })
        
    }
    
    //
    func sort(_key: String)
    {
        for i in listmovieNP
        {
            if (i.title.lowercased().range(of:_key) != nil )
            {
                moviesSort.append(i)
            }
        }
        for i in listmoviePP
        {
            if (i.title.lowercased().range(of:_key) != nil )
            {
                if (!listmovieNP.contains(where: { (i) -> Bool in
                    return true
                }))
                {
                    moviesSort.append(i)
                }
            }
        }
        for i in listmovieUC
        {
            if (i.title.lowercased().range(of:_key) != nil )
            {
                moviesSort.append(i)
            }
        }
    }
    //
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the nvar kumber of rows
        if(moviesSort.count == 0)
        {
            return 1
        }
        return moviesSort.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if moviesSort.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "suggestion") ?? UITableViewCell()
            cell.textLabel?.numberOfLines = 0
            var text = "I'm here to help.\nJust Type Away!\nWhat Are you waiting for?"
            if let movieTitle = listmovieNP[(Int) (arc4random()) % (listmovieNP.count )].title {
                if (Int) (arc4random())%2 == 0 {
                    text = "Search for \"" + movieTitle + "\", maybe...\nI've heard it's good."
                }
            }
            
            //Make sure it looks nice!
            cell.textLabel?.text = text
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.white
            cell.textLabel?.textAlignment = NSTextAlignment.center
            
            return cell
        }
        else{
            if let movie = moviesSort[indexPath.row] as? Movie {
                let cell = tableView.dequeueReusableCell(withIdentifier: "movie") as? SearchCell ?? SearchCell()
                cell.movie = movie
                return cell
            }
        }
        return UITableViewCell()
    }
    
    //Handel event click cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(moviesSort.count != 0)
        {
            let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "filmDetail") as! DetailController
            detailVC.movie = moviesSort[indexPath.row]
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
