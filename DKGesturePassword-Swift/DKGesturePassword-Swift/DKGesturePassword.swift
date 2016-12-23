//
//  DKGesturePassword.swift
//  DKGesturePassword-Swift
//
//  Created by NSLog on 16/7/18.
//  Copyright © 2016年 DK-Coder. All rights reserved.
//

import UIKit

typealias gestureCompleteBlock = (String) -> Void
/**
*  列数，每行有几个按钮
*/
let COLS_NUMBER_PER_ROW: Int = 3

/**
*  默认的按钮宽度
*/
let DEFAULT_BUTTON_WIDTH: CGFloat = 64.0

/**
*  默认的线条宽度
*/
let DEFAULT_LINE_WIDTH: CGFloat = 10.0

class DKGesturePassword: UIView {
    
    var buttonWidth: CGFloat = DEFAULT_BUTTON_WIDTH
    var lineWidth: CGFloat = DEFAULT_LINE_WIDTH
    var lineColor: UIColor = UIColor.cyan

    private var _buttonNumber: Int = 0/** 按钮数量*/
    
    private var marginForX: CGFloat = 0.0/** 每个按钮在X轴上的间距（包括按钮和边界的间距和按钮之间的间距）*/
    private var marginForY: CGFloat = 0.0/** 每个按钮在Y轴上的间距（只是按钮和边界的间距，Y轴上按钮和按钮之间的间距使用marginForX的值*/
    
    private var _arrayButtons = Array<UIButton>()/** 存放按钮的数组*/
    private var _arraySelectedButtons = Array<UIButton>()/** 存放手指划过的按钮*/
    private var _currentLocation: CGPoint = CGPoint(x: 0.0, y: 0.0)/** 手指现在所在的位置*/
    
    private var completeBlock: gestureCompleteBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, buttonNumber: Int) {
        self.init(frame: frame)
        
        _buttonNumber = buttonNumber
        sharedInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func sharedInit() {
        
        assert(_buttonNumber % 3 == 0, "按钮数量必须为3的整数倍")
        _buttonNumber = _buttonNumber != 0 ? _buttonNumber : 9
        
        let panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(gestureDetected))
        addGestureRecognizer(panGesture)
        
        for i in 0 ..< _buttonNumber {
            let button = UIButton.init()
            button.tag = i
            button.isUserInteractionEnabled = false
            button.setBackgroundImage(UIImage(named: "Resources.bundle/Node-Normal"), for: .normal)
            button.setBackgroundImage(UIImage(named: "Resources.bundle/Node-Highlighted"), for: .highlighted)

            addSubview(button)
            _arrayButtons.append(button)
        }
        
        backgroundColor = UIColor.clear
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        let rowNumber: Int = _buttonNumber / COLS_NUMBER_PER_ROW
        marginForX = (frame.width - CGFloat(COLS_NUMBER_PER_ROW) * buttonWidth) / (CGFloat(COLS_NUMBER_PER_ROW) + 1)
        marginForY = (frame.height - CGFloat(rowNumber) * buttonWidth - (CGFloat(rowNumber) - 1.0) * marginForX) / 2.0
        for btn in _arrayButtons {
            btn.frame = CGRect(x: 0.0, y: 0.0, width: buttonWidth, height: buttonWidth)
            btn.layer.cornerRadius = buttonWidth / 2.0
            btn.center = CGPoint(x: buttonX(btn: btn), y: buttonY(btn: btn))
        }
    }
    
    func gestureDrawComplete(block: @escaping gestureCompleteBlock) {
        completeBlock = block
    }
    
    private func buttonX(btn: UIButton) -> CGFloat {
        
        var x: CGFloat = 0.0
        let tag = btn.tag
        // 计算该按钮在哪一列
        let whichCol: Int = tag % COLS_NUMBER_PER_ROW
        x = marginForX * CGFloat(whichCol + 1) + (CGFloat(whichCol) + 0.5) * buttonWidth
        
        return x
    }
    
    private func buttonY(btn: UIButton) -> CGFloat {
        
        var y: CGFloat = 0.0
        let tag = btn.tag
        // 计算该按钮在哪一行
        let whichRow: Int = tag / COLS_NUMBER_PER_ROW
        y = marginForY + marginForX * CGFloat(whichRow) + (CGFloat(whichRow) + 0.5) * buttonWidth
        
        return y
    }
    
    @objc private func gestureDetected(gestureRegcognizer: UIPanGestureRecognizer) {
        
        let location = gestureRegcognizer.location(in: self)
        _currentLocation = location
        
        for btn in _arrayButtons {
            if btn.frame.contains(location) && !btn.isHighlighted {
                btn.isHighlighted = true
                _arraySelectedButtons.append(btn)
            }
        }
        
        if gestureRegcognizer.state == .changed {
            
        } else if gestureRegcognizer.state == .ended {
            var userInputPassword: String = String()
            for btn in _arraySelectedButtons {
                btn.isHighlighted = false
                userInputPassword += String(btn.tag)
            }
            _arraySelectedButtons.removeAll()
            completeBlock!(userInputPassword)
        }
        
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        
        if _arraySelectedButtons.count > 0 {
            let path: UIBezierPath = UIBezierPath.init()
            for i in 0 ..< _arraySelectedButtons.count {
                let btn: UIButton = _arraySelectedButtons[i]
                if i == 0 {
                    path.move(to: btn.center)
                } else {
                    path.addLine(to: btn.center)
                }
            }
            
            path.addLine(to: _currentLocation)
            path.lineWidth = lineWidth
            path.lineJoinStyle = .round
            lineColor.set()
            path.stroke()
        }
    }
}
