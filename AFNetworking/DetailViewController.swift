//
//  DetailViewController.swift
//  AFNetworking
//
//  Created by Shilp_m on 1/17/17.
//  Copyright © 2017 Shilp_mphoton pho. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var DictionaryCopy = [String: AnyObject]()
    
    @IBOutlet weak var LblName: UILabel!
    @IBOutlet weak var LblEmail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(self.DictionaryCopy)
        
        
        if  DictionaryCopy.count > 0 {
            // do something with myData
            LblName.text = DictionaryCopy["name"] as? String
            LblEmail.text = DictionaryCopy["email"] as? String
        } else {
            // no data was obtained
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BtnBack(_ sender: AnyObject) {
        self.dismiss(animated: false, completion: nil)
        
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
