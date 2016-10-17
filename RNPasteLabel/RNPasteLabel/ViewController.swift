//
//  ViewController.swift
//  RNPasteLabel
//
//  Created by 婉卿容若 on 2016/10/17.
//  Copyright © 2016年 婉卿容若. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var copyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        copyLabel.isUserInteractionEnabled = true
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleTap(recoginizer:)))
        copyLabel.addGestureRecognizer(longPress)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//MARK: - 为orderCodeLabel订单编号Label 提供复制粘贴
extension ViewController{
    
    
    func handleTap(recoginizer: UIGestureRecognizer){
        
        if recoginizer.state == UIGestureRecognizerState.began {
            copyLabel.becomeFirstResponder()
            
            let copyLink = UIMenuItem(title: "复制", action: #selector(copy(_:)))
            
            UIMenuController.shared.menuItems = [copyLink]
            
//            let location = recoginizer.locationInView(recoginizer.view)
//            let menuLocation = CGRectMake(location.x, location.y, 50, 50)
            UIMenuController.shared.setTargetRect(copyLabel.frame, in: copyLabel.superview!)
            UIMenuController.shared.setMenuVisible(true, animated: true)
        }
        
        
    }
    
    
     func copy(sender: AnyObject?) {
        let pasteBoard = UIPasteboard.general
        pasteBoard.string = copyLabel.text
    }
    
    
    
     func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        if action == #selector(copy(_:)) {
            return true
        }
        
        return false
    }
    
}

