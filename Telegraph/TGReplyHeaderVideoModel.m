#import "TGReplyHeaderVideoModel.h"

#import <LegacyComponents/LegacyComponents.h>

#import "TGSharedMediaSignals.h"
#import "TGSharedVideoSignals.h"
#import "TGSharedMediaUtils.h"

#import "TGSignalImageViewModel.h"
#import "TGModernImageViewModel.h"

@interface TGReplyHeaderVideoModel ()
{
}

@end

@implementation TGReplyHeaderVideoModel

- (instancetype)initWithPeer:(id)peer videoMedia:(TGVideoMediaAttachment *)videoMedia incoming:(bool)incoming system:(bool)system presentation:(TGPresentation *)presentation
{
    NSString *title = videoMedia.roundMessage ? TGLocalized(@"Message.VideoMessage") : TGLocalized(@"Message.Video");
    
    CGFloat roundRadius = 16.5f;
    CGFloat cornerRadius = videoMedia.roundMessage ? roundRadius : [TGReplyHeaderModel thumbnailCornerRadius];
    self = [super initWithPeer:peer incoming:incoming text:title imageSignalGenerator:videoMedia == nil ? nil : ^SSignal *
    {
        return [TGSharedVideoSignals squareVideoThumbnail:videoMedia ofSize:CGSizeMake(33.0f, 33.0f) threadPool:[TGSharedMediaUtils sharedMediaImageProcessingThreadPool] memoryCache:[TGSharedMediaUtils sharedMediaMemoryImageCache] pixelProcessingBlock:[TGSharedMediaSignals pixelProcessingBlockForRoundCornersOfRadius:cornerRadius]];
    } imageSignalIdentifier:[[NSString alloc] initWithFormat:@"reply-video-%@-%" PRId64 "", videoMedia.videoId != 0 ? @"remote" : @"local", videoMedia.videoId != 0 ? videoMedia.videoId : videoMedia.localVideoId] icon:nil truncateTextInTheMiddle:false system:system presentation:presentation];
    if (self != nil)
    {
    }
    return self;
}

@end
