//
//  DetailViewController.swift
//  notes_v1
//
//  Created by xcode on 2/24/21.
//  Copyright © 2021 elBytes. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var textView: UITextView!
    
    var masterView:ViewController!
    
    var text: String = "New"
    
    override func viewDidLoad() {
        super.viewDidLoad()
            textView.text = text       // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textView.becomeFirstResponder()
    }

    
    func setText(t:String){
        text = t;
        
        if isViewLoaded {
            textView.text = t
        }
        
    }
    
    
     override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        masterView.newRowText = textView.text
        textView.resignFirstResponder()
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
