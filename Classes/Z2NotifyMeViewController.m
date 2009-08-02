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

#import "Z2NotifyMeViewController.h"

@implementation Z2NotifyMeViewController

@synthesize tokenTextField;

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	Z2NotifyMeAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
	if (appDelegate.didReceiveNotification) {
		// Launched from notification
		[self notificationReceived:appDelegate];
	}
}


- (void)notificationReceived:(Z2NotifyMeAppDelegate *)appDelegate {
	NSMutableString *launchOptionsToString = [NSMutableString string];
	if (appDelegate.alert) {
		[launchOptionsToString appendFormat:@"Message: %@\n", appDelegate.alert];
	}
	if (appDelegate.sound) {
		[launchOptionsToString appendFormat:@"Sound: %@\n", appDelegate.sound];
	}
	if (appDelegate.uiid) {
		[launchOptionsToString appendFormat:@"uiid: %@\n", appDelegate.uiid];
	}
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Received Notification" message:launchOptionsToString delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

@end
