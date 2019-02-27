//
//  ImagePicker.swift
//  Alert
//
//  Created by Nazhmeddin on 2019-02-19.
//  Copyright © 2019 Nazhmeddin. All rights reserved.
//

import UIKit

protocol ImagePickerDelegate: class {
    func didFetchImage(_ image: UIImage)
    func didFetchVideo(_ videoURL: URL)
}

class ImagePicker: NSObject {
    enum MediaTypes: String {
        case image = "public.image"
        case video = "public.movie"
    }
    
    private let imagePickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerDelegate?
    
    init(presentationController: UIViewController, delegate: ImagePickerDelegate, mediaTypes: [MediaTypes]) {
        imagePickerController = UIImagePickerController()
        super.init()
        
        self.presentationController = presentationController
        self.delegate = delegate
        
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = mediaTypes.map { $0.rawValue }
    }
    
    func present(withSourceType sourceType: UIImagePickerController.SourceType) {
        imagePickerController.sourceType = sourceType
        presentationController?.present(imagePickerController, animated: true, completion: nil)
    }
}

extension ImagePicker: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            delegate?.didFetchImage(image)
        } else if let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
            delegate?.didFetchVideo(videoURL)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}


extension ImagePicker: UINavigationControllerDelegate { }
