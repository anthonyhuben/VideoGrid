#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, WKUIDelegate, WKNavigationDelegate, WKDownloadDelegate>

@property (nonatomic, strong) NSWindow *window;
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    NSSize windowSize = NSMakeSize(1280, 820);
    NSRect frame = NSMakeRect(0, 0, windowSize.width, windowSize.height);
    self.window = [[NSWindow alloc] initWithContentRect:frame
                                               styleMask:(NSWindowStyleMaskTitled |
                                                          NSWindowStyleMaskResizable |
                                                          NSWindowStyleMaskClosable |
                                                          NSWindowStyleMaskMiniaturizable)
                                                 backing:NSBackingStoreBuffered
                                                   defer:NO];
    [self.window setTitle:@"Video Grid"];
    [self.window center];

    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    self.webView = [[WKWebView alloc] initWithFrame:self.window.contentView.bounds
                                        configuration:configuration];
    self.webView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;

    NSURL *htmlURL = [[NSBundle mainBundle] URLForResource:@"VideoGrid" withExtension:@"html"];
    if (htmlURL) {
        [self.webView loadFileURL:htmlURL allowingReadAccessToURL:[htmlURL URLByDeletingLastPathComponent]];
    } else {
        NSTextField *message = [NSTextField labelWithString:@"Failed to locate VideoGrid.html inside the app bundle."];
        message.alignment = NSTextAlignmentCenter;
        message.frame = self.webView.bounds;
        message.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
        [self.webView addSubview:message];
    }

    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    self.window.contentView = self.webView;
    [self.window makeKeyAndOrderFront:nil];
    [NSApp activateIgnoringOtherApps:YES];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

// Enable <input type="file"> in WKWebView by presenting an NSOpenPanel.
- (void)webView:(WKWebView *)webView runOpenPanelWithParameters:(WKOpenPanelParameters *)parameters initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSArray<NSURL *> *urls))completionHandler {
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    openPanel.canChooseFiles = YES;
    openPanel.canChooseDirectories = parameters.allowsDirectories;
    openPanel.allowsMultipleSelection = parameters.allowsMultipleSelection;
    openPanel.allowsOtherFileTypes = NO;

    [openPanel beginSheetModalForWindow:self.window completionHandler:^(NSModalResponse result) {
        if (result == NSModalResponseOK) {
            completionHandler(openPanel.URLs);
        } else {
            completionHandler(@[]);
        }
    }];
}

// Route <a download> requests from WKWebView into WKDownload.
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if (@available(macOS 11.3, *)) {
        if (navigationAction.shouldPerformDownload) {
            decisionHandler(WKNavigationActionPolicyDownload);
            return;
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (NSURL *)uniqueDownloadURLForSuggestedFilename:(NSString *)suggestedFilename API_AVAILABLE(macos(11.3)) {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *downloadsDir = [[fileManager URLsForDirectory:NSDownloadsDirectory inDomains:NSUserDomainMask] firstObject];
    if (!downloadsDir) {
        return nil;
    }

    NSString *filename = (suggestedFilename.length > 0) ? suggestedFilename : @"VideoGrid_grid.png";
    NSURL *candidate = [downloadsDir URLByAppendingPathComponent:filename];
    if (![fileManager fileExistsAtPath:candidate.path]) {
        return candidate;
    }

    NSString *base = [filename stringByDeletingPathExtension];
    NSString *ext = [filename pathExtension];
    for (NSInteger i = 1; i < 1000; i++) {
        NSString *nextName = ext.length > 0
            ? [NSString stringWithFormat:@"%@-%ld.%@", base, (long)i, ext]
            : [NSString stringWithFormat:@"%@-%ld", base, (long)i];
        NSURL *nextCandidate = [downloadsDir URLByAppendingPathComponent:nextName];
        if (![fileManager fileExistsAtPath:nextCandidate.path]) {
            return nextCandidate;
        }
    }

    return candidate;
}

- (void)webView:(WKWebView *)webView navigationAction:(WKNavigationAction *)navigationAction didBecomeDownload:(WKDownload *)download API_AVAILABLE(macos(11.3)) {
    download.delegate = self;
}

- (void)webView:(WKWebView *)webView navigationResponse:(WKNavigationResponse *)navigationResponse didBecomeDownload:(WKDownload *)download API_AVAILABLE(macos(11.3)) {
    download.delegate = self;
}

- (void)download:(WKDownload *)download decideDestinationUsingResponse:(NSURLResponse *)response suggestedFilename:(NSString *)suggestedFilename completionHandler:(void (^)(NSURL * _Nullable destination))completionHandler API_AVAILABLE(macos(11.3)) {
    NSURL *destination = [self uniqueDownloadURLForSuggestedFilename:suggestedFilename];
    completionHandler(destination);
}

- (void)downloadDidFinish:(WKDownload *)download API_AVAILABLE(macos(11.3)) {
    NSLog(@"Download finished.");
}

- (void)download:(WKDownload *)download didFailWithError:(NSError *)error resumeData:(NSData *)resumeData API_AVAILABLE(macos(11.3)) {
    NSLog(@"Download failed: %@", error.localizedDescription);
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        AppDelegate *delegate = [[AppDelegate alloc] init];
        [NSApplication sharedApplication].delegate = delegate;
        return NSApplicationMain(argc, argv);
    }
}
