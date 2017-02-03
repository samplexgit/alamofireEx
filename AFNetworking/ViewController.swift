//
//  ViewController.swift
//  AFNetworking
//
//  Created by Shilp_m on 1/11/17.
//  Copyright © 2017 Shilp_mphoton pho. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Foundation


class ViewController: UIViewController {
    
    var arrRes:[[String:AnyObject]]? = nil
    var arrPhone:[[String:AnyObject]]? = nil
    var Dictionary = [String: AnyObject]()
    var myVar: Int = 0
    var model = ModelClass()
    var modelarry = [ModelClass]()
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //simple request
        Alamofire.request(Constant.GlobalConstants.kBaseUrl, method: .post).responseJSON { (responseData) -> Void in
            
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resData = swiftyJsonVar["contacts"].arrayObject {
                    
                    self.arrRes = resData as? [[String:AnyObject]]
                                       
                    
                }
                self.myVar = self.arrRes!.count
                if self.arrRes!.count > 0 {
                    self.tblView.reloadData()
                }
            }
        }
        
        //sending data in request
        let parameters: [String: Any] = [
            "IdQuiz" : 102,
            "IdUser" : "iosclient",
            "User" : "iosclient",
            "List": [
                [
                    "IdQuestion" : 5,
                    "IdProposition": 2,
                    "Time" : 32
                ],
                [
                    "IdQuestion" : 4,
                    "IdProposition": 3,
                    "Time" : 9
                ]
            ]
        ]
        // sending data and json parsing without swiftyjson
        Alamofire.request(Constant.GlobalConstants.kBaseUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response)
                print(response.data)
                
                // parsing with swiftyjson
//                if((response.result.value) != nil) {
//                    let swiftyJsonVar = JSON(response.result.value!)
//                    if let resData = swiftyJsonVar["contacts"].arrayObject {
//                        
//                        self.arrRes = resData as? [[String:AnyObject]]
//                        print(self.arrRes)
//                        
//                        
//                        self.myVar = (self.arrRes?.count)!
//                        for i in 0 ..< self.myVar {
//                           
//                           self.Dictionary = self.arrRes![(i)]
//                           let aObject = self.arrRes![i]
//                           let person = ModelClass()
//                           person.name = (self.Dictionary["name"] as? String)!
//                           person.gender = (self.Dictionary["gender"] as? String)!
//                           person.email = (self.Dictionary["email"] as? String)!
//                           let phone = self.Dictionary["phone"]
//                           person.mobile = (phone?["mobile"] as? String)!
//                           //print(self.Dictionary,aObject, name,gender,mobile)
//                           self.modelarry.append(person)
//                        }
//                        
//                        
//                        
//                        
//                    }
//                }
                
                // parsing without swiftyjson
                 if let jsonData = response.data {
                    do {
                        let parsedJSON = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String:AnyObject]
                        guard let results = parsedJSON["contacts"] as? [[String:AnyObject]] else { return }
                        for result in results {
                            let person = ModelClass()
                            person.name = result["name"] as! String
                            person.gender = result["gender"] as! String
                            person.email = result["email"] as! String
                            let phone = result["phone"]
                            person.mobile = (phone?["mobile"] as? String)!
                            self.modelarry.append(person)
                        }
                        DispatchQueue.main.async {
                           self.tblView.reloadData()
                        }
                        
                    } catch let error as NSError {
                        print(error)
                    }
                }
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jsonCell", for: indexPath) as! TableViewCell
        if (self.arrRes?.count)! > 0
        {
          //self.Dictionary = self.arrRes![(indexPath as NSIndexPath).row]
          //cell.Label1.text = Dictionary["name"] as? String
          //cell.Label2.text = Dictionary["email"] as? String
          
          let person = modelarry[(indexPath as NSIndexPath).row]
          cell.Label1.text = person.name
          cell.Label2.text = person.email
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->Int {
        
        return myVar
    }

    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        
        print("You selected cell #\(indexPath.row)!")
        //let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        //self.navigationController?.pushViewController(secondViewController, animated: true)
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        nextViewController.DictionaryCopy = self.arrRes![(indexPath as NSIndexPath).row]
        self.present(nextViewController, animated:true, completion:nil)
        
    }
   

}

