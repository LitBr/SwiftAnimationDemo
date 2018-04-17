//
//  SnowView.swift
//  Flight
//
//  Created by 萧奇 on 2018/4/16.
//  Copyright © 2018年 萧奇. All rights reserved.
//

import UIKit

class SnowView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        // CAEmitterLayer就像大炮，决定了(1)哪里发射(2)大炮有多大
        // CAEmitterCell就像是炮弹，觉得了(1)初速度(2)加速度(3)炮弹类型(4)发射后的角度
        let emitter = layer as! CAEmitterLayer
        emitter.emitterPosition = CGPoint(x: bounds.size.width / 2, y: 0)
        emitter.emitterSize = bounds.size
        emitter.emitterShape = kCAEmitterLayerRectangle
        // kCAEmitterLayerPoint 点
        // kCAEmitterLayerLine 线
        // kCAEmitterLayerRectangle 矩形
        
        let emitterCell = CAEmitterCell() // 粒子模型
        emitterCell.contents = UIImage(named: "flake.png")!.cgImage
        emitterCell.birthRate = 200 // 产生频率
        emitterCell.lifetime = 4 // 生命周期
        emitterCell.color = UIColor.white.cgColor
        emitterCell.redRange = 0.0
        emitterCell.blueRange = 0.1
        emitterCell.greenRange = 0.0
        emitterCell.velocity = 10 // 运动速度
        emitterCell.velocityRange = 350 // 运动速度浮动值
        emitterCell.emissionRange = CGFloat(Double.pi / 2) // 抛洒角度的浮动值
        emitterCell.emissionLongitude = CGFloat(-Double.pi) // x-y平面的发射方向
        emitterCell.yAcceleration = 70 // 粒子y方向的加速度分量
        emitterCell.xAcceleration = 0
        emitterCell.scale = 0.33
        emitterCell.scaleRange = 1.25
        emitterCell.scaleSpeed = -0.25
        emitterCell.alphaRange = 0.5
        emitterCell.alphaSpeed = -0.15
        emitter.emitterCells = [emitterCell]
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class var layerClass: AnyClass {
        return CAEmitterLayer.self
    }
}
