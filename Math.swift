//
//  Math.swift
//  BatInvasion
//
//  Created by Aleksander Makedonski on 3/10/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//


import Foundation
import SpriteKit


typealias NumberUnit = Double

func DegreesToRadians(angleInDegrees: NumberUnit) -> NumberUnit{
    return angleInDegrees*(M_PI/180.0)
}

func RadiansToDegrees(angleInRadians: NumberUnit) -> NumberUnit{
    return angleInRadians*(180.0/M_PI)
}

func Smooth(startPoint: NumberUnit, endPoint: NumberUnit, percentToMove: NumberUnit) -> NumberUnit{
    return (startPoint*(1-percentToMove) + endPoint*percentToMove)
}

func AngleBetweenPoints(targetPosition: CGPoint, currentPosition: CGPoint) -> NumberUnit{
    let deltaX = targetPosition.x - currentPosition.x
    let deltaY = targetPosition.y - currentPosition.y
    
    return NumberUnit((atan2(deltaY, deltaX))) - DegreesToRadians(angleInDegrees: 90)
}

func DistanceBetweenPoints(firstPoint: CGPoint, secondPoint: CGPoint) -> NumberUnit{
    return NumberUnit(hypot(secondPoint.x - firstPoint.x, secondPoint.y - firstPoint.y))
}

func RandomIntegerBetween(min: Int, max: Int) -> Int{
    return Int(UInt32(min) + arc4random_uniform(UInt32(max-min+1)))
}

func RandomFloatRange(min: CGFloat, max: CGFloat) -> CGFloat{
    return CGFloat(Float(arc4random()/0xFFFFFFFF))*(max-min) + min
}

func RandomizeSign(coordinateValue: inout Int){
    
    let coinFlip = Int(arc4random_uniform(2))
    
    coordinateValue = coinFlip == 1 ? -coordinateValue: coordinateValue
}


