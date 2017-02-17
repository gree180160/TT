//
//  MyImageView.swift
//  TT
//
//  Created by WillowRivers on 2017/2/17.
//  Copyright © 2017年 WillowRivers. All rights reserved.
//

import UIKit

class MyImageView: UIImageView , UIPickerViewControllerDelegate , UINavigationControllerDelegate{
    
    
    func aler(imageV : UIImageView)
    {
        let alertC = UIAlertController(title: "选择图片", message: "", preferredStyle: .actionSheet) ;
        let photoLibrary = UIAlertAction(title: "相册🖼", style: .default, handler: {_ in self.fromAlbum(imageV)}) ;
        let camara = UIAlertAction(title: "相机📷", style: .default, handler: { _ in self.fromCamera(imageV)}) ;
        let cancel = UIAlertAction(title: "取消", style: .cancel , handler: nil) ;
        alertC.addAction(photoLibrary) ;
        alertC.addAction(camara) ;
        alertC.addAction(cancel) ;
        //self.present(alertC , animated: true , completion: nil)
    }
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
        print("info is \(info)")
        
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
        imageView.image = image
        //图片控制器退出
        picker.dismiss(animated: true, completion: {
            () -> Void in
        })
    }
    
    func UIImageWriteToSavedPhotosAlbum(_ image: UIImage, _ completionTarget: Any?, _ completionSelector: Selector?, _ contextInfo: UnsafeMutableRawPointer?)
    {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
