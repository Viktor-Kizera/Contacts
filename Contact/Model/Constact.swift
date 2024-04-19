//
//  Constact.swift
//  Contact
//
//  Created by Viktor Kizera on 17.04.2024.
//

import Foundation

protocol ConstactProtocol {
    var title: String {get set}
    var phone: String {get set}
}
struct Constact: ConstactProtocol {
    var title: String
    var phone: String
}

protocol ContactStorageProtocol {
    func load() -> [ConstactProtocol]
    func save(contacts: [ConstactProtocol])
}

class ContactsStorage: ContactStorageProtocol {
    private var storage = UserDefaults.standard
    private var storageKey = "contacts"
    private enum ContactKey: String {
        case phone, title
    }
    func load() -> [ConstactProtocol] {
        var resultContacts: [ConstactProtocol] = []
        let contactsFromStorage = storage.array(forKey: storageKey) as? [[String:String]] ?? []
        for contact in contactsFromStorage {
            guard let title = contact[ContactKey.title.rawValue], let phone = contact[ContactKey.phone.rawValue] else {
                continue
            }
            resultContacts.append(Constact(title: title, phone: phone))
        }
       return resultContacts
    }
    func save(contacts: [ConstactProtocol]) -> Void {
        var arrayForStorage: [[String:String]] = []
        contacts.forEach{ contact in
            var newElementForStorage: Dictionary<String, String> = [:]
            newElementForStorage[ContactKey.title.rawValue] = contact.title
            newElementForStorage[ContactKey.phone.rawValue] = contact.phone
            arrayForStorage.append(newElementForStorage)}
        storage.set(arrayForStorage, forKey: storageKey)
    }
}
