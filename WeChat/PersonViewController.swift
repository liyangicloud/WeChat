//
//  PersonViewController.swift
//  WeChat
//
//  Created by Smile on 16/1/14.
//  Copyright © 2016年 smile.love.tao@gmail.com. All rights reserved.
//

import UIKit

//个人信息页面
//需要重新定义视图,把控件包含进去
class PersonViewController: WeChatTableViewNormalController {

    //MARKS:Properties
    var navigationTitle:String?//导航标题
    var headerImage:UIImage?//小头像
    let headerImageWidth:CGFloat = 80//小头像宽度
    let headerImageHeight:CGFloat = 80//小头像高度
    let headerLabelHeight:CGFloat = 20//小头像下文字高度
    let headerLabelWidth:CGFloat = 250//小头像下文字宽度
    let paddingLeft:CGFloat = 10//左边距
    let paddingRight:CGFloat = 15//右边距
    let paddingTop:CGFloat = 10//上边距
    let paddingBottom:CGFloat = 10//下边距
    
    let titleTopPadding:CGFloat = 10//标题上边空白
    let titleBottomPadding:CGFloat = 10//标题下边空白
    let photoLeftPadding:CGFloat = 5//图片左边空白
    let photoRightPadding:CGFloat = 5//图片右边空白
    let photoBottomPadding:CGFloat = 5//图片下边空白
    let contentRightPadding:CGFloat = 10//内容右边空白
    let contentTopPadding:CGFloat = 5
    let contentBottomPadding:CGFloat = 5
    let dateBottomPadding:CGFloat = 5
    let dateTopPadding:CGFloat = 10
    let dateRightPadding:CGFloat = 5
    let placeBottomPadding:CGFloat = 5
    
    let leftPadding:CGFloat = 10//左边空白
    let rightPadding:CGFloat = 10//右边空白
    let bottomPadding:CGFloat = 30//底部空白
    let leftWidth:CGFloat = 100//左边宽度
    let topPadding:CGFloat = 10//距上边空白
    
    let dateHeight:CGFloat = 25
    let placeHeight:CGFloat = 25
    let titleHeight:CGFloat = 20
    let contentHeight:CGFloat = 40
    
    let lastCellBottomPadding:CGFloat = 50//最后view距离线条高度
    let lastDrawHeight:CGFloat = 5//最后线条高度
    
    let titleFontSize:CGFloat = 14//标题字体大小
    let textColor = UIColor.darkGrayColor()//字体颜色
    
    
    var personInfos:[PersonInfo] = [PersonInfo]()
    let headerBgHeight:CGFloat = 300//背景大图高度
    
    //重写属性,去掉tableview header
    override var CELL_HEADER_HEIGHT:CGFloat {
        get {
            return 0
        }
        
        set {
            self.CELL_HEADER_HEIGHT = newValue
        }
    }
    
    override var CELL_FOOTER_HEIGHT:CGFloat {
        get {
            return 0
        }
        
        set {
            self.CELL_FOOTER_HEIGHT = newValue
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initFrame()
        //tableView.registerClass(PersonInfoCell.self, forCellReuseIdentifier: "InfoCell")
    }
    
    //MARKS: 初始化
    func initFrame(){
        //设置标题
        navigationItem.title = navigationTitle
        
        //MARKS: 设置导航行背景及字体颜色
        WeChatNavigation().setNavigationBarProperties((self.navigationController?.navigationBar)!)
        
        //去掉tableview分割线
        tableView.separatorStyle = .None
        tableView.scrollEnabled = true
        tableView.showsVerticalScrollIndicator = true
        //去掉scrollview自动设置
        //self.automaticallyAdjustsScrollViewInsets = false
        initTableHeaderView()
        initData()
    }
    
    //MARKS: 初始化数据
    func initData(){
        let photo1 = Photo(photoImage: UIImage(named: "info-bg1"),width:100,height:100,isBigPic:true)
        let photo2 = Photo(photoImage: UIImage(named: "info-bg2"),width:100,height:100,isBigPic:true)
        let photo3 = Photo(photoImage: UIImage(named: "info-bg6"),width:100,height:100,isBigPic:true)
        let photo4 = Photo(photoImage: UIImage(named: "info-bg4"),width:100,height:100,isBigPic:true)
        
        for i in 0 ... 6 {
            var personInfo:PersonInfo = PersonInfo()
            if i % 6 == 1 {//小图片和内容
                let photo = Photo(photoImage: UIImage(named: "contact1"))
                let content = Content(content: "我，已经选择了你，你叫我怎么放弃...我不是碰不到更好的，而是因为已经有了你，我不想再碰到更好的；")
                let info = Info(photo: [photo], content: content)
                personInfo = PersonInfo(date: "十二月",day:"\(i+1)", place: "上海・张江高科技园区", infos: [info])
                personInfos.append(personInfo)
            } else if i % 6 == 2 {//图片、内容和标题
                let photo = Photo(photoImage: UIImage(named: "contact2"), width: 40, height: 40)
                let content = Content(content: "我，已经选择了你，你叫我怎么放弃...我不是碰不到更好的，而是因为已经有了你，我不想再碰到更好的；")
                let title = Title(title: "[得意]说得很有道理")
                let info = Info(title: title, photo: [photo], content: content)
                personInfo = PersonInfo(date: "十二月",day:"\(i+1)", infos: [info])
                personInfos.append(personInfo)
            } else if i % 6 == 3 {//内容
                let content = Content(content: "我，已经选择了你，你叫我怎么放弃...我不是碰不到更好的，而是因为已经有了你，我不想再碰到更好的；")
                let info = Info(content: content)
                personInfo = PersonInfo(date: "十二月",day:"\(i+1)", place: "上海・张江高科技园区", infos: [info])
                personInfos.append(personInfo)
            } else if i % 6 == 4 {//大图和内容
                let content = Content(content: "我，已经选择了你，你叫我怎么放弃...我不是碰不到更好的，而是因为已经有了你，我不想再碰到更好的；")
                let info = Info(photo: [photo1,photo2,photo3],content: content)
                personInfo = PersonInfo(date: "十二月",day:"\(i+1)", place: "上海・张江高科技园区", infos: [info])
                personInfos.append(personInfo)
            } else if i % 6 == 5{//大图
                let info = Info(photo: [photo1,photo2,photo3,photo4])
                personInfo = PersonInfo(date: "十二月",day:"\(i+1)", infos: [info])
                personInfos.append(personInfo)
            } else {
                let info = Info(photo: [photo1,photo2])
                personInfo = PersonInfo(date: "十二月",day:"\(i+1)", infos: [info])
                personInfos.append(personInfo)
            }
            
            
        }
    }
    
    //初始化tableHeaderView
    func initTableHeaderView(){
        //头像小图
        let upHeight:CGFloat = 20//向上提升高度
        let headerImageX = UIScreen.mainScreen().bounds.width - headerImageWidth - paddingRight
        let headerImageY = headerBgHeight - headerImageHeight / 2 - upHeight

        let spacePadding:CGFloat = 5
        let imageFrame = CGRect(x: headerImageX - spacePadding, y: headerImageY - spacePadding, width: headerImageWidth + spacePadding , height: headerImageHeight + spacePadding)
        
        let personView = PersonImageView(frame: imageFrame, image: headerImage!)
        
        //背景大图,需要向上提升
        let bgUpHeight:CGFloat = 50//向上提升空白数
        let bgImageView = UIImageView(frame: CGRect(x: 0, y: -bgUpHeight, width: UIScreen.mainScreen().bounds.width, height: headerBgHeight + bgUpHeight))
        bgImageView.image = UIImage(named: "info-bg\(getRandom(1,max: 10))")
        
        //小头像边上文字
        let photoLabel = UILabel(frame: CGRectMake(UIScreen.mainScreen().bounds.width - headerImageWidth - headerLabelWidth - paddingRight * 3, headerBgHeight - paddingBottom * 3, headerLabelWidth, headerLabelHeight))
        photoLabel.textAlignment = .Right
        photoLabel.font = UIFont(name: "AlNile-Bold", size: 20)
        photoLabel.textColor = UIColor.whiteColor()
        photoLabel.text = navigationTitle
        
        var label:UILabel?
        let spaceUpLabel = paddingTop + paddingBottom//文字上面空白
        //添加Label,获取随机数:
        let random = getRandom(1, max: 4)
        if random % 2 == 0 {
            label = UILabel(frame: CGRectMake(UIScreen.mainScreen().bounds.width - headerLabelWidth - paddingRight, headerBgHeight + headerImageHeight / 2 + spaceUpLabel - upHeight, headerLabelWidth, headerLabelHeight))
            label!.textAlignment = .Right
            label!.font = UIFont(name: "AlNile", size: 14)
            label!.textColor = UIColor(red: 143/255, green: 143/255, blue: 143/255, alpha: 1)
            label!.text = "如果还可以重来,我将用一生去呵护你..."
            
        }
        
        //以CGRectZero作为frame初始化UIView为了去掉其底部线条
        //计算headerView高度
        var headerViewHeight:CGFloat = 0
        if label != nil {
            headerViewHeight += label!.frame.origin.y
        }else{
            headerViewHeight += (headerBgHeight + (headerImageHeight / 2 - upHeight))
        }
        
        headerViewHeight += 40 //底部留40的空白
        //let headerView:UIView = UIView(frame: CGRectZero)
        let headerView = UIView(frame: CGRectMake(0,0,UIScreen.mainScreen().bounds.width,headerViewHeight))
        headerView.backgroundColor = UIColor.clearColor()
        headerView.addSubview(bgImageView)
        headerView.addSubview(personView)
        headerView.addSubview(photoLabel)
        if label != nil {
            headerView.addSubview(label!)
        }
       
        tableView.tableHeaderView = headerView
    }
    
    //MARKS: 返回cell行数
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personInfos.count
    }
    
    //创建Label
    func createLabel(frame:CGRect,string:String,color:UIColor,fontSize:CGFloat,isAllowNext:Bool) -> UILabel{
        let label = UILabel(frame: frame)
        label.textAlignment = .Left
        label.font = UIFont(name: "AlNile", size: fontSize)
        label.textColor = color
        label.text = string
        if isAllowNext {
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.ByTruncatingTail//有省略号
        }
        return label
    }
    
    //创建Photo
    func createPhotoView(frame:CGRect,image:UIImage) -> UIImageView{
        let photoView = UIImageView(frame: frame)
        photoView.image = image
        return photoView
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PersonInfoCell", forIndexPath: indexPath) as! PersonInfoCell
        
        //隐藏所有控件
        cell.titleLabel.hidden = true
        cell.photoImageView.hidden = true
        cell.contentLabel.hidden = true
        
        let personInfo = personInfos[indexPath.row]
        if !personInfo.date.isEmpty{
            cell.dateLabel.text = personInfo.date
            //cell.dateLabel.font = UIFont(name: "AlNile", size: 20)
        }else{
            cell.dateLabel.hidden = true
        }
        
        if !personInfo.day.isEmpty{
            cell.dayLabel.text = personInfo.day
        }else{
            cell.dayLabel.hidden = true
        }
        
        if !personInfo.place.isEmpty {
            cell.placeLabel.text = personInfo.place
        }else{
            cell.placeLabel.hidden = true
        }
        
        /*var cellHeight = cell.frame.height
        //最后一行添加线条
        if indexPath.row == (personInfos.count - 1) {
            cellHeight -= lastCellBottomPadding * 2
        }else{
            cellHeight -= bottomPadding
        }*/
        
        for info in personInfo.infos {
            let photo = info.photo
            let title = info.title
            let content = info.content
            
            var infoHeight:CGFloat = 0
            if title != nil && photo != nil {//当有标题和图片和内容,图片为小图
               infoHeight = titleTopPadding + titleHeight + photo![0].height + titleTopPadding
            } else if title == nil && photo != nil {//当没有标题,只有图片或图片和内容
               infoHeight = photoBottomPadding * 2 + photo![0].height
            } else if title == nil && photo == nil && content != nil{//当只有内容
                infoHeight = photoBottomPadding * 2 + contentHeight
            }
            
            cell.addSubview(createControlView(
                CGRectMake(
                    leftPadding + leftWidth,
                    0,
                    UIScreen.mainScreen().bounds.width - (leftPadding + leftWidth) - rightPadding,
                    infoHeight
                ),
                color: UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1),
                title: title,
                content: content,
                photos: photo
                )
            )
        }
        
        //最后一行添加线条
        if indexPath.row == (personInfos.count - 1) {
            cell.addSubview(LastCellCustomView(frame: CGRectMake(leftWidth + rightPadding, cell.frame.height - lastCellBottomPadding * 2 + lastCellBottomPadding, cell.frame.width - leftWidth,lastDrawHeight)))
        }
        
        //取消cell选中样式
        cell.selectionStyle = .None
        return cell
    }

    //MARKS: 计算当有标题和图片和内容,图片为小图大小
    /*func createOne(cellHeight:CGFloat,title:Title,content:Content,photo:[Photo]) -> PersonCustomView{
        //创建UIView,包含所有控件
        //控制背景色
        let bgColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
        let controlView = PersonCustomView(frame: CGRectMake(leftPadding + leftWidth, titleTopPadding, UIScreen.mainScreen().bounds.width - (leftPadding + leftWidth) - rightPadding, cellHeight), tableView: self.tableView, color: bgColor)
        
        let _titleBottomPadding:CGFloat = titleBottomPadding / 2
        let titleLabel = createLabel(CGRectMake(photoLeftPadding, titleTopPadding, controlView.frame.width, titleHeight), string: (title.title), color: UIColor.darkGrayColor(), fontSize: 14,isAllowNext: false)
        
        let photoImage = createPhotoView(CGRectMake(photoLeftPadding, titleTopPadding + titleHeight + _titleBottomPadding, (photo[0].width), photo[0].height), image: photo[0].photoImage!)
        
        let contentLabel = createLabel(CGRectMake(photoImage.frame.origin.x + photoImage.frame.width + photoRightPadding,photoImage.frame.origin.y + contentTopPadding, controlView.frame.width - (photo[0].width) - photoLeftPadding - photoRightPadding - contentRightPadding,contentHeight), string: (content.content), color: UIColor.darkGrayColor(), fontSize: 14,isAllowNext: true)
        
        controlView.backgroundColor = bgColor
        controlView.addSubview(titleLabel)
        controlView.addSubview(photoImage)
        controlView.addSubview(contentLabel)
        
        //创建UIView,包含所有控件
        let bgColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        let controlView = PersonCustomView(frame: CGRectMake(leftPadding + leftWidth, titleTopPadding, UIScreen.mainScreen().bounds.width - (leftPadding + leftWidth) - rightPadding, cellHeight), tableView: self.tableView, color: bgColor)
        
        //重新计算padding
        let padding:CGFloat = (controlView.frame.height - photo![0].height) / 2
        
        let photoImage = createPhotoView(CGRectMake(photoLeftPadding, padding, photo![0].width, photo![0].height), image: photo![0].photoImage!)
        let contentLabel = createLabel(CGRectMake(photoImage.frame.origin.x + photoImage.frame.width + photoRightPadding,contentTopPadding + titleTopPadding, controlView.frame.width - photo![0].width - photoLeftPadding - photoRightPadding - contentRightPadding,contentHeight), string: (content?.content)!, color: UIColor.darkGrayColor(), fontSize: 14,isAllowNext: true)
        controlView.backgroundColor = bgColor
        controlView.addSubview(photoImage)
        controlView.addSubview(contentLabel)
        
        
        //创建UIView,包含所有控件
        let bgColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        let controlView = PersonCustomView(frame: CGRectMake(leftPadding + leftWidth, titleTopPadding, UIScreen.mainScreen().bounds.width - (leftPadding + leftWidth) - rightPadding, cellHeight), tableView: self.tableView, color: bgColor)
        
        //重新计算padding
        let padding:CGFloat = (controlView.frame.height - contentHeight) / 2
        
        let contentLabel = createLabel(CGRectMake(photoLeftPadding,padding, controlView.frame.width - photoLeftPadding - contentRightPadding,contentHeight), string: (content?.content)!, color: UIColor.darkGrayColor(), fontSize: 14,isAllowNext: true)
        controlView.backgroundColor = bgColor
        controlView.addSubview(contentLabel)
        
        return controlView
    }*/
    
    func createControlView(rect:CGRect,color:UIColor,title:Title?,content:Content?,photos:[Photo]?) -> PersonCustomView{
        let controlView = PersonCustomView(frame: rect, tableView: self.tableView, color: color)
        
        //title
        var titleLabel:UILabel?
        if title != nil {
            let beginX:CGFloat = photoLeftPadding
            let beginY:CGFloat = titleTopPadding
            let width:CGFloat = controlView.frame.width
            let height:CGFloat = self.titleHeight
            titleLabel = createLabel(
                                 CGRectMake(beginX, beginY, width, height),
                                 string: title!.title,
                                 color: textColor,
                                 fontSize: titleFontSize,
                                 isAllowNext:true
                             )
            
            controlView.addSubview(titleLabel!)
        }
        
        //images
        var photoImages = [UIImageView]()
        if photos != nil && photos!.count > 0 {
            let beginX:CGFloat = photoLeftPadding
            var beginY:CGFloat = 0
            if titleLabel != nil {
                beginY = titleTopPadding + titleHeight
            }else{
                beginY = photoBottomPadding
            }
            
            let width:CGFloat =  photos![0].width//取第一张图片的宽度
            let height:CGFloat = photos![0].height//取第一张图片的高度
            
            
            if photos!.count == 1 {
                photoImages.append(createPhotoView(CGRectMake(beginX, beginY, width, height), image: photos![0].photoImage!))
            } else {
                let photoPadding:CGFloat = 2
                let _width = width / 2 - photoPadding
                let _height = height / 2 - photoPadding
                for(var i = 0;i < photos?.count;i++){
                    let photo = photos![i]
                    
                    //如果两张,则并排一起
                    if photos?.count == 2 {
                        var x:CGFloat = beginX
                        if i == 1{
                            x += _width + photoPadding
                        }
                        
                        photoImages.append(createPhotoView(CGRectMake(x,beginY,_width,height), image: photo.photoImage!))
                    }
                    
                    //如果三张,则第一张到底,第二、第三张上下并列
                    else if photos?.count == 3 {
                        var x:CGFloat = beginX
                        var y:CGFloat = beginY
                        let pWidth:CGFloat = _width
                        var pHeight:CGFloat = _height
                        if i == 0 {
                            pHeight = height
                        } else if i == 1 {
                            x += _width + photoPadding
                        } else if i == 2 {
                            x += _width + photoPadding
                            y = beginY + pHeight + photoPadding
                        }
                        
                        photoImages.append(createPhotoView(CGRectMake(x,y,pWidth,pHeight), image: photo.photoImage!))
                    }
                    
                    //如果是四张或四张以上,上下左右排列
                    else if photos?.count >= 4 {
                        var x:CGFloat = beginX
                        var y:CGFloat = beginY
                        let pWidth:CGFloat = _width
                        let pHeight:CGFloat = _height
                        if i == 1 {
                            x += _width + photoPadding
                        } else if i == 2 {
                            y = beginY + pHeight + photoPadding
                        } else if i == 3 {
                            x += _width + photoPadding
                            y = beginY + pHeight + photoPadding
                        }

                        photoImages.append(createPhotoView(CGRectMake(x,y,pWidth,pHeight), image: photo.photoImage!))
                    }
                    
                    
                }
                
                
            }
            
            
        }
        
        if photoImages.count > 0 {
            for photoImage in photoImages {
                controlView.addSubview(photoImage)
            }
        }
        
        //content
        var contentLabel:UILabel?
        if content != nil {
            var beginX:CGFloat = photoLeftPadding
            var beginY:CGFloat = titleTopPadding
            var width:CGFloat = controlView.frame.width
            let height:CGFloat = self.contentHeight
            
            if photoImages.count > 0 && titleLabel == nil{
                beginX += photos![0].height + photoRightPadding * 2
                beginY = photoImages[0].frame.origin.y + contentTopPadding * 2
                width = width - (photos![0].width + photoLeftPadding + photoRightPadding) - contentRightPadding
            }else if photoImages.count > 0 && titleLabel != nil {//有标题和图片,图片为小图
                beginX += photos![0].height + photoRightPadding * 2
                beginY = photoImages[0].frame.origin.y + contentTopPadding
                width = width - (photos![0].width + photoLeftPadding + photoRightPadding) - contentRightPadding
            }else if photoImages.count < 0 && titleLabel == nil {
                beginX += photos![0].height + photoRightPadding * 2
                beginY = photoBottomPadding + contentTopPadding
                width = width - photoLeftPadding - contentRightPadding
            }
            
            contentLabel = createLabel(
                CGRectMake(beginX, beginY, width, height),
                string: content!.content,
                color: textColor,
                fontSize: titleFontSize,
                isAllowNext:true
            )
            
            controlView.addSubview(contentLabel!)
            
        }
       
        return controlView
    }

   
    
    //MARKS:根据内容重新计算高度
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let personInfo = personInfos[indexPath.row]
        
        var height = getViewHeight(personInfo)
        //最后一行添加线条
        if indexPath.row == (personInfos.count - 1) {
            height += lastCellBottomPadding * 2
            return height
        }
        
        return height + bottomPadding
    }

    //获取高度
    func getViewHeight(personInfo:PersonInfo) -> CGFloat{
        var height:CGFloat = 0
        for info in personInfo.infos {
            let photo = info.photo
            let title = info.title
            let content = info.content
            if title != nil && photo != nil {//当有标题和图片和内容,图片为小图
                height += titleTopPadding
                height += titleHeight
                height += titleBottomPadding
                
                height += photo![0].height
                height += photoBottomPadding
            } else if title == nil && photo != nil {//当没有标题,只有图片或图片和内容
                let leftHeight = getLeftHeight(personInfo)
                
                if leftHeight > (photo![0].height + titleBottomPadding + photoBottomPadding) {
                    height += leftHeight
                }else{
                    height += photo![0].height + titleBottomPadding + photoBottomPadding
                }
                
            } else if title == nil && photo == nil && content != nil{//当只有内容
                //只有内容的时候要判断是不是大于左边的高度,如果大于以及为主,如果小于以左边为主
                let leftHeight = getLeftHeight(personInfo)
                if leftHeight > (contentHeight + contentTopPadding + contentBottomPadding) {
                    height += leftHeight
                }else{
                    height += contentHeight + contentTopPadding + contentBottomPadding
                }
                
            } else {
                continue
            }
        }
        
        return height
    }
    
    func getLeftHeight(personInfo:PersonInfo) -> CGFloat{
        var leftHeight:CGFloat = 0
        if !personInfo.date.isEmpty && !personInfo.place.isEmpty{
            leftHeight += dateTopPadding
            leftHeight += dateHeight
            leftHeight += dateBottomPadding
            leftHeight += placeHeight
            leftHeight += placeBottomPadding
        }else if !personInfo.date.isEmpty && personInfo.place.isEmpty{
            leftHeight += dateTopPadding
            leftHeight += dateHeight
            leftHeight += dateBottomPadding
        }
        
        return leftHeight
    }
    
}