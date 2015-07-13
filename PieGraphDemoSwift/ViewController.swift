//
//  ViewController.swift
//  PieGraphDemoSwift
//
//  Created by kitano on 2015/07/10.
//  Copyright (c) 2015年 OneWorld Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var graphView:PieGraphView!;
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Do any additional setup after loading the view, typically from a nib.
        var params = [Dictionary<String,AnyObject>]()
        params.append(["value":7,"color":UIColor.redColor()])
        params.append(["value":5,"color":UIColor.blueColor()])
        params.append(["value":8,"color":UIColor.greenColor()])
        params.append(["value":10,"color":UIColor.yellowColor()])
        graphView = PieGraphView(frame: CGRectMake(0, 30, 320, 320), params: params)
        self.view.addSubview(graphView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func start(sender: AnyObject) {
        graphView.startAnimating()
    }
    
    @IBAction func change(sender: AnyObject) {
        let randInt:Int = Int(arc4random_uniform(3))+2;
        let colorList:[UIColor] = [UIColor.redColor(),
            UIColor.blueColor(),
            UIColor.yellowColor(),
            UIColor.greenColor(),
            UIColor.grayColor()]
        var params = [Dictionary<String,AnyObject>]()
        for var i=0;i<randInt;i++ {
            let param:Int = Int(arc4random_uniform(10))+1;
            params.append(["value":param,"color":colorList[i]])
        }
        graphView.changeParams(params)
        graphView.startAnimating()
    }
    
}

