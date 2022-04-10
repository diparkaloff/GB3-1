//
//  PhotosFriendCollectionViewController.swift
//  VKClient
//
//  Created by Дмитрий Паркалов on 9.04.22.
//

import UIKit
import Kingfisher

class PhotosFriendCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GetPhotosFriend().loadData(owner_id: userID) { [weak self] (complition) in
            DispatchQueue.main.async {
                self?.collectionPhotos = complition
                self?.collectionView.reloadData()
            }
        }
    }
    
    var userID = ""
    var collectionPhotos: [String] = []
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionPhotos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosFriendCell", for: indexPath) as! PhotosFriendCollectionViewCell
        
        if let imgUrl = URL(string: collectionPhotos[indexPath.row]) {
            let photo = ImageResource(downloadURL: imgUrl) //работает через Kingfisher  (с кэшем)
            cell.photosFrienndImage.kf.setImage(with: photo) //работает через Kingfisher (с кэшем)
            
            //cell.photosFrienndImage.load(url: imgUrl)  // работает через extension UIImageView
        }
        
        return cell
    }
    
    // MARK: - segue
    // переход на контроллер с отображением крупной фотографии
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showUserPhoto"{
            // ссылка объект на контроллер с которого переход
            guard let photosFriend = segue.destination as? FriendsPhotosViewController else { return }
            
            // индекс нажатой ячейки
            if let indexPath = collectionView.indexPathsForSelectedItems?.first {
                photosFriend.allPhotos = collectionPhotos //фотки
                photosFriend.countCurentPhoto = indexPath.row // можно указать (indexPath[0][1]) или использовать (?.first) как сделано выше
            }
        }
    }
    
    
    
}

