//
//  ViewController.swift
//  TT
//
//  Created by WillowRivers on 2017/2/16.
//  Copyright © 2017年 WillowRivers. All rights reserved.
//

import UIKit

class ViewController:  UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    var imageView: UIImageView!
    var imageView2: UIImageView!
    //var imageV1Base64 : [String] = ["",""] ;
    //var firstResponderBase64 = -1 ;
    var firstResponderImageV : UIImageView! = UIImageView() ;
    var editSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad() ;
        imageView = UIImageView(frame: CGRect(x: 50 , y: 50, width: 200, height: 200)) ;
        imageView.isUserInteractionEnabled = true ;
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self , action: #selector(aler(sender:)))) ;
        imageView.backgroundColor = UIColor.blue ;
        
        imageView2 = UIImageView(frame: CGRect(x: 50 , y: 280, width: 200, height: 200)) ;
        imageView2.isUserInteractionEnabled = true ;
        imageView2.addGestureRecognizer(UITapGestureRecognizer(target: self , action: #selector(aler(sender : )))) ;
        imageView2.backgroundColor = UIColor.red ;
        
        editSwitch = UISwitch(frame: CGRect(x: 50, y: 10, width: 50 , height: 30)) ;
        editSwitch.isOn = true ;
        
        self.view.addSubview(imageView) ;
        self.view.addSubview(editSwitch) ;
        self.view.addSubview(imageView2) ;
    }
    
    func imageValueChange()
    {
        print("value change") ;
    }
    
    func aler(sender : AnyObject)
    {
        firstResponderImageV = sender.view! as! UIImageView ;
        
        let alertC = UIAlertController(title: "选择图片", message: "", preferredStyle: .actionSheet) ;
        let photoLibrary = UIAlertAction(title: "相册🖼", style: .default, handler: {_ in self.fromAlbum(sender)}) ;
        let camara = UIAlertAction(title: "相机📷", style: .default, handler: { _ in self.fromCamera(sender)}) ;
        let cancel = UIAlertAction(title: "取消", style: .cancel , handler: nil) ;
        alertC.addAction(photoLibrary) ;
        alertC.addAction(camara) ;
        alertC.addAction(cancel) ;
        self.present(alertC , animated: true , completion: nil) ;
    }
    //选取相册
     func fromAlbum(_ sender: AnyObject) {
        //判断设置是否支持图片库
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            //初始化图片控制器
            let picker = UIImagePickerController()
            //设置代理
            picker.delegate = self
            //指定图片控制器类型
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            //设置是否允许编辑
            picker.allowsEditing = editSwitch.isOn
            //弹出控制器，显示界面
            self.present(picker, animated: true, completion: {
                () -> Void in
            })
        }else{
            print("读取相册错误")
        }
        
    }
    func fromCamera(_ sender : AnyObject)
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            let picker = UIImagePickerController()
            //设置代理
            picker.delegate = self
            //指定图片控制器类型
            picker.sourceType = UIImagePickerControllerSourceType.camera
            //设置是否允许编辑
            picker.allowsEditing = true ;
            //弹出控制器，显示界面
            self.present(picker, animated: true, completion: {
                () -> Void in
            })
        }
        else
        {
            print("camera error") ;
        }
    }
    
    //选择图片成功后代理
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        //查看info对象
       //显示的图片
        let image:UIImage!
        if editSwitch.isOn {
            //获取编辑后的图片
            image = info[UIImagePickerControllerEditedImage] as! UIImage
        }
        else
        {
            //获取选择的原图
            image = info[UIImagePickerControllerOriginalImage] as! UIImage
        }
        guard firstResponderImageV != nil else
        {
            print("nil") ;
            return ;
        }
        firstResponderImageV.image = image
        //图片控制器退出
        picker.dismiss(animated: true, completion: {
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
