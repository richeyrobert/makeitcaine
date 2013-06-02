//
//  ViewController.m
//  MakeItCaine
//
//  Created by Robert Richey on 5/30/13.
//  Copyright (c) 2013 Robert Richey. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController
//@synthesize IsPlaying = _IsPlaying;
@synthesize PlayingSoundID;
BOOL *_IsPlaying = false;
- (void)viewDidLoad
{
        [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _IsPlaying = false;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
  
- (IBAction)playSound:(id)sender {
    if (_IsPlaying == false) {
        _IsPlaying = true;
        CFBundleRef mainBundle = CFBundleGetMainBundle();
        CFURLRef soundFileURLRef;
        soundFileURLRef = CFBundleCopyResourceURL(mainBundle, (CFStringRef) @"makeitcaine", CFSTR ("wav"), NULL);
        
        UInt32 soundID;
        AudioServicesCreateSystemSoundID(soundFileURLRef, &soundID);
        AudioServicesAddSystemSoundCompletion (soundID,NULL,NULL,SoundCompletionProc, nil);
        AudioServicesPlaySystemSound(soundID);
        PlayingSoundID = soundID;
        // attempt to set the IsPlaying variable back to false when the music is done playing
        
    }
    else {
        AudioServicesDisposeSystemSoundID(PlayingSoundID);
        _IsPlaying = false;
    }
    
}
- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [banner setAlpha:1];
    [UIView commitAnimations];
}

- (void) bannerView:(ADBannerView *) banner didFailToReceiveAdWithError:(NSError *)error {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [banner setAlpha:0];
    [UIView commitAnimations];
}

void SoundCompletionProc (SystemSoundID  ssID, void *data ) {
    
    _IsPlaying = false;
}
@end
