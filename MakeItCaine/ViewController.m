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
@synthesize caineButton;

BOOL _IsPlaying = false;
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
        AudioServicesAddSystemSoundCompletion (soundID,NULL,NULL,SoundCompletionProc, (__bridge void *)(self.caineButton));
        AudioServicesPlaySystemSound(soundID);
        PlayingSoundID = soundID;
        //Change button color
        UIButton *button = (UIButton *)sender;
        [self performSelector:@selector(doHighlight:) withObject:sender afterDelay:0];
        NSString * myTitle = @"Making it Caine!";
        [button setTitle:myTitle forState:UIControlStateNormal];
    }
    else {
        AudioServicesDisposeSystemSoundID(PlayingSoundID);
        _IsPlaying = false;
        [caineButton setHighlighted:false];
        [caineButton setTitle:@"Make it Caine!" forState:UIControlStateNormal];
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

- (void)doHighlight:(UIButton*)b {
    [b setHighlighted:YES];
}

void SoundCompletionProc (SystemSoundID  ssID, void *button ) {
    
    _IsPlaying = false;
    //try to change back the title of the button here.
    UIButton *mybutton = (__bridge UIButton *)(button);
    [mybutton setHighlighted:false];
    [mybutton setTitle:@"Make it Caine!" forState:UIControlStateNormal];

}


@end
