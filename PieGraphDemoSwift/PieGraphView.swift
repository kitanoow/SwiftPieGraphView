//
//  PieGraphView.swift
//  PieGraphDemoSwift
//
//  Created by kitano on 2015/07/10.
//  Copyright (c) 2015年 OneWorld Inc. All rights reserved.
//

import UIKit

class PieGraphView: UIView {
    
    var _params:[Dictionary<String,AnyObject>]!
    var _end_angle:CGFloat!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(frame: CGRect,params:[Dictionary<String,AnyObject>]) {
        super.init(frame: frame)
        _params = params;
        self.backgroundColor = UIColor.clearColor();
        _end_angle = -CGFloat(M_PI / 2.0);
    }

    
    func update(link:AnyObject){
        var angle = CGFloat(M_PI*2.0 / 100.0);
        _end_angle = _end_angle +  angle
        if(_end_angle > CGFloat(M_PI*2)) {
            //終了
            link.invalidate()
        } else {
            self.setNeedsDisplay()
        }
        
    }
    func changeParams(params:[Dictionary<String,AnyObject>]){
        _params = params;
    }

    func startAnimating(){
        _end_angle = -CGFloat(M_PI / 2.0);
        let displayLink = CADisplayLink(target: self, selector: Selector("update:"))
        displayLink.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code

        let context:CGContextRef = UIGraphicsGetCurrentContext();
        var x:CGFloat = rect.origin.x;
        x += rect.size.width/2;
        var y:CGFloat = rect.origin.y;
        y += rect.size.height/2;
        var max:CGFloat = 0;
        for dic : Dictionary<String,AnyObject> in _params {
            var value = CGFloat(dic["value"] as! Float)
            max += value;
        }
        
        
        var start_angle:CGFloat = -CGFloat(M_PI / 2);
        var end_angle:CGFloat    = 0;
        var radius:CGFloat  = x - 10.0;
        for dic : Dictionary<String,AnyObject> in _params {
            var value = CGFloat(dic["value"] as! Float)
            end_angle = start_angle + CGFloat(M_PI*2) * (value/max);
            if(end_angle > _end_angle) {
                end_angle = _end_angle;
            }
            var color:UIColor = dic["color"] as! UIColor

            CGContextMoveToPoint(context, x, y);
            CGContextAddArc(context, x, y, radius,  start_angle, end_angle, 0);
            CGContextAddArc(context, x, y, radius/2,  end_angle, start_angle, 1);
            CGContextSetFillColor(context, CGColorGetComponents(color.CGColor));
            CGContextClosePath(context);
            CGContextFillPath(context);
            start_angle = end_angle;
        }

    }

}
