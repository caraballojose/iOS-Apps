//
//  DrawingImageView.swift
//  MathTraining
//
//  Created by Jose Caraballo on 18/2/21.
//

import UIKit

class DrawingImageView: UIImageView {

    weak var delegate : ViewController?
    
    var currentTouchPosition : CGPoint?
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
     */
    /*
    override func draw(_ rect: CGRect) {
        //Drawing code
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
    }
    */
    
    func draw (from start: CGPoint, to end: CGPoint){
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        
        self.image = renderer.image(actions: { (ctx) in
            self.image?.draw(in: self.bounds)
            
            //definit los parametros de dibujo
            UIColor.white.setStroke()
            ctx.cgContext.setLineCap(.round)
            ctx.cgContext.setLineWidth(10)
            
            //se dibuja una linea desde start hasta end
            ctx.cgContext.move(to: start)
            ctx.cgContext.addLine(to: end)
            ctx.cgContext.strokePath()
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesBegan(touches, with: event)
        self.currentTouchPosition = touches.first?.location(in: self)
        
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        super.touchesMoved(touches, with: event)
        guard let newTouchPoint = touches.first?.location(in: self) else {
            return
        }
        
        guard let previousTouchPoint = self.currentTouchPosition else {
            return
        }
        
        draw(from: previousTouchPoint, to: newTouchPoint)
        currentTouchPosition = newTouchPoint
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        currentTouchPosition = nil
        perform(#selector(numbreDrawOnScreen), with: nil, afterDelay: 0.6)
    }
    
    @objc func numbreDrawOnScreen() {
        
        guard let image = self.image else {
            return
        }
        
        let drawRect = CGRect(x: 0, y: 0, width: 28, height: 28)
        
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        
        let renderer  = UIGraphicsImageRenderer(bounds: drawRect, format: format)
        
        let imagewithWhiteBackground = renderer.image { (ctx) in
            UIColor.white.setFill()
            ctx.fill(bounds)
            image.draw(in: drawRect)
        }
        
        //convirtiendo una image de CG a CI
        let ciimage = CIImage(cgImage: imagewithWhiteBackground.cgImage!)
        
        if let filter = CIFilter(name: "CIColorInvert") {
            // define la CIImage  a ser filtrado
            filter.setValue(ciimage, forKey: kCIInputImageKey)
        
            let context = CIContext(options: nil)
            
            if let outputImage = filter.outputImage{
                if let imageRef = context.createCGImage(outputImage, from: ciimage.extent){
                    let resultImage = UIImage(cgImage: imageRef)
                    
                    self.delegate?.numberDraw(resultImage)
                    
                }
            }
        }      
        
        
    }

}
