//
//  YSEmitterView.swift
//  YSEmitterView
//
//  Created by 李泓松 on 2017/5/12.
//  Copyright © 2017年 yoser. All rights reserved.
//

import UIKit

struct AnimateItem {
    var fromPoint:CGPoint
    var toPoint:CGPoint
    var animate:Piexl
    var duration:TimeInterval
    
    func start() -> Void {
        
        UIView.animate(withDuration: duration) { 
            
        }
    }
}

struct Piexl {
    var point:CGPoint
    var color:UIColor

    init(_ point:CGPoint, color:UIColor) {
        self.point = point
        self.color = color
    }
}

class YSEmitterView: UIView {
    
    init(_ image:UIImage) {
        
        self.sourceImage = image
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var burstPoint:CGPoint?
    
//    private var showLayer:CA
    
    var sourceImage:UIImage? {
        didSet {
            if let sourceImage = sourceImage {
                piexlData = YSEmitterView.getPiexlData(sourceImage)
            }
        }
    }
    
    final func startEmitter() -> Void {
        guard burstPoint != nil && sourceImage != nil else {
            return
        }
        
        for piexl in piexlData! {
            let toRect = CGRect(x: CGFloat(piexl.point.x) / CGFloat(sourceImage!.size.width)  * CGFloat(bounds.width),
                                y: CGFloat(piexl.point.y) / CGFloat(sourceImage!.size.height) * CGFloat(bounds.height),
                                width: 1.0,
                                height: 1.0)
            
            let fromRect = CGRect(origin: burstPoint!, size: CGSize(width: 1, height: 1))
            
            let piexlView:UIView = {
                let piexlView = UIView()
                piexlView.frame = fromRect
                piexlView.backgroundColor = piexl.color
                return piexlView
            }()
            self.addSubview(piexlView)
            
            UIView.animate(withDuration: 3.0, animations: { 
                piexlView.frame = toRect
            })
        }
    }
    
    
    
    private var piexlData:Array<Piexl>?
    
    private static func getPiexlData(_ image:UIImage) -> Array<Piexl>{
        
        let width = Int(image.size.width)
        let height = Int(image.size.height)
        let widthRowBytes = width * 4
        
        let rawData:UnsafePointer<CUnsignedChar>? = UIImage.getDataWithImage(image)
        
        var tempPiexlArray:Array<Piexl> = []
        
        if let rawData = rawData {
            
            // 对于大图片必须使用降采样的方式。。不然炸了
            
            let heightRange = 0..<height
            let cutHeightRange = heightRange.filter{return $0 % 16 == 0}
            let widthRange = 0..<width
            let cutWidthRange = widthRange.filter{return $0 % 16 == 0}
            
            for i in cutHeightRange{
                for j in cutWidthRange{
                    
                    let point = CGPoint(x: j , y: i)
                    
                    let R = CGFloat(rawData[j * 4 + i * widthRowBytes + 0]) / 255.0
                    let G = CGFloat(rawData[j * 4 + i * widthRowBytes + 1]) / 255.0
                    let B = CGFloat(rawData[j * 4 + i * widthRowBytes + 2]) / 255.0
                    let A = CGFloat(rawData[j * 4 + i * widthRowBytes + 3]) / 255.0
                    
                    let color = UIColor(red: R, green: G, blue: B, alpha: A)
                    
                    let piexl:Piexl? = Piexl(point, color: color)
                    if let piexl = piexl {
                        tempPiexlArray.append(piexl)
                    }
                }
            }
        }
        return tempPiexlArray
    }

}
