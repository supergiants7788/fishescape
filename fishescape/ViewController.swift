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
    
    
    var timer: NSTimer!
    var speedX: CGFloat = 0.1
    var speedY: CGFloat = 0.5
    var nowpointX: CGFloat = 0
    var nowpointY: CGFloat = 0
    var startpointX: CGFloat = 0
    var startpointY: CGFloat = 0
    
    var speedX2: CGFloat = 0.1
    var speedY2: CGFloat = 0.5
    var nowpointX2: CGFloat = 0
    var nowpointY2: CGFloat = 0
    var startpointX2: CGFloat = 0
    var startpointY2: CGFloat = 0
    
    var bigstartpoint: CGFloat = 0
    var bigfinishpoint: CGFloat = 0
    
    var score: Int = 0
     var timer2: NSTimer!
    
    @IBOutlet weak var mainfish: UIImageView!
    let motionManager = CMMotionManager()
    @IBOutlet var littlefish: UIImageView!
    @IBOutlet var bigfish: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        timer2 = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(update2), userInfo: nil, repeats: true)
        
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height
        
        motionManager.deviceMotionUpdateInterval = 1.0/60.0
        motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler:
            {
                (deviceMotion:CMDeviceMotion?,error:NSError?) in
                let fromX = self.mainfish.center.x
                let fromY = self.mainfish.center.y
                
                let xAngle = 180 * deviceMotion!.attitude.roll / M_PI//x方向の傾き具合
                let yAngle = 180 * deviceMotion!.attitude.pitch / M_PI//y方向の傾き具合
                let lenX = CGFloat(xAngle)
                let lenY = CGFloat(yAngle)
                
                if lenX > 0 {
                    self.mainfish.image = UIImage(named:"iwasi のコピー.png")
                }else{
                    self.mainfish.image = UIImage(named: "iwasi.png")
                }
                
                
                if (fromX < 15 ){
                    //左端に来てる時
                    let xAngle = 180 * deviceMotion!.attitude.roll / M_PI//x方向の傾き具合
                    let yAngle = 180 * deviceMotion!.attitude.pitch / M_PI//y方向の傾き具合
                    let lenX = CGFloat(xAngle)
                    
                    if lenX > 0{
                        let lenY = CGFloat(yAngle)
                        let toX = fromX + lenX
                        let toY = fromY + lenY
                        self.mainfish.center = CGPointMake(toX, toY)
                    }
                    
                }else if(fromX > width - 15){
                    //右に来た時
                    let xAngle = 180 * deviceMotion!.attitude.roll / M_PI
                    let yAngle = 180 * deviceMotion!.attitude.pitch / M_PI
                    let lenX = CGFloat(xAngle)
                    
                    if lenX < 0 {
                        let lenY = CGFloat(yAngle)
                        let toX = fromX + lenX
                        let toY = fromY + lenY
                        self.mainfish.center = CGPointMake(toX, toY)
                    }
                    
                }else if(fromY < 15){
                    //上に来てる時
                    let xAngle = 180 * deviceMotion!.attitude.roll / M_PI
                    let yAngle = 180 * deviceMotion!.attitude.pitch / M_PI
                    let lenY = CGFloat(yAngle)
                    
                    if lenY > 0 {
                        let lenX = CGFloat(xAngle)
                        let toX = fromX + lenX
                        let toY = fromY + lenY
                        self.mainfish.center = CGPointMake(toX, toY)
                    }
                    
                }else if(fromY > height - 15){
                    //下に来てる時
                    let xAngle = 180 * deviceMotion!.attitude.roll / M_PI
                    let yAngle = 180 * deviceMotion!.attitude.pitch / M_PI
                    let lenY = CGFloat(yAngle)
                    
                    if lenY < 0 {
                        let lenX = CGFloat(xAngle)
                        let toX = fromX + lenX
                        let toY = fromY + lenY
                        self.mainfish.center = CGPointMake(toX, toY)
                    }
                    
                }else{
                    //端っこじゃない時
                    let xAngle = 180 * deviceMotion!.attitude.roll / M_PI
                    let yAngle = 180 * deviceMotion!.attitude.pitch / M_PI
                    let lenX = CGFloat(xAngle)
                    let lenY = CGFloat(yAngle)
                    
                    let toX = fromX + lenX
                    let toY = fromY + lenY
                    self.mainfish.center = CGPointMake(toX, toY)
                }
            }
        )
    }
    
    func update() {
        nowpointX = nowpointX + speedX + startpointX
        nowpointY = nowpointY + speedY + startpointY
        
            littlefish.center = CGPointMake(nowpointX, nowpointY)
            if (nowpointX > UIScreen.mainScreen().bounds.size.width + 40 || nowpointY > UIScreen.mainScreen().bounds.size.height + 40 || nowpointX < -40 || nowpointY < -40){
                nowpointX = 0
                nowpointY = 0
                random()
                littlefish.image = UIImage (named: "iwasi のコピー.png")
            }
            if nowpointX == speedX || speedX == startpointX {
                random()
            }
            if nowpointY == speedY || speedY == startpointY {
                random()
            }
            
            if CGRectIntersectsRect(mainfish.frame, littlefish.frame){
                littlefish.image = nil
                littlefish.setNeedsDisplay()
                littlefish.layoutIfNeeded()
                score = score + 1
        }
    }
    
    func update2() {        
        nowpointX2 = nowpointX2 + speedX2 + startpointX2
        nowpointY2 = nowpointY2 + speedY2 + startpointY2
        
        bigfish.center = CGPointMake(nowpointX2, nowpointY2)
        if (nowpointX2 > UIScreen.mainScreen().bounds.size.width + 40 || nowpointY2 > UIScreen.mainScreen().bounds.size.height + 40 || nowpointX2 < -40 || nowpointY2 < -40){
            nowpointX2 = 0
            nowpointY2 = 0
            random2()
        }
        if nowpointX2 == speedX2 || speedX2 == startpointX2 {
            random2()
        }
        if nowpointY2 == speedY2 || speedY2 == startpointY2 {
            random2()
        }
    }
    
    func random() {
        speedX = CGFloat(rand() % 2)
        speedY = CGFloat(rand() % 3)
        startpointX = CGFloat(rand() % 2)
        startpointY = CGFloat(rand() % 2)
        nowpointX = CGFloat(rand() % 2)
        nowpointY = CGFloat(rand() % 3)
    }
    
    func random2() {
        speedX2 = CGFloat(rand() % 2)
        speedY2 = CGFloat(rand() % 3)
        startpointX2 = CGFloat(rand() % 2)
        startpointY2 = CGFloat(rand() % 2)
        nowpointX2 = CGFloat(rand() % 2)
        nowpointY2 = CGFloat(rand() % 3)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}