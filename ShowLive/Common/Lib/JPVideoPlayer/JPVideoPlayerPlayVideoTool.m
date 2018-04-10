/*
 * This file is part of the JPVideoPlayer package.
 * (c) NewPan <13246884282@163.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *
 * Click https://github.com/Chris-Pan
 * or http://www.jianshu.com/users/e2f2d779c022/latest_articles to contact me.
 */


#import "JPVideoPlayerPlayVideoTool.h"
#import "JPVideoPlayerResourceLoader.h"
#import "UIView+PlayerStatusAndDownloadIndicator.h"
#import "JPVideoPlayerDownloaderOperation.h"
#import "JPVideoPlayerCompat.h"
#import "UIView+WebVideoCache.h"

CGFloat const JPVideoPlayerLayerFrameY = 2.5;

@interface JPVideoPlayerPlayVideoToolItem()

/** 
 * The playing URL
 */
@property(nonatomic, strong, nullable)NSURL *url;

/**
 * The Player to play video.
 */
@property(nonatomic, strong, nullable)AVPlayer *player;

/**
 * The current player's layer.
 */
@property(nonatomic, strong, nullable)AVPlayerLayer *currentPlayerLayer;

/**
 * The current player's item.
 */
@property(nonatomic, strong, nullable)AVPlayerItem *currentPlayerItem;

/**
 * The current player's urlAsset.
 */
@property(nonatomic, strong, nullable)AVURLAsset *videoURLAsset;

/**
 * The view of the video picture will show on.
 */
@property(nonatomic, weak, nullable)UIView *unownShowView;

/**
 * A flag to book is cancel play or not.
 */
@property(nonatomic, assign, getter=isCancelled)BOOL cancelled;

/**
 * Error message.
 */
@property(nonatomic, strong, nullable)JPVideoPlayerPlayVideoToolErrorBlock error;

/**
 * The resourceLoader for the videoPlayer.
 */
@property(nonatomic, strong, nullable)JPVideoPlayerResourceLoader *resourceLoader;

/**
 * options
 */
@property(nonatomic, assign)JPVideoPlayerOptions playerOptions;

/**
 * The current playing url key.
 */
@property(nonatomic, strong, nonnull)NSString *playingKey;

/**
 * The last play time for player.
 */
@property(nonatomic, assign)NSTimeInterval lastTime;

/**
 * The play progress observer.
 */
@property(nonatomic, strong)id timeObserver;

@end

#define JPLog(FORMAT, ...); fprintf(stderr,"%s\n",[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
static NSString *JPVideoPlayerURLScheme = @"SystemCannotRecognition";
static NSString *JPVideoPlayerURL = @"www.newpan.com";
@implementation JPVideoPlayerPlayVideoToolItem

- (void)stopPlayVideo{
    
    self.cancelled = YES;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self.unownShowView performSelector:NSSelectorFromString(@"jp_hideProgressView")];
    [self.unownShowView performSelector:NSSelectorFromString(@"jp_hideActivityIndicatorView")];
#pragma clang diagnostic pop
    
    [self reset];
}

- (void)pausePlayVideo{
    if (!self.player) {
        return;
    }
    [self.player pause];
}

- (void)resumePlayVideo{
    if (!self.player) {
        return;
    }
    [self.player play];
}

- (void)reset{
    // remove video layer from superlayer.
    if (self.unownShowView.jp_backgroundLayer.superlayer) {
        [self.currentPlayerLayer removeFromSuperlayer];
        [self.unownShowView.jp_backgroundLayer removeFromSuperlayer];
    }
    
    // remove observer.
    JPVideoPlayerPlayVideoTool *tool = [JPVideoPlayerPlayVideoTool sharedTool];
    [_currentPlayerItem removeObserver:tool forKeyPath:@"status"];
    [_currentPlayerItem removeObserver:tool forKeyPath:@"loadedTimeRanges"];
    [self.player removeTimeObserver:self.timeObserver];
    
    // remove player
    [self.player pause];
    [self.player cancelPendingPrerolls];
    self.player = nil;
    [self.videoURLAsset.resourceLoader setDelegate:nil queue:dispatch_get_main_queue()];
    self.currentPlayerItem = nil;
    self.currentPlayerLayer = nil;
    self.videoURLAsset = nil;
    self.resourceLoader = nil;
}

@end


@interface JPVideoPlayerPlayVideoTool()

@property(nonatomic, strong, nonnull)NSMutableArray<JPVideoPlayerPlayVideoToolItem *> *playVideoItems;

/**
 * The playing status of video player before app enter background.
 */
@property(nonatomic, assign)JPVideoPlayerPlayingStatus playingStatus_beforeEnterBackground;

@end

@implementation JPVideoPlayerPlayVideoTool

+ (nonnull instancetype)sharedTool{
    static dispatch_once_t onceItem;
    static id instance;
    dispatch_once(&onceItem, ^{
        instance = [self new];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self addObserverOnce];
        _playVideoItems = [NSMutableArray array];
    }
    return self;
}


#pragma mark - Public

- (nullable JPVideoPlayerPlayVideoToolItem *)playExistedVideoWithURL:(NSURL * _Nullable)url fullVideoCachePath:(NSString * _Nullable)fullVideoCachePath options:(JPVideoPlayerOptions)options showOnView:(UIView * _Nullable)showView playingProgress:(JPVideoPlayerPlayVideoToolPlayingProgressBlock _Nullable )progress error:(nullable JPVideoPlayerPlayVideoToolErrorBlock)error{
    
    if (fullVideoCachePath.length==0) {
        if (error) error([NSError errorWithDomain:@"the file path is disable" code:0 userInfo:nil]);
        return nil;
    }
    
    if (!showView) {
        if (error) error([NSError errorWithDomain:@"the layer to display video layer is nil" code:0 userInfo:nil]);
        return nil;
    }
    
    JPVideoPlayerPlayVideoToolItem *item = [JPVideoPlayerPlayVideoToolItem new];
    item.unownShowView = showView;
    NSURL *videoPathURL = [NSURL fileURLWithPath:fullVideoCachePath];
    AVURLAsset *videoURLAsset = [AVURLAsset URLAssetWithURL:videoPathURL options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:videoURLAsset];
    {
        item.url = url;
        item.currentPlayerItem = playerItem;
        [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
        
        item.player = [AVPlayer playerWithPlayerItem:playerItem];
        item.currentPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:item.player];
        {
            NSString *videoGravity = AVLayerVideoGravityResizeAspectFill;
            if (options&JPVideoPlayerLayerVideoGravityResizeAspect) {
                videoGravity = AVLayerVideoGravityResizeAspect;
            }
            else if (options&JPVideoPlayerLayerVideoGravityResize){
                videoGravity = AVLayerVideoGravityResize;
            }
            else if (options&JPVideoPlayerLayerVideoGravityResizeAspectFill){
                videoGravity = AVLayerVideoGravityResizeAspectFill;
            }
            item.currentPlayerLayer.videoGravity = videoGravity;
        }
        
        item.unownShowView.jp_backgroundLayer.frame = CGRectMake(0, 0, showView.bounds.size.width, showView.bounds.size.height);
        item.currentPlayerLayer.frame = item.unownShowView.jp_backgroundLayer.bounds;
        item.error = error;
        item.playingKey = [[JPVideoPlayerManager sharedManager]cacheKeyForURL:url];
    }
    {
        // add observer for video playing progress.
        __weak typeof(item) wItem = item;
        [item.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 10.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time){
            __strong typeof(wItem) sItem = wItem;
            if (!sItem) return;
    
             float current = CMTimeGetSeconds(time);
             float total = CMTimeGetSeconds(sItem.currentPlayerItem.duration);
             if (current && progress) {
                 progress(current / total);
             }
         }];
    }
    
    if (options & JPVideoPlayerMutedPlay) {
        item.player.muted = YES;
    }
    
    @synchronized (self) {
        [self.playVideoItems addObject:item];
    }
    self.currentPlayVideoItem = item;
    
    return item;
}

- (nullable JPVideoPlayerPlayVideoToolItem *)playVideoWithURL:(NSURL * _Nullable)url tempVideoCachePath:(NSString * _Nullable)tempVideoCachePath options:(JPVideoPlayerOptions)options videoFileExceptSize:(NSUInteger)exceptSize videoFileReceivedSize:(NSUInteger)receivedSize showOnView:(UIView * _Nullable)showView playingProgress:(JPVideoPlayerPlayVideoToolPlayingProgressBlock _Nullable )progress error:(nullable JPVideoPlayerPlayVideoToolErrorBlock)error{
    
    if (tempVideoCachePath.length==0) {
        if (error) error([NSError errorWithDomain:@"the file path is disable" code:0 userInfo:nil]);
        return nil;
    }
    
    if (!showView) {
        if (error) error([NSError errorWithDomain:@"the layer to display video layer is nil" code:0 userInfo:nil]);
        return nil;
    }
    
    // Re-create all all configuration agian.
    // Make the `resourceLoader` become the delegate of 'videoURLAsset', and provide data to the player.
    
    JPVideoPlayerPlayVideoToolItem *item = [JPVideoPlayerPlayVideoToolItem new];
    item.unownShowView = showView;
    JPVideoPlayerResourceLoader *resourceLoader = [JPVideoPlayerResourceLoader new];
    item.resourceLoader = resourceLoader;
    AVURLAsset *videoURLAsset = [AVURLAsset URLAssetWithURL:[self handleVideoURL] options:nil];
    [videoURLAsset.resourceLoader setDelegate:resourceLoader queue:dispatch_get_main_queue()];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:videoURLAsset];
    {
        item.url = url;
        item.currentPlayerItem = playerItem;
        [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
        
        item.player = [AVPlayer playerWithPlayerItem:playerItem];
        item.currentPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:item.player];
        {
            NSString *videoGravity = nil;
            if (options&JPVideoPlayerLayerVideoGravityResizeAspect) {
                videoGravity = AVLayerVideoGravityResizeAspect;
            }
            else if (options&JPVideoPlayerLayerVideoGravityResize){
                videoGravity = AVLayerVideoGravityResize;
            }
            else if (options&JPVideoPlayerLayerVideoGravityResizeAspectFill){
                videoGravity = AVLayerVideoGravityResizeAspectFill;
            }
            item.currentPlayerLayer.videoGravity = videoGravity;
        }
        {
            // add observer for video playing progress.
            __weak typeof(item) wItem = item;
            [item.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 10.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time){
                __strong typeof(wItem) sItem = wItem;
                if (!sItem) return;
                
                float current = CMTimeGetSeconds(time);
                float total = CMTimeGetSeconds(sItem.currentPlayerItem.duration);
                if (current && progress) {
                    progress(current / total);
                }
            }];
        }
        item.unownShowView.jp_backgroundLayer.frame = CGRectMake(0, 0, showView.bounds.size.width, showView.bounds.size.height);
        item.currentPlayerLayer.frame = item.unownShowView.jp_backgroundLayer.bounds;
        item.videoURLAsset = videoURLAsset;
        item.error = error;
        item.playerOptions = options;
        item.playingKey = [[JPVideoPlayerManager sharedManager]cacheKeyForURL:url];
    }
    self.currentPlayVideoItem = item;
    
    if (options & JPVideoPlayerMutedPlay) {
        item.player.muted = YES;
    }
    
    @synchronized (self) {
        [self.playVideoItems addObject:item];
    }
    self.currentPlayVideoItem = item;
    
    // play.
    [self.currentPlayVideoItem.resourceLoader didReceivedDataCacheInDiskByTempPath:tempVideoCachePath videoFileExceptSize:exceptSize videoFileReceivedSize:receivedSize];
    
    return item;
}

- (void)didReceivedDataCacheInDiskByTempPath:(NSString * _Nonnull)tempCacheVideoPath videoFileExceptSize:(NSUInteger)expectedSize videoFileReceivedSize:(NSUInteger)receivedSize{
    [self.currentPlayVideoItem.resourceLoader didReceivedDataCacheInDiskByTempPath:tempCacheVideoPath videoFileExceptSize:expectedSize videoFileReceivedSize:receivedSize];
}

- (void)didCachedVideoDataFinishedFromWebFullVideoCachePath:(NSString * _Nullable)fullVideoCachePath{
    if (self.currentPlayVideoItem.resourceLoader) {
        [self.currentPlayVideoItem.resourceLoader didCachedVideoDataFinishedFromWebFullVideoCachePath:fullVideoCachePath];
    }
}

- (void)setMute:(BOOL)mute{
    self.currentPlayVideoItem.player.muted = mute;
}

- (void)stopPlay{
    self.currentPlayVideoItem = nil;
    for (JPVideoPlayerPlayVideoToolItem *item in self.playVideoItems) {
        [item stopPlayVideo];
    }
    @synchronized (self) {
        if (self.playVideoItems)
            [self.playVideoItems removeAllObjects];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(playVideoTool:playingStatuDidChanged:)]) {
        [self.delegate playVideoTool:self playingStatuDidChanged:JPVideoPlayerPlayingStatusStop];
    }
}

- (void)pause{
    [self.currentPlayVideoItem pausePlayVideo];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(playVideoTool:playingStatuDidChanged:)]) {
        [self.delegate playVideoTool:self playingStatuDidChanged:JPVideoPlayerPlayingStatusPause];
    }
}

- (void)resume{
    [self.currentPlayVideoItem resumePlayVideo];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(playVideoTool:playingStatuDidChanged:)]) {
        [self.delegate playVideoTool:self playingStatuDidChanged:JPVideoPlayerPlayingStatusPlaying];
    }
}


#pragma mark - App Observer

- (void)addObserverOnce{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterPlayGround) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidPlayToEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appReceivedMemoryWarning) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startDownload) name:JPVideoPlayerDownloadStartNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishedDownload) name:JPVideoPlayerDownloadFinishNotification object:nil];
}

- (void)appReceivedMemoryWarning{
    [self.currentPlayVideoItem stopPlayVideo];
}

- (void)appDidEnterBackground{
    [self.currentPlayVideoItem pausePlayVideo];
    if (self.currentPlayVideoItem.unownShowView) {
        self.playingStatus_beforeEnterBackground = self.currentPlayVideoItem.unownShowView.playingStatus;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(playVideoTool:playingStatuDidChanged:)]) {
        [self.delegate playVideoTool:self playingStatuDidChanged:JPVideoPlayerPlayingStatusPause];
    }
}

- (void)appDidEnterPlayGround{
    // fixed #35.
    if (self.currentPlayVideoItem.unownShowView && (self.playingStatus_beforeEnterBackground == JPVideoPlayerPlayingStatusPlaying)) {
        [self.currentPlayVideoItem resumePlayVideo];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(playVideoTool:playingStatuDidChanged:)]) {
            [self.delegate playVideoTool:self playingStatuDidChanged:JPVideoPlayerPlayingStatusPlaying];
        }
    }
    else{
        [self.currentPlayVideoItem pausePlayVideo];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(playVideoTool:playingStatuDidChanged:)]) {
            [self.delegate playVideoTool:self playingStatuDidChanged:JPVideoPlayerPlayingStatusPause];
        }
    }
}


#pragma mark - AVPlayer Observer

- (void)playerItemDidPlayToEnd:(NSNotification *)notification{
    
    // ask need automatic replay or not.
    if (self.delegate && [self.delegate respondsToSelector:@selector(playVideoTool:shouldAutoReplayVideoForURL:)]) {
        if (![self.delegate playVideoTool:self shouldAutoReplayVideoForURL:self.currentPlayVideoItem.url]) {
            return;
        }
    }
    
    // Seek the start point of file data and repeat play, this handle have no memory surge.
    __weak typeof(self.currentPlayVideoItem) weak_Item = self.currentPlayVideoItem;
    if (self.currentPlayVideoItem.currentPlayerItem.status == AVPlayerItemStatusReadyToPlay) {
        [self.currentPlayVideoItem.player seekToTime:CMTimeMake(0, 1) completionHandler:^(BOOL finished) {
            __strong typeof(weak_Item) strong_Item = weak_Item;
            if (!strong_Item) return;
            
            self.currentPlayVideoItem.lastTime = 0;
            [strong_Item.player play];
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(playVideoTool:playingStatuDidChanged:)]) {
                [self.delegate playVideoTool:self playingStatuDidChanged:JPVideoPlayerPlayingStatusPlaying];
            }
        }];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItem *playerItem = (AVPlayerItem *)object;
        AVPlayerItemStatus status = playerItem.status;
        switch (status) {
            case AVPlayerItemStatusUnknown:{
                if (self.delegate && [self.delegate respondsToSelector:@selector(playVideoTool:playingStatuDidChanged:)]) {
                    [self.delegate playVideoTool:self playingStatuDidChanged:JPVideoPlayerPlayingStatusUnkown];
                }
            }
                break;
                
            case AVPlayerItemStatusReadyToPlay:{
                
                // When get ready to play note, we can go to play, and can add the video picture on show view.
                if (!self.currentPlayVideoItem) return;
                
                [self.currentPlayVideoItem.player play];
                [self hideActivaityIndicatorView];
                
                [self displayVideoPicturesOnShowLayer];
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(playVideoTool:playingStatuDidChanged:)]) {
                    [self.delegate playVideoTool:self playingStatuDidChanged:JPVideoPlayerPlayingStatusPlaying];
                }
            }
                break;
                
            case AVPlayerItemStatusFailed:{
                [self hideActivaityIndicatorView];
                
                if (self.currentPlayVideoItem.error) self.currentPlayVideoItem.error([NSError errorWithDomain:@"Some errors happen on player" code:0 userInfo:nil]);
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(playVideoTool:playingStatuDidChanged:)]) {
                    [self.delegate playVideoTool:self playingStatuDidChanged:JPVideoPlayerPlayingStatusFailed];
                }
            }
                break;
            default:
                break;
        }
    }
    else if ([keyPath isEqualToString:@"loadedTimeRanges"]){
        // It means player buffering if the player time don't change,
        // else if the player time plus than before, it means begain play.
        // fixed #28.
        NSTimeInterval currentTime = CMTimeGetSeconds(self.currentPlayVideoItem.player.currentTime);
        // JPLog(@"%f", currentTime)
        
        if (currentTime != 0 && currentTime > self.currentPlayVideoItem.lastTime) {
            [self hideActivaityIndicatorView];
            self.currentPlayVideoItem.lastTime = currentTime;
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(playVideoTool:playingStatuDidChanged:)]) {
                [self.delegate playVideoTool:self playingStatuDidChanged:JPVideoPlayerPlayingStatusPlaying];
            }
        }
        else{
            [self showActivaityIndicatorView];
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(playVideoTool:playingStatuDidChanged:)]) {
                [self.delegate playVideoTool:self playingStatuDidChanged:JPVideoPlayerPlayingStatusBuffering];
            }
        }
    }
}


#pragma mark - Private

- (void)startDownload{
    [self showActivaityIndicatorView];
}

- (void)finishedDownload{
    [self hideActivaityIndicatorView];
}

- (void)showActivaityIndicatorView{
    if (self.currentPlayVideoItem.playerOptions&JPVideoPlayerShowActivityIndicatorView){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.currentPlayVideoItem.unownShowView performSelector:NSSelectorFromString(@"jp_showActivityIndicatorView")];
#pragma clang diagnostic pop
    }
}

- (void)hideActivaityIndicatorView{
    if (self.currentPlayVideoItem.playerOptions&JPVideoPlayerShowActivityIndicatorView){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.currentPlayVideoItem.unownShowView performSelector:NSSelectorFromString(@"jp_hideActivityIndicatorView")];
#pragma clang diagnostic pop
    }
}

- (void)setCurrentPlayVideoItem:(JPVideoPlayerPlayVideoToolItem *)currentPlayVideoItem{
    [self willChangeValueForKey:@"currentPlayVideoItem"];
    _currentPlayVideoItem = currentPlayVideoItem;
    [self didChangeValueForKey:@"currentPlayVideoItem"];
}

- (NSURL *)handleVideoURL{
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:[NSURL URLWithString:JPVideoPlayerURL] resolvingAgainstBaseURL:NO];
    components.scheme = JPVideoPlayerURLScheme;
    return [components URL];
}

- (void)displayVideoPicturesOnShowLayer{
    if (!self.currentPlayVideoItem.isCancelled) {
        // fixed #26.
        [self.currentPlayVideoItem.unownShowView.jp_backgroundLayer addSublayer:self.currentPlayVideoItem.currentPlayerLayer];
    }
}

@end
