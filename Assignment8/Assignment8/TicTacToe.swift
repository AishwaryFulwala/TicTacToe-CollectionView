//
//  TicTacToe.swift
//  Assignment8
//
//  Created by DCS on 04/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class TicTacToe: UIViewController {
    
    private var f = false
    
    private var flag = [0,0,0,0,
                        0,0,0,0,
                        0,0,0,0,
                        0,0,0,0]
    
    private let wincomb = [[0,1,2,3], [4,5,6,7], [8,9,10,11], [12,13,14,15],
                           [0,4,8,12], [1,5,9,13], [2,6,10,14], [3,7,11,15],
                           [0,5,10,15], [3,6,9,12]]
    
    private let lbl1 : UILabel = {
        let l = UILabel()
        l.text = "Player 1 :: X"
        l.textColor = .white
        return l
    }()
    
    private let lbl2 : UILabel = {
        let l = UILabel()
        l.text = "Player 2 :: O"
        l.textColor = .white
        return l
    }()
    
    private let cv : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 55, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: 70, height: 70)
        
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return c
    }()
    
    func back() {
        let iv : UIImageView = {
            let i = UIImageView()
            i.contentMode = .scaleAspectFill
            i.clipsToBounds = true
            i.frame = view.bounds
            i.image = UIImage(named: "B2.jpeg")
            return i
        }()
        
        view.addSubview(iv)
        view.sendSubviewToBack(iv)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        back()
        cv.backgroundColor = UIColor(patternImage: UIImage(named: "B2.jpeg")!)
        view.addSubview(cv)
        view.addSubview(lbl1)
        view.addSubview(lbl2)
        set()
    }
    
    override func viewDidLayoutSubviews() {
        cv.frame = CGRect(x: 10, y: 100, width: 350, height: 400)
        lbl1.frame = CGRect(x: 10, y: 25, width: 100, height: 20)
        lbl2.frame = CGRect(x: 10, y: 50, width: 100, height: 20)
    }
}

extension TicTacToe: UICollectionViewDelegate, UICollectionViewDataSource {
    private func set() {
        cv.dataSource = self
        cv.delegate = self
        cv.register(Cell.self, forCellWithReuseIdentifier: "flag")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flag.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "flag", for: indexPath) as! Cell
        cell.disp(with: flag[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if flag[indexPath.row] != 1 && flag[indexPath.row] != 2 {
            flag.remove(at: indexPath.row)
            
            if  f {
                flag.insert(1, at: indexPath.row)
            }
            else {
                flag.insert(2, at: indexPath.row)
            }
            
            f = !f
            cv.reloadSections(IndexSet(integer: 0))
            win()
        }
    }
    
    private func win () {
        if !flag.contains(0) {
            restart()
            let alert = UIAlertController(title: "TicTacToe", message: "draw", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            DispatchQueue.main.async {
                self.present(alert, animated: true)
            }
        }
        else {
            for i in wincomb {
                if flag[i[0]] == flag[i[1]] && flag[i[1]] == flag[i[2]] && flag[i[2]] == flag[i[3]] && flag[i[0]] != 0 {
                    var msg = ""
                    
                    if(flag[i[0]] == 1) {
                        msg = lbl2.text!
                    }
                    else {
                        msg = lbl1.text!
                    }
                    let alert = UIAlertController(title: "TicTacToe", message: "\(msg) win", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                    DispatchQueue.main.async {
                        self.present(alert, animated: true)
                    }
                    restart()
                    break
                }
            }
        }
        
        
    }
    
    private func restart() {
        flag = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        f = false
        cv.reloadSections(IndexSet(integer: 0))
    }
}
