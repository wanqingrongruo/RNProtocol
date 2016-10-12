//
//  ViewController.swift
//  RNProtocal
//
//  Created by 婉卿容若 on 2016/10/10.
//  Copyright © 2016年 婉卿容若. All rights reserved.
//

import UIKit

struct Rational {
    var numerator: Int
    var denominator: Int
}

class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        return cell
    }
}


extension Rational: Equatable{
    
     static func == (lhs: Rational, rhs: Rational) -> Bool {
        return (lhs.numerator == rhs.numerator) && (lhs.denominator == rhs.denominator)
    }
}
