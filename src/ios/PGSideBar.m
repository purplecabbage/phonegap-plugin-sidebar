/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

#include <sys/types.h>
#include <sys/sysctl.h>
#include "TargetConditionals.h"

#import <Cordova/CDV.h>
#import "PGSideBar.h"



@interface PGSideBar () {}
@end

@implementation PGSideBar

@synthesize tblView;
@synthesize tableItems;
@synthesize callbackId;

- (void)show:(CDVInvokedUrlCommand*)command
{
    
    if(self.tblView == nil )
    {
        self.tableItems = [command argumentAtIndex:0];
        
        self.tblView = [UITableView alloc];
        self.callbackId = command.callbackId;
        
        CGRect frame = self.webView.frame;
        
        CGRect rect = CGRectZero;
            rect.size.width = 240;
            rect.size.height = frame.size.height;
            rect.origin.y = frame.origin.y;
            rect.origin.x = frame.origin.x;

        // UITableViewStyleGrouped
        [tblView initWithFrame:rect style:UITableViewStylePlain];
        tblView.delegate = self;
        tblView.dataSource = self;
        tblView.backgroundColor = [ UIColor grayColor];
        tblView.sectionHeaderHeight = 120;
        tblView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.webView.bounds];
        self.webView.layer.masksToBounds = NO;
        self.webView.layer.shadowColor = [UIColor blackColor].CGColor;
        self.webView.layer.shadowOpacity = 0.5f;
        self.webView.layer.shadowRadius = 12.0f;
        self.webView.layer.shadowPath = shadowPath.CGPath;
        
        
        [self.viewController.view addSubview:tblView];
        [self.viewController.view sendSubviewToBack:tblView];
        
        frame.origin.x = 240;
        
        CDVPluginResult* pluginResult = [CDVPluginResult
                                         resultWithStatus:CDVCommandStatus_OK];
        [pluginResult setKeepCallback:[NSNumber numberWithInt:1]];
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut
            animations:^() {
                self.webView.frame = frame;
            }
            completion:^(BOOL finished){
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }];
    }
    else
    {
        CDVPluginResult* pluginResult = [CDVPluginResult
                                         resultWithStatus:CDVCommandStatus_ERROR
                                         messageAsString:@"it is already showing"];
        [pluginResult setKeepCallback:[NSNumber numberWithInt:1]];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

- (void)hide:(CDVInvokedUrlCommand*)command
{
    CGRect tblFrame = self.tblView.frame;
    
    CGRect frame = self.webView.frame;
    frame.origin.x = tblFrame.origin.x;
    
    CDVPluginResult* pluginResult = [CDVPluginResult
                                     resultWithStatus:CDVCommandStatus_OK
                                     messageAsString:@"hided it"];
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^() {
        self.webView.frame = frame;
    }completion:^(BOOL finished){
        tblView.delegate = nil;
        tblView.dataSource = nil;
        [tblView removeFromSuperview];
        tblView = nil;
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CDVPluginResult* pluginResult = [CDVPluginResult
                                     resultWithStatus:CDVCommandStatus_OK
                                     messageAsDouble:[indexPath indexAtPosition:1]];
    
//    [pluginResult setKeepCallback:[NSNumber numberWithInt:1]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSString* jsString = [[NSString alloc] initWithFormat:@"getItemCount(%d);",section];
//    NSString* strValue = [ webView stringByEvaluatingJavaScriptFromString:jsString];
//    
//    int retValue = [strValue intValue];
//    
//    [jsString release];
    
    return [self.tableItems count];
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        
        //		 UITableViewCellStyleDefault,	// Simple cell with text label and optional image view (behavior of UITableViewCell in iPhoneOS 2.x)
        //		 UITableViewCellStyleValue1,		// Left aligned label on left and right aligned label on right with blue text (Used in Settings)
        //		 UITableViewCellStyleValue2,		// Right aligned label on left with blue text and left aligned label on right (Used in Phone/Contacts)
        //		 UITableViewCellStyleSubtitle	// Left aligned label on top and left aligned label on bottom with gray text (Used in iPod).
        
        
        cell = [[ UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        [[ cell textLabel ] setTextColor:[ UIColor blackColor]];
        
        
        //		 UITableViewCellAccessoryNone,                   // don't show any accessory view
        //		 UITableViewCellAccessoryDisclosureIndicator,    // regular chevron. doesn't track
        //		 UITableViewCellAccessoryDetailDisclosureButton, // blue button w/ chevron. tracks
        //		 UITableViewCellAccessoryCheckmark               // checkmark. doesn't track
        
        
        cell.backgroundColor = [ UIColor grayColor]; // this only works for tables with type grouped
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        
        //		 UITableViewCellSelectionStyleNone,
        //		 UITableViewCellSelectionStyleBlue,
        //		 UITableViewCellSelectionStyleGray
        
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    
    int indexPosition = [indexPath indexAtPosition:1] ;
    
    //NSString* jsString = [[NSString alloc] initWithFormat:@"getItemAtIndex(%d);", indexPosition];
    
   
    
    NSString* cellText = self.tableItems[indexPosition];//[ webView stringByEvaluatingJavaScriptFromString:jsString];
    
    
    //NSDictionary* obj = (NSDictionary*)[cellText JSONFragmentValue];
    
    // This was to test the time it took to receive a call, at startup
    // it takes 10-30 ms per call to js
    
    cell.textLabel.text = cellText; //[obj objectForKey:@"text"];
    //cell.detailTextLabel.text = cellText; //[obj objectForKey:@"detailText"];
    
    //NSString* imgSrc = [obj objectForKey:@"image"];
    
    //AppRecord *appRecord = NULL;
    
//    if([entries count] > indexPosition)
//    {
//        appRecord = (AppRecord*)[entries objectAtIndex:indexPosition];
//        
//    }
    
    if (false ) //!appRecord || !appRecord.appIcon)
    {
//        if(!appRecord)
//        {
//            appRecord = [[[AppRecord alloc] init] autorelease];
//            appRecord.imageURLString = imgSrc;
//            [ entries setObject:appRecord atIndex:indexPosition];
//        }
//        
//        if (self.tblView.dragging == NO && self.tblView.decelerating == NO)
//        {
//            [self startIconDownload:appRecord forIndexPath:indexPath];
//        }
//        // if a download is deferred or in progress, return a placeholder image
//        cell.imageView.image = [UIImage imageNamed:@"Placeholder.png"];                
    }
    else
    {
        //cell.imageView.image = appRecord.appIcon;
    }
    
 //   [jsString release];
    
    return cell;
    
}


#pragma mark -
#pragma mark Table cell image support

//- (void)startIconDownload:(AppRecord *)appRecord forIndexPath:(NSIndexPath *)indexPath
//{
//    IconDownloader *iconDownloader = [imageDownloadsInProgress objectForKey:indexPath];
//    if (iconDownloader == nil)
//    {
//        iconDownloader = [[IconDownloader alloc] init];
//        iconDownloader.appRecord = appRecord;
//        iconDownloader.indexPathInTableView = indexPath;
//        iconDownloader.delegate = self;
//        [imageDownloadsInProgress setObject:iconDownloader forKey:indexPath];
//        [iconDownloader startDownload];
//        [iconDownloader release];
//    }
//}

// called by our ImageDownloader when an icon is ready to be displayed
- (void)appImageDidLoad:(NSIndexPath *)indexPath
{
//    IconDownloader *iconDownloader = [imageDownloadsInProgress objectForKey:indexPath];
//    if (iconDownloader != nil)
//    {
//        UITableViewCell *cell = [self.tblView cellForRowAtIndexPath:iconDownloader.indexPathInTableView];
//        
//        // Display the newly loaded image
//        cell.imageView.image = iconDownloader.appRecord.appIcon;
//    }
}


// this method is used in case the user scrolled into a set of cells that don't have their app icons yet
- (void)loadImagesForOnscreenRows
{
//    if ([self.entries count] > 0)
//    {
//        NSArray *visiblePaths = [self.tblView indexPathsForVisibleRows];
//        for (NSIndexPath *indexPath in visiblePaths)
//        {
//            AppRecord *appRecord = [self.entries objectAtIndex:indexPath.row];
//            
//            if (!appRecord.appIcon) // avoid the app icon download if the app already has an icon
//            {
//                [self startIconDownload:appRecord forIndexPath:indexPath];
//            }
//        }
//    }
}

// Load images for all onscreen rows when scrolling is finished
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        [self loadImagesForOnscreenRows];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
}



@end
