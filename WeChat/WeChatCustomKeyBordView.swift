//
//  WeChatCustomKeyBord.swift
//  WeChat
//
//  Created by Smile on 16/1/27.
//  Copyright © 2016年 smile.love.tao@gmail.com. All rights reserved.
//

import UIKit

//自定义聊天键盘
class WeChatCustomKeyBordView: UIView,UITextViewDelegate {

    var bgColor:UIColor!
    var isLayedOut:Bool = false
    
    var textView:PlaceholderTextView!//多行输入
    let topOrBottomPadding:CGFloat = 7//上边空白
    let leftPadding:CGFloat = 10//左边空白
    let kAnimationDuration:NSTimeInterval = 0.2//动画时间
    var biaoQing:UIImageView!
    let biaoQingPadding:CGFloat = 15
    var isBiaoQingDialogShow:Bool = false
    var biaoQingDialog:WeChatEmojiDialogView?
    var defaultHeight:CGFloat = 45
    let biaoQingHeight:CGFloat = 200
    
    init(){
        let frame = CGRectMake(0, UIScreen.mainScreen().bounds.height - defaultHeight, UIScreen.mainScreen().bounds.width, defaultHeight)
        super.init(frame: frame)
        
        //定义通知,获取键盘高度
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillAppear:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillDisappear:", name: UIKeyboardWillHideNotification, object: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARKS: 键盘弹起事件
    func keyboardWillAppear(notification: NSNotification) {
        let keyboardInfo = notification.userInfo![UIKeyboardFrameEndUserInfoKey]
        let keyboardHeight:CGFloat = (keyboardInfo?.CGRectValue.size.height)!
        
        /*
        //键盘偏移量
        let userInfo = notification.userInfo!
        let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey]?.floatValue
        let beginKeyboardRect = userInfo[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue
        let endKeyboardRect = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue
        let yOffset = endKeyboardRect!.origin.y - beginKeyboardRect!.origin.y*/

        animation(self.frame.origin.x, y: UIScreen.mainScreen().bounds.height - self.frame.height - keyboardHeight)
    }
    
    //MARKS: 键盘落下事件
    func keyboardWillDisappear(notification:NSNotification){
        animation(self.frame.origin.x, y: UIScreen.mainScreen().bounds.height - self.frame.height)
    }
    
    //MARKS: 导航行返回
    func navigationBackClick(){
        self.frame.origin = CGPointMake(self.frame.origin.x,UIScreen.mainScreen().bounds.height - self.frame.height)
        self.textView.resignFirstResponder()
    }
    
    //MARKS: TextView动画
    func animation(x:CGFloat,y:CGFloat){
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(kAnimationDuration)
        self.frame.origin = CGPointMake(x, y)
        UIView.commitAnimations()
    }
    
    func animation(rect:CGRect){
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(kAnimationDuration)
        self.frame = rect
        UIView.commitAnimations()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !isLayedOut {
            self.backgroundColor = UIColor.whiteColor()
            createLineOnTop()
            createTextView()
            createBiaoQing()
            self.textView.resignFirstResponder()
            self.isLayedOut = true
        }
    }
    
    //MARKS: 创建输入框
    func createTextView(){
        let height:CGFloat = self.frame.height - topOrBottomPadding * 2
        let width = UIScreen.mainScreen().bounds.width - leftPadding - biaoQingPadding * 2 - height
        let frame = CGRectMake(leftPadding, topOrBottomPadding,width, height)
        self.textView = PlaceholderTextView(frame: frame,placeholder: "评论",color: nil,font: nil)
        self.textView.layer.borderWidth = 0.5  //边框粗细
        self.textView.layer.borderColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1).CGColor //边框颜色
        self.textView.editable = true//是否可编辑
        self.textView.selectable = true//是否可选
        self.textView.dataDetectorTypes = .None//给文字中的电话号码和网址自动加链接,这里不需要添加
        self.textView.returnKeyType = .Send
        self.textView.font = UIFont(name: "AlNile", size: 15)
        //设置圆角
        self.textView.layer.cornerRadius = 4
        self.textView.layer.masksToBounds = true
        self.textView.delegate = self
        self.addSubview(textView)
    }
    
    //MARKS: 创建输入框边上的表情
    func createBiaoQing(){
        self.biaoQing = UIImageView()
        self.biaoQing.frame = CGRectMake(self.textView.frame.origin.x + self.textView.frame.width + self.biaoQingPadding, self.textView.frame.origin.y, self.textView.frame.height, self.textView.frame.height)
        self.biaoQing.image = UIImage(named: "rightImg")
        self.biaoQing.userInteractionEnabled = true
        self.addSubview(self.biaoQing)
        self.bringSubviewToFront(self.biaoQing)
        
        self.biaoQing.addGestureRecognizer(WeChatUITapGestureRecognizer(target: self, action: "createBiaoQing:"))
    }
    
    //MARKS: 表情点击事件
    func createBiaoQing(gestrue: WeChatUITapGestureRecognizer){
        if !isBiaoQingDialogShow {
            self.biaoQing.image = UIImage(named: "rightImgChange")
            isBiaoQingDialogShow = true
            self.textView.resignFirstResponder()
            //添加表情对话框
            biaoQingDialog = WeChatEmojiDialogView(frame: CGRectMake(0, self.textView.frame.origin.y + self.topOrBottomPadding * 2 , UIScreen.mainScreen().bounds.width, biaoQingHeight))
            self.addSubview(biaoQingDialog!)
            self.bringSubviewToFront(biaoQingDialog!)
            
            animation(CGRectMake(self.frame.origin.x, UIScreen.mainScreen().bounds.height - self.defaultHeight - (biaoQingDialog?.frame.height)!, UIScreen.mainScreen().bounds.width, self.defaultHeight + (biaoQingDialog?.frame.height)!))
        } else {
            self.biaoQing.image = UIImage(named: "rightImg")
            isBiaoQingDialogShow = false
            self.textView.becomeFirstResponder()
        }
    }
    
    //MARKS: 顶部画线
    func createLineOnTop(){
        let shape = WeChatDrawView().drawLine(beginPointX: 0, beginPointY: 0, endPointX: self.frame.width, endPointY: 0,color:UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1))
        shape.lineWidth = 0.2
        self.layer.addSublayer(shape)
    }
    
    //MARKS: 自定义选择内容后的菜单
    func addSelectCustomMenu(){
        
    }
    
    //MARSK: 去掉回车
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            self.textView.resignFirstResponder()
            return false
        }
        
        return true
    }
    
    //触摸空白处隐藏键盘
    
    //MARKS: 当空字符的时候重绘placeholder
    func textViewDidChange(textView: UITextView) {
        if textView.text.isEmpty {
            //self.textView.resetCur(textView.caretRectForPosition(textView.selectedTextRange!.start))
            self.textView.removeFromSuperview()
            createTextView()
            self.textView.becomeFirstResponder()
        }
    }
}

//表情对话框
class WeChatEmojiDialogView:UIView,UIScrollViewDelegate{

    var isLayedOut:Bool = false
    var dialogLeftPadding:CGFloat = 25
    var dialogTopPadding:CGFloat = 15
    var emojiWidth:CGFloat = 30
    var emojiHeight:CGFloat = 30
    var emoji:Emoji!
    var scrollView:UIScrollView!
    var pageControl:UIPageControl!
    var pageCount:Int = 0
    let pageControlHeight:CGFloat = 10
    let onePageCount:Int = 23
    let pageControlWidth:CGFloat = 40
    let bottomHeight:CGFloat = 30
    let bottomTopHeight:CGFloat = 10

    override init(frame:CGRect){
        super.init(frame: frame)
        self.emoji = Emoji()
        //获取页数,向上取整数,如果直接用/会截断取整,需要转成Float
        self.pageCount = Int(ceilf(Float(self.emoji.emojiArray.count) / 23.0))
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !isLayedOut {
            createScrollView()
            isLayedOut = true
        }
    }
    
    func createScrollView(){
        self.scrollView = UIScrollView()
        self.scrollView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.width, self.frame.height - self.bottomHeight)
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.scrollsToTop = false
        self.scrollView.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 244/255, alpha: 0.2)
        
        createDialog()
        self.addSubview(self.scrollView)
        createPageControl()
    }
    
    //MARKS: 创建PageControl
    func createPageControl(){
        self.pageControl = UIPageControl()
        self.pageControl.frame = CGRectMake((self.frame.width - pageControlWidth) / 2, self.frame.height - bottomHeight - pageControlHeight - bottomTopHeight, pageControlWidth, pageControlHeight)
        self.pageControl.frame = CGRectZero
        self.pageControl.numberOfPages = self.pageCount
        self.addSubview(self.pageControl)
    }
    
    func createDialog(){
        //计算padding
        let leftPadding:CGFloat = (self.frame.width - emojiWidth * 8 - dialogLeftPadding * 2) / 7
        let topPadding:CGFloat = (self.scrollView.frame.height - emojiHeight * 3 - dialogTopPadding * 2 - self.bottomTopHeight - self.pageControlHeight) / 2
        var originX:CGFloat = self.dialogLeftPadding
        var originY:CGFloat = self.dialogTopPadding
        let totalCount:Int = emoji.emojiArray.count
        
        var x:CGFloat = 0
        for(var i = 0;i < pageCount;i++){
            let view = UIView()
            view.frame = CGRectMake(x, 0, self.frame.width, self.frame.height - pageControlHeight)
            for(var j = 0;j < totalCount - 1;j++){
                if i * onePageCount + j > (totalCount - 1) {
                    break
                }
                
                let weChatEmoji = emoji.emojiArray[i * onePageCount + j]
                
                let imageView = UIImageView()
                if j % 8 == 0  && j != 0{
                    originY += (emojiHeight + topPadding)
                    originX =  self.dialogLeftPadding
                }
                
                if j != 0 && j % 8 != 0{
                    originX += (emojiWidth + leftPadding)
                }
                
                imageView.frame = CGRectMake(originX,originY,emojiWidth,emojiHeight)
                
                
                if j % onePageCount == 0  && j != 0 {
                    imageView.image = UIImage(named: "key-delete")
                    originX = self.dialogLeftPadding
                    originY = self.dialogTopPadding
                    view.addSubview(imageView)
                    break
                } else {
                    imageView.image = weChatEmoji.image
                }
                
                view.addSubview(imageView)
            }
            
            x += self.frame.width
            self.scrollView.addSubview(view)
        }
    
        
        //为了让内容横向滚动，设置横向内容宽度为N个页面的宽度总和
        //不允许在垂直方向上进行滚动
        self.scrollView.contentSize = CGSizeMake(CGFloat(UIScreen.mainScreen().bounds.width * CGFloat(self.pageCount)), 0)
        self.scrollView.pagingEnabled = true//滚动时只能停留到某一页
        self.scrollView.delegate = self
        self.scrollView.userInteractionEnabled = true
    }
}

//自定义TextView Placeholder类
class PlaceholderTextView:UITextView {
    
    var placeholder:String?
    var color:UIColor?
    var fontSize:CGFloat = 15
    
    var placeholderLabel:UILabel?
    var placeholderFont:UIFont?
    var isLayedOut:Bool = false
    
    init(frame:CGRect,placeholder:String?,color:UIColor?,font:UIFont?){
        super.init(frame: frame, textContainer: nil)
        
        if placeholder != nil {
            self.placeholder = placeholder
        }
        
        if color != nil {
            self.color = color
        } else {
            self.color = UIColor.lightGrayColor()
        }
        
        if font != nil {
            self.font = font
        } else {
            self.font = UIFont.systemFontOfSize(fontSize)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initFrame(){
        self.backgroundColor = UIColor.clearColor()
        self.placeholderLabel = UILabel()
        placeholderLabel!.backgroundColor = UIColor.clearColor()
        placeholderLabel!.numberOfLines = 0//多行
        placeholderLabel?.text = self.placeholder
        placeholderLabel?.font = self.font
        placeholderLabel?.textColor = self.color
        //根据字体的高度,计算上下空白
        var labelHeight:CGFloat = 0
        let labelWidth:CGFloat = self.frame.width - labelLeftPadding * 2
        let maxSize = CGSizeMake(labelWidth,CGFloat(MAXFLOAT))
        
        let options : NSStringDrawingOptions = [.UsesLineFragmentOrigin,.UsesFontLeading]
        labelHeight = self.placeholder!.boundingRectWithSize(maxSize, options: options, attributes: [NSFontAttributeName:self.font!], context: nil).size.height
        
        self.labelTopPadding = (self.frame.height - labelHeight) / 2
        self.placeholderLabel!.frame = CGRectMake(labelLeftPadding, self.labelLeftPadding,labelWidth , labelHeight)
        
        self.addSubview(placeholderLabel!)
        
        //监听文字变化
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"textDidChange", name: UITextViewTextDidChangeNotification , object: self)
    }
    
    //MARKS: 文字变化
    func textDidChange(){
        self.placeholderLabel!.hidden = self.hasText()//如果UITextView输入了文字,hasText就是YES,反之就为NO
    }
    
    let labelLeftPadding:CGFloat = 7
    var labelTopPadding:CGFloat = 5
    
    override func layoutSubviews() {
       super.layoutSubviews()
        if !isLayedOut {
            if self.placeholder == nil || self.placeholder!.isEmpty {
                return
            }
            
            initFrame()
            isLayedOut = true
        }
    }
    
    let curTopPadding:CGFloat = 3
    
    //MARKS: 设置光标
    override func caretRectForPosition(position: UITextPosition) -> CGRect {
        let originalRect = super.caretRectForPosition(position)
        return resetCur(originalRect)
    }
    
    //MARKS: 重置光标
    func resetCur(originalRect:CGRect) -> CGRect{
        let rect = originalRect
        let curHeight:CGFloat = self.frame.height - curTopPadding * 2
        return CGRectMake(rect.origin.x, curTopPadding, rect.width, curHeight)
    }
}