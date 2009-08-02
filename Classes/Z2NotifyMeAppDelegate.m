/*
 The MIT License
 
 Copyright (c) 2009 Zero260, Inc.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 the Software, and to permit persons to whom the Software is furnished to do so,
 subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "Z2NotifyMeAppDelegate.h"
#import "Z2NotifyMeViewController.h"

@implementation Z2NotifyMeAppDelegate

@synthesize window;
@synthesize viewController;

@synthesize notificationReceived;
@synthesize alert;
@synthesize sound;
@synthesize uiid;


- (void)setLaunchOptions:(NSDictionary *)dictionary {
	if (dictionary) {
		// Show how to parse the dictionary
		self.notificationReceived = YES;
		self.uiid = (NSString *)[dictionary objectForKey:@"uiid"]; // NOTE: app metadata SHOULD be at the same level as aps
		dictionary = (NSDictionary *)[dictionary objectForKey:@"aps"];
		if (self.uiid == nil) {
			self.uiid = (NSString *)[dictionary objectForKey:@"uiid"]; // NOTE: app metadata can be under aps
			if (self.uiid == nil) {
				self.uiid = @"Not Set";
			}
		}
		self.alert = (NSString *)[dictionary objectForKey:@"alert"];
		self.sound = (NSString *)[dictionary objectForKey:@"sound"];
	}
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    application.applicationIconBadgeNumber = 0;

	if (launchOptions) {
		[self setLaunchOptions:[launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey]];
	}

	// Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
	return YES;
}

- (void)dealloc {
    [viewController release];
    [window release];
	[alert release];
	[sound release];
	[uiid release];
	
    [super dealloc];
}

#pragma mark UIApplicationDelegate

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
	NSLog(@"didRegisterForRemoteNotificationsWithDeviceToken:\n%@", deviceToken);
	viewController.tokenTextField.text = [NSString stringWithFormat:@"%@", deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
	NSLog(@"didFailToRegisterForRemoteNotificationsWithError:%@", [error localizedDescription]);
	viewController.tokenTextField.text = [NSString stringWithFormat:@"Failed to get Device Token: %@", [error localizedDescription]];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
	[self setLaunchOptions:userInfo];
	[self.viewController notificationReceived:self];
}

@end
