//
//  NewGroupTableViewController.swift
//  VKClient
//
//  Created by Дмитрий Паркалов on 9.04.22.
//

import UIKit


class NewGroupTableViewController: UITableViewController {

    var allGroups: [Groups] = []

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddGroup", for: indexPath)  as! NewGroupTableViewCell

        cell.nameNewGroupLabel.text = allGroups[indexPath.row].groupName
        //cell.avatarNewGroupView.avatarImage.image = allGroups[indexPath.row].groupLogo

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // кратковременное подсвечивание при нажатии на ячейку
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

