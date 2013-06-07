//
//  ViewController.h
//  MakeItCaine
//
//  Created by Robert Richey on 5/30/13.
//  Copyright (c) 2013 Robert Richey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <iAd/iAd.h>

@interface ViewController : UIViewController <ADBannerViewDelegate>
{
    
}

- (IBAction)playSound:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *caineButton;

@property (nonatomic) UInt32 PlayingSoundID;
extern BOOL _IsPlaying;

void SoundCompletionProc (SystemSoundID ssID, void *clientData );
void changeButtonColor(UIButton *button, UIColor *newColor);
@end
