//
//  ViewController.swift
//  YSEmitterView
//
//  Created by 李泓松 on 2017/5/12.
//  Copyright © 2017年 yoser. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emitterView: YSEmitterView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        emitterView.sourceImage = UIImage(named: "AAA.jpg")
        emitterView.burstPoint = CGPoint(x: emitterView.frame.width * 0.5,
                                         y: emitterView.frame.height * 0.5)
        
        emitterView.startEmitter()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

