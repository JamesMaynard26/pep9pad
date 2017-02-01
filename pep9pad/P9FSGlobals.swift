//
//  pep9pad
//
//  Copyright © 2016 Pepperdine University. All rights reserved.
//

import UIKit
import CoreData



let P9ProjectName = "P9Project"
typealias P9ProjectType = (name:String, source:String, object:String, listing:String)




// MARK: - Defaults

let NumDefaultProjects: Int = 1

var DefaultProjects: Array<P9ProjectType> = [
    (name:"My First Program",
     source: getStringFromDefaultP9Project(fileName: "myFirstProgram", ofType: PepFileType.pep),
     object: getStringFromDefaultP9Project(fileName: "myFirstProgram", ofType: PepFileType.pepo),
     listing: getStringFromDefaultP9Project(fileName: "myFirstProgram", ofType: PepFileType.pepl))
]


/// Only called from AppDelegate, and only called when `isFirstLaunch` is true.
/// i.e. happens only once, on the first launch following an installation.
/// Adds all elements of `DefaultFiles` to the CoreDatabase
func setupP9FS() {
    
    let appDel: AppDelegate =  UIApplication.shared.delegate as! AppDelegate
    let context: NSManagedObjectContext = appDel.managedObjectContext
    
    for proj in DefaultProjects {
        let ent = NSEntityDescription.entity(forEntityName: P9ProjectName, in: context)
        let newFile = P9Project(entity: ent!, insertInto: context)
        newFile.name = proj.name
        newFile.source = proj.source
        newFile.object = proj.object
        newFile.listing = proj.listing
        do {
            try context.save()
        } catch {
            print("Error: could not save default files.")
        }
    }
}

func getStringFromDefaultP9Project(fileName: String, ofType: PepFileType) -> String {
    guard let path = Bundle.main.path(forResource: fileName, ofType: ofType.rawValue) else {
        print("Path error: could not find file named \(fileName).\(ofType.rawValue)")
        return ""
    }

    do {
        let content = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
        print("Loaded file named \(fileName).\(ofType.rawValue)")
       return content
        
    } catch _ as NSError {
        print("Open error: could not open file named \(fileName).\(ofType.rawValue)")
        return ""
    }
}



// MARK: - Loading, Removing, and Adding Objects

// I'm not sure we want to do this -- source Strings are going to be large and should only be loaded when needed.
//func loadFilesFromFS() {
//    
//    let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
//    let context: NSManagedObjectContext = appDel.managedObjectContext
//    
//    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>()
//    fetchRequest.entity = NSEntityDescription.entity(forEntityName: P9ProjectName, in: context)
//    fetchRequest.includesPropertyValues = false
//    
//    do {
//        
//        if let results = try context.fetch(fetchRequest) as? [NSManagedObject] {
//            for result in results {
//                // cast it first:
//                let res = result as! P9Project
//                
//                let tempName: String = res.name
//                let tempType: String = res.type
//                let tempSource: String = res.source
//                
//                KnownWaves.append((name: res.nameOfWave, force: res.sourceString, y0: res.y0, v0: res.v0,  a: aLocal, b: bLocal, c: cLocal, d: dLocal, tFinal: res.tFinal, amp: ampLocal))
//                
//            }
//        }
//    } catch {
//        print("Error in loading files from FS.")
//    }
//
//}



//func removeAllFilesFromCoreData() {
//    let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
//    let context: NSManagedObjectContext = appDel.managedObjectContext!
//    
//    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>()
//    fetchRequest.entity = NSEntityDescription.entity(forEntityName: P9ProjectName, in: context)
//    fetchRequest.includesPropertyValues = false
//    do {
//        if let results = try context.fetch(fetchRequest) as? [NSManagedObject] {
//            for result in results {
//                context.delete(result)
//            }
//            try context.save()
//            // do something after save
//        }
//    } catch SetupError.knownError {
//        print("Known Error")
//    } catch {
//        print("Unknown Error")
//    }
//}



func loadP9ProjectNamesFromFS() -> [String] {
    
    var names: [String] = []
    let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let context: NSManagedObjectContext = appDel.managedObjectContext

    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>()
    fetchRequest.entity = NSEntityDescription.entity(forEntityName: P9ProjectName, in: context)
    fetchRequest.includesPropertyValues = false

    do {

        if let results = try context.fetch(fetchRequest) as? [NSManagedObject] {
            for result in results {
                // cast it first:
                let res = result as! P9Project
                names.append(res.name)
            }
        }
    } catch {
        print("Error in loading file names from FS.")
    }
    
    return names

}


func loadP9ProjectFromFS(named n: String) -> P9Project? {
    
    let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let context: NSManagedObjectContext = appDel.managedObjectContext
    
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>()
    fetchRequest.entity = NSEntityDescription.entity(forEntityName: P9ProjectName, in: context)
    fetchRequest.includesPropertyValues = false
    
    do {
        
        if let results = try context.fetch(fetchRequest) as? [NSManagedObject] {
            for result in results {
                let res = result as! P9Project
                if res.name == n {
                    return res
                }
            }
        }
    } catch {
        print("Error in loading file names from FS.")
    }
    
    return nil

}


func removeP9ProjectFromFS(named n: String) -> Bool {
    
    let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let context: NSManagedObjectContext = appDel.managedObjectContext
    
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>()
    fetchRequest.entity = NSEntityDescription.entity(forEntityName: P9ProjectName, in: context)
    fetchRequest.includesPropertyValues = false
    
    do {
        
        if let results = try context.fetch(fetchRequest) as? [NSManagedObject] {
            for result in results {
                let res = result as! P9Project
                if res.name == n {
                    context.delete(result)
                    try context.save()
                    return true
                }
            }
        }
    } catch {
        print("Error in deleting file from FS.")
    }
    
    return false
    
}


func updateP9ProjectInFS(named n: String, source: String, object: String, listing: String) -> Bool {
    let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let context: NSManagedObjectContext = appDel.managedObjectContext
    
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>()
    fetchRequest.entity = NSEntityDescription.entity(forEntityName: P9ProjectName, in: context)
    fetchRequest.includesPropertyValues = false
    
    do {
        
        if let results = try context.fetch(fetchRequest) as? [NSManagedObject] {
            for result in results {
                let res = result as! P9Project
                if res.name == n {
                    res.source = source
                    res.object = object
                    res.listing = listing
                    try context.save()
                    return true
                }
            }
        }
    } catch {
        print("Error in updating project.")
    }
    
    return false
    
}


func saveNewP9ProjectInFS(named n: String, source: String, object: String, listing: String) -> Bool {
    let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let context: NSManagedObjectContext = appDel.managedObjectContext
    
    let ent = NSEntityDescription.entity(forEntityName: P9ProjectName, in: context)
    let newFile = P9Project(entity: ent!, insertInto: context)
    newFile.name = n
    newFile.source = source
    newFile.object = object
    newFile.listing = listing
    
    do {
        try context.save()
        return true
    } catch {
        print("Error: could not save default files.")
    }
    
    return false
}

func validNameForP9Project(name: String) -> Bool {
    if name.characters.count >= 3 && !loadP9ProjectNamesFromFS().contains(name) {
        return true
    }
    return false
}





