//
//  ViewController.swift
//  DemoBackgroundProblem
//
//  Created by saffron on 23/02/18.
//  Copyright © 2018 saffron. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    @IBOutlet weak var imageBackground:UIImageView!
    @IBOutlet weak var videoBackground:UIView!
     @IBOutlet weak var mainView:UIView!
    var player = AVPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        addPlayer()
        designFrameForMainView(view: mainView,spacingDifference: 10, sizeDifference: 20, numberOfFrames: 3,color:UIColor.black)
        drawBarLines(isVerticalLine: true, numberOfLines: 4, view: mainView,lineWidth:10)
        drawBarLines(isVerticalLine: false, numberOfLines: 2, view: mainView,lineWidth:10)
        // Do any additional setup after loading the view, typically from a nib.
    }
    func addPlayer(){
        let moviePath = Bundle.main.path(forResource: "VideoOne", ofType: "mp4")
        if let path = moviePath {
            let url = NSURL.fileURL(withPath: path)
            player = AVPlayer(url: url)
            
            // create a video layer for the player
            let layer: AVPlayerLayer = AVPlayerLayer(player: player)
            
            // make the layer the same size as the container view
            layer.frame = videoBackground.bounds
            
            // make the video fill the layer as much as possible while keeping its aspect size
            layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            player.play()
            // add the layer to the container view
            videoBackground.layer.addSublayer(layer)
        }
    }
    func drawBarLines(isVerticalLine:Bool,numberOfLines:Int,view:UIView,lineWidth:CGFloat) {
        var dimension = view.frame.size.height
        if isVerticalLine {
            dimension = view.frame.size.width
        }
        let position = dimension / CGFloat(numberOfLines)
        for index in 1 ... numberOfLines - 1 {
            let updatePosition  = position * CGFloat(index)
            if isVerticalLine {
                view.layer.addSublayer(DesignShape.addLine(fromPoint: CGPoint(x: updatePosition, y: 0), toPoint: CGPoint(x:updatePosition, y: view.frame.size.height), color: UIColor.gray,lineWidth :lineWidth))
            } else {
                view.layer.addSublayer(DesignShape.addLine(fromPoint: CGPoint(x: 0, y: updatePosition), toPoint: CGPoint(x:view.frame.size.width, y: updatePosition), color: UIColor.gray,lineWidth :lineWidth))
            }
        }
    }
    func designFrameForMainView(view:UIView,spacingDifference:CGFloat,sizeDifference:CGFloat, numberOfFrames:Int, color:UIColor) {
        var backgroundFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
        for index in 0...numberOfFrames {
            view.layer.addSublayer(DesignShape.addRectangle(point: CGPoint(x: view.bounds.origin.x + spacingDifference * CGFloat(index), y: view.bounds.origin.y + spacingDifference * CGFloat(index)),width: Int(view.bounds.size.width - sizeDifference * CGFloat(index)),height: Int(view.bounds.size.height - sizeDifference * CGFloat(index)),color:color, fillColor: UIColor.clear))
            backgroundFrame = CGRect(x: view.bounds.origin.x + spacingDifference * CGFloat(index), y: view.bounds.origin.y + spacingDifference * CGFloat(index), width: CGFloat(view.bounds.size.width - 20 * CGFloat(index)), height: CGFloat(view.bounds.size.height - 20 * CGFloat(index) ))
        }
        addViewAfterDesign(frame: backgroundFrame, parentView: view)
    }
    func addViewAfterDesign(frame:CGRect,parentView:UIView) {
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor.white
        parentView.addSubview(view)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
class DesignShape {
    
    class  func addRectangle(point: CGPoint,width:Int,height:Int,color:UIColor = ColorPattern.purple.color,fillColor:UIColor) -> CAShapeLayer {
        let layer = CAShapeLayer()
        let xCoord = point.x
        let yCoord = point.y
        let path = UIBezierPath(roundedRect: CGRect(x: Int(xCoord), y: Int(yCoord), width: width, height: height), cornerRadius: 0)
        layer.fillColor = fillColor.cgColor
        layer.strokeColor = color.cgColor
        //        layer.strokeStart = 0
        //        layer.strokeEnd =  0.6
        layer.borderWidth = 4
        layer.path = path.cgPath
        return layer
    }
    class func addLine(fromPoint start: CGPoint, toPoint end:CGPoint, color:UIColor,lineWidth :CGFloat = 1)  -> CAShapeLayer {
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: start)
        linePath.addLine(to: end)
        line.path = linePath.cgPath
        line.strokeColor = color.cgColor
        line.lineWidth = lineWidth
        line.lineJoin = kCALineJoinRound
        return line
        
        //self.view.layer.addSublayer(line)
    }
}
enum ColorPattern {
    case white
    case blue
    case black
    case lightGray
    case gray
    case purple
    var color: UIColor {
        switch self {
        case .white: return UIColor.white
        case .blue: return UIColor.blue
        case .black: return UIColor.black
        case .lightGray: return UIColor.lightGray
        case .gray: return UIColor.gray
        case .purple:return UIColor(red: 45/255.0, green: 21/255.0, blue: 143/255.0, alpha: 1.0)
        }
    }
}
