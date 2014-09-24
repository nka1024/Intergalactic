//
//  TDAppDelegate.h
//  spaceman
//
//  Created by Admin on 8/18/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDGame.h"
#import "TDMenuScreenViewController.h"

@interface TDAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
