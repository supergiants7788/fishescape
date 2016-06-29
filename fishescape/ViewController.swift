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
    

    @IBOutlet weak var mainfish: UIImageView!
    let motionManager = CMMotionManager()
//    @IBOutlet var littlefish: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height
        
        motionManager.deviceMotionUpdateInterval = 1.0/60.0
        motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler:
            {
                (deviceMotion:CMDeviceMotion?,error:NSError?) in
                let fromX = self.mainfish.center.x
                let fromY = self.mainfish.center.y
                
        //画面外に出さない
                
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

