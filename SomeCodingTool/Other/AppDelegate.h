//
//  AppDelegate.h
//  SomeCodingTool
//
//  Created by FCNC05 on 2019/10/16.
//  Copyright © 2019 FCNC05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

