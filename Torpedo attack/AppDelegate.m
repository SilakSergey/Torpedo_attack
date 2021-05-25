//
//  AppDelegate.m
//  Torpedo attack
//
//  Created by Sergey Silak on 14.01.2021.
//

#import "AppDelegate.h"
#import "Constants.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:SOUNDBACKGROUND_KEY]){
        
        [[NSUserDefaults standardUserDefaults] setObject:@"ON" forKey:SOUNDBACKGROUND_KEY];
        
    }
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:SOUNDEFFECTS_KEY]){
        
        [[NSUserDefaults standardUserDefaults] setObject:@"ON" forKey:SOUNDEFFECTS_KEY];
        
    }
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:HARD_KEY]){
        
        [[NSUserDefaults standardUserDefaults] setObject:@"OFF" forKey:HARD_KEY];
        
    }
    
    
        
    //49,199,499,999,1999
    //0,49,99,149,199,299,399,499,749,999,1999
    
    //test
   //  [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:DESTROYED_KEY];
    
    
    //test No launch
  //  [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"beenLaunched"];
  
    
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"beenLaunched"]) {
        
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:DESTROYED_KEY];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"beenLaunched"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }

    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return YES;
}




@end
