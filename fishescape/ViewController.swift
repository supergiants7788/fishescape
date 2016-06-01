//
//  ViewController.swift
//  fishescape
//
//  Created by 新井山詠斗 on 2016/05/18.
//  Copyright © 2016年 新井山詠斗. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    @IBOutlet weak var little: UIImageView!
    let motionManager = CMMotionManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height
        
        motionManager.deviceMotionUpdateInterval = 1.0/60.0
        motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler:
            {
                (deviceMotion:CMDeviceMotion?,error:NSError?) in
                let fromX = self.little.center.x
                let fromY = self.little.center.y
                
                if (fromX < 0){
                    let xAngle = 180 * deviceMotion!.attitude.roll / M_PI
                    let yAngle = 180 * deviceMotion!.attitude.pitch / M_PI
                    let lenX = CGFloat(xAngle)
                    if lenX > 0{
                        let lenY = CGFloat(yAngle)
                        var toX = fromX + lenX
                        var toY = fromY + lenY
                        self.little.center = CGPointMake(toX, toY)
                    }
                }else{
                    let xAngle = 180 * deviceMotion!.attitude.roll / M_PI
                    let yAngle = 180 * deviceMotion!.attitude.pitch / M_PI
                    let lenX = CGFloat(xAngle)
                    let lenY = CGFloat(yAngle)
                    
                    var toX = fromX + lenX
                    var toY = fromY + lenY
                    self.little.center = CGPointMake(toX, toY)
                }
            
                if (fromX > width){
                    let xAngle = 180 * deviceMotion!.attitude.roll / M_PI
                    let yAngle = 180 * deviceMotion!.attitude.pitch / M_PI
                    let lenX = CGFloat(xAngle)
                    if lenX < 0{
                        let lenY = CGFloat(yAngle)
                        var toX = fromX + lenX
                        var toY = fromY + lenY
                        self.little.center = CGPointMake(toX, toY)
                    }
                }
                
            }
        )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

