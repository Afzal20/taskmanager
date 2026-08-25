afzal  home  dev-dir  taskmanager-android  main ↑3    
❯  flutter run -d R58R51WVZAR 
Launching lib/main.dart on SM M215F in debug mode... 
Warning: Flutter support for your project's Kotlin version (2.2.20) will soon be dropped. Please upgrade your Kotlin version to a version of at least 2.3.20 soon. 
Alternatively, use the flag "--android-skip-build-dependency-validation" to bypass this check. 
 
Potential fix: Your project's KGP version is typically defined in the plugins block of the \`settings.gradle\` file (/home/dev-dir/taskmanager-android/android/settings.gradle), by a plugin with the id of org.jetbrains.kotlin.android.  
If you don't see a plugins block, your project was likely created with an older template version, in which case it is most likely defined in the top-level build.gradle file (/home/dev-dir/taskmanager-android/android/build.gradle) by the
 ext.kotlin\_version property. 
 
WARNING: Your Android app project: app located at: /home/dev-dir/taskmanager-android/android/app/build.gradle.kts 
applies the Kotlin Gradle Plugin, which will cause build failures in future versions of Flutter. 
Please migrate your app to Built-in Kotlin using this guide: https\://docs.flutter.dev/release/breaking-changes/migrate-to-built-in-kotlin/for-app-developers 
 
Running Gradle task 'assembleDebug'...                             72.9s 
**✓** Built build/app/outputs/flutter-apk/app-debug.apk 
Installing build/app/outputs/flutter-apk/app-debug.apk...          67.2s 
I/FlutterActivityAndFragmentDelegate(12314): If you are attempting to set --enable-dart-profiling via Intent extras to launch a Flutter component outside of using the Flutter CLI, note that support for setting engine flags on Android vi
a Intent will soon be dropped; see https\://github.com/flutter/flutter/issues/180686 for more information on this breaking change. To migrate, set --enable-dart-profiling or any other flags specified via Intent extras on the command line
 instead or see https\://github.com/flutter/flutter/blob/main/docs/engine/Flutter-Android-Engine-Flags.md for alternative methods. 
D/FlutterJNI(12314): Beginning load of flutter... 
D/FlutterJNI(12314): flutter (null) was loaded normally! 
I/flutter (12314): [IMPORTANT\:flutter/shell/platform/android/android\_context\_gl\_impeller.cc(104)] Using the Impeller rendering backend (OpenGLES). 
D/FlutterRenderer(12314): Width is zero. 0,0 
Syncing files to device SM M215F...                                 58ms 
 
Flutter run key commands. 
**r** Hot reload. 🔥🔥🔥 
**R** Hot restart. 
**h** List all available interactive commands. 
**d** Detach (terminate "flutter run" but leave application running). 
**c** Clear the screen 
**q** Quit (terminate the application on the device). 
 
A Dart VM Service on SM M215F is available at: http\://127.0.0.1:37665/jZ91-24Qq2o=/ 
The Flutter DevTools debugger and profiler on SM M215F is available at: http\://127.0.0.1:37665/jZ91-24Qq2o=/devtools/?uri=ws\://127.0.0.1:37665/jZ91-24Qq2o=/ws 
I/flutter (12314): unhandled element \<filter/>; Picture key: Svg loader 
I/Choreographer(12314): Skipped 286 frames!  The application may be doing too much work on its main thread. 
I/alhossen.taskl(12314): Compiler allocated 4420KB to compile void android.view\.ViewRootImpl.performTraversals() 
I/SurfaceView\@9e2187c(12314): onWindowVisibilityChanged(0) true io.flutter.embedding.android.FlutterSurfaceView{9e2187c V.E...... ......I. 0,0-0,0} of ViewRootImpl\@33eb480[MainActivity] 
D/FlutterRenderer(12314): Width is zero. 0,0 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): Relayout returned: old=(0,0,1080,2340) new=(0,0,1080,2340) req=(1080,2340)0 dur=12 res=0x7 s={true 517612462080} ch=true fn=-1 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
D/hw-ProcessState(12314): Binder ioctl to enable oneway spam detection failed: Invalid argument 
D/OpenGLRenderer(12314): eglCreateWindowSurface 
I/SurfaceView\@9e2187c(12314): windowStopped(false) true io.flutter.embedding.android.FlutterSurfaceView{9e2187c V.E...... ......ID 0,0-1080,2214} of ViewRootImpl\@33eb480[MainActivity] 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): [DP] dp(1) 1 android.view\.ViewRootImpl.reportNextDraw:11442 android.view\.ViewRootImpl.performTraversals:4198 android.view\.ViewRootImpl.doTraversal:2924  
I/SurfaceView\@9e2187c(12314): pST: sr = Rect(0, 0 - 1080, 2214) sw = 1080 sh = 2214 
I/SurfaceView\@9e2187c(12314): onSSPAndSRT: pl = 0 pt = 0 sx = 1.0 sy = 1.0 
I/SurfaceView\@9e2187c(12314): pST: mTmpTransaction.apply, mTmpTransaction = android.view\.SurfaceControl$Transaction\@b1d5912 
I/SurfaceView\@9e2187c(12314): updateSurface: mVisible = true mSurface.isValid() = true 
I/SurfaceView\@9e2187c(12314): updateSurface: mSurfaceCreated = false surfaceChanged = true visibleChanged = true 
I/SurfaceView\@9e2187c(12314): surfaceCreated 1 #8 io.flutter.embedding.android.FlutterSurfaceView{9e2187c V.E...... ......ID 0,0-1080,2214} 
I/SurfaceView\@9e2187c(12314): surfaceChanged (1080,2214) 1 #8 io.flutter.embedding.android.FlutterSurfaceView{9e2187c V.E...... ......ID 0,0-1080,2214} 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): [DP] dp(2) 1 android.view\.SurfaceView\.updateSurface:1375 android.view\.SurfaceView\.lambda$new$1$SurfaceView:254 android.view\.SurfaceView$$ExternalSyntheticLambda2.onPreDraw:2  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): [DP] cancelDraw null isViewVisible: true 
I/Gralloc4(12314): mapper 4.x is not supported 
W/Gralloc3(12314): mapper 3.x is not supported 
I/gralloc (12314): Arm Module v1.0 
W/Gralloc4(12314): allocator 4.x is not supported 
W/Gralloc3(12314): allocator 3.x is not supported 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): [DP] pdf(1) 1 android.view\.SurfaceView\.notifyDrawFinished:599 android.view\.SurfaceView\.performDrawFinished:586 android.view\.SurfaceView.$r8$lambda$st27mCkd9jfJkTrN\_P3qIGKX6NY:0  
D/ViewRootImpl\@33eb480[MainActivity]\(12314): pendingDrawFinished. Waiting on draw reported mDrawsNeededToReport=1 
I/Choreographer(12314): Skipped 178 frames!  The application may be doing too much work on its main thread. 
D/ViewRootImpl\@33eb480[MainActivity]\(12314): Creating frameDrawingCallback nextDrawUseBlastSync=false reportNextDraw=true hasBlurUpdates=false 
D/ViewRootImpl\@33eb480[MainActivity]\(12314): Creating frameCompleteCallback 
I/SurfaceView\@9e2187c(12314): uSP: rtp = Rect(0, 0 - 1080, 2214) rtsw = 1080 rtsh = 2214 
D/ViewRootImpl\@33eb480[MainActivity]\(12314): Received frameDrawingCallback frameNum=1. Creating transactionCompleteCallback=false 
I/SurfaceView\@9e2187c(12314): onSSPAndSRT: pl = 0 pt = 0 sx = 1.0 sy = 1.0 
I/SurfaceView\@9e2187c(12314): aOrMT: uB = true t = android.view\.SurfaceControl$Transaction\@28e98e3 fN = 1 android.view\.SurfaceView\.access$500:124 android.view\.SurfaceView$SurfaceViewPositionUpdateListener.positionChanged:1728 android.gr
aphics.RenderNode$CompositePositionUpdateListener.positionChanged:319  
I/SurfaceView\@9e2187c(12314): aOrMT: vR.mWNT, vR = ViewRootImpl\@33eb480[MainActivity] 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@28e98e3 fN = 1 android.view\.SurfaceView\.applyOrMergeTransaction:1628 android.view\.SurfaceView\.access$500:124 android.view\.SurfaceView$Surface
ViewPositionUpdateListener.positionChanged:1728  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/ViewRootImpl\@33eb480[MainActivity]\(12314): Received frameCompleteCallback  lastAcquiredFrameNum=1 lastAttemptedDrawFrameNum=1 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): [DP] pdf(0) 1 android.view\.ViewRootImpl.lambda$addFrameCompleteCallbackIfNeeded$3$ViewRootImpl:5000 android.view\.ViewRootImpl$$ExternalSyntheticLambda16.run:6 android.os.Handler.handleCallbac
k:938  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): [DP] rdf() 
D/ViewRootImpl\@33eb480[MainActivity]\(12314): reportDrawFinished (fn: -1)  
I/OpenGLRenderer(12314): Davey! duration=3010ms; Flags=1, FrameTimelineVsyncId=5596603, IntendedVsync=82373155536436, Vsync=82376122202984, InputEventId=0, HandleInputStart=82376132369656, AnimationStart=82376132379079, PerformTraversal
sStart=82376132388425, DrawStart=82376134685502, FrameDeadline=82373172203102, FrameInterval=82376132203118, FrameStartTime=16666666, SyncQueued=82376137854694, SyncStart=82376138158694, IssueDrawCommandsStart=82376139348464, SwapBuffer
s=82376161773579, FrameCompleted=82376166470579, DequeueBufferDuration=2534346, QueueBufferDuration=2582577, GpuCompleted=82376164321425, SwapBuffersCompleted=82376166470579, DisplayPresentTime=0,  
D/InsetsSourceConsumer(12314): ensureControlAlpha: for ITYPE\_NAVIGATION\_BAR on com.afzalhossen.taskly/com.afzalhossen.taskly.MainActivity 
D/InsetsSourceConsumer(12314): ensureControlAlpha: for ITYPE\_STATUS\_BAR on com.afzalhossen.taskly/com.afzalhossen.taskly.MainActivity 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): MSG\_WINDOW\_FOCUS\_CHANGED 1 1 
D/InputMethodManager(12314): startInputInner - Id : 0 
I/InputMethodManager(12314): startInputInner - mService.startInputOrWindowGainedFocus 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
D/InputMethodManager(12314): startInputInner - Id : 0 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
D/ProfileInstaller(12314): Installing profile for com.afzalhossen.taskly 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/IMM\_LC  (12314): showSoftInput(View,I) 
I/IMM\_LC  (12314): ssi() - flag : 0 view : com.afzalhossen.taskly reason = SHOW\_SOFT\_INPUT 
I/IMM\_LC  (12314): ssi() view is not EditText 
D/InputMethodManager(12314): startInputInner - Id : 0 
I/InputMethodManager(12314): startInputInner - mService.startInputOrWindowGainedFocus 
D/InputConnectionAdaptor(12314): The input method toggled cursor monitoring on 
D/InsetsController(12314): show(ime(), fromIme=true) 
D/InsetsSourceConsumer(12314): setRequestedVisible: visible=true, type=19, host=com.afzalhossen.taskly/com.afzalhossen.taskly.MainActivity, from=android.view\.InsetsSourceConsumer.show:246 android.view\.InsetsController.showDirectly:1489 
android.view\.InsetsController.controlAnimationUnchecked:1137 android.view\.InsetsController.applyAnimation:1456 android.view\.InsetsController.applyAnimation:1437 android.view\.InsetsController.show:976 android.view\.ViewRootImpl$ViewRootHa
ndler.handleMessageImpl:6483 android.view\.ViewRootImpl$ViewRootHandler.handleMessage:6408 android.os.Handler.dispatchMessage:106 android.os.Looper.loopOnce:226  
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@d4d9879 fN = 5 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$scheduleA
pply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@4fa6a1f fN = 6 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$scheduleA
pply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@deed16c fN = 7 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$scheduleA
pply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@8064335 fN = 8 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$scheduleA
pply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@322f3ca fN = 9 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$scheduleA
pply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@465893b fN = 10 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@dad9858 fN = 11 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@364ddb1 fN = 12 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@5648296 fN = 13 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@1997e17 fN = 14 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@f8fe204 fN = 15 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@a38a3ed fN = 16 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@25e3222 fN = 17 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/InputTransport(12314): Input channel destroyed: 'ClientS', fd=173 
I/alhossen.taskl(12314): Thread[2,tid=12317,WaitingInMainSignalCatcherLoop,Thread\*=0x788dc0e000,peer=0x27002c0,"Signal Catcher"]: reacting to signal 10 
I/alhossen.taskl(12314):  
I/alhossen.taskl(12314): SIGUSR1 forcing GC (no HPROF) and profile save 
I/alhossen.taskl(12314): Explicit concurrent copying GC freed 67KB AllocSpace bytes, 0(0B) LOS objects, 69% free, 2706KB/8850KB, paused 153us,95us total 55.238ms 
W/alhossen.taskl(12314): Failed to flush directory /data/misc/profiles/cur/0/com.afzalhossen.taskly: Permission denied 
D/[secipm]\(12314): mSecIpmManager setProfileLength com.afzalhossen.taskly profile:2496 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
D/InputMethodManager(12314): startInputInner - Id : 0 
I/InputMethodManager(12314): startInputInner - mService.startInputOrWindowGainedFocus 
I/IMM\_LC  (12314): showSoftInput(View,I) 
I/IMM\_LC  (12314): ssi() - flag : 0 view : com.afzalhossen.taskly reason = SHOW\_SOFT\_INPUT 
I/IMM\_LC  (12314): ssi() view is not EditText 
D/InputConnectionAdaptor(12314): The input method toggled cursor monitoring on 
D/InputConnectionAdaptor(12314): The input method toggled cursor monitoring off 
D/InputConnectionAdaptor(12314): The input method toggled cursor monitoring on 
D/InsetsController(12314): show(ime(), fromIme=true) 
D/InsetsController(12314): show(ime(), fromIme=true) 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
D/InputMethodManager(12314): startInputInner - Id : 0 
I/InputMethodManager(12314): startInputInner - mService.startInputOrWindowGainedFocus 
I/IMM\_LC  (12314): showSoftInput(View,I) 
I/IMM\_LC  (12314): ssi() - flag : 0 view : com.afzalhossen.taskly reason = SHOW\_SOFT\_INPUT 
I/IMM\_LC  (12314): ssi() view is not EditText 
D/InputConnectionAdaptor(12314): The input method toggled cursor monitoring on 
D/InputConnectionAdaptor(12314): The input method toggled cursor monitoring off 
D/InputConnectionAdaptor(12314): The input method toggled cursor monitoring on 
D/InsetsController(12314): show(ime(), fromIme=true) 
D/InsetsController(12314): show(ime(), fromIme=true) 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/IMM\_LC  (12314): hsifw() - flags=0, caller=android.view\.inputmethod.InputMethodManager.hideSoftInputFromWindow:1858 android.view\.inputmethod.InputMethodManager.hideSoftInputFromWindow:1827 io.flutter.plugin.editing.TextInputPlugin.hid
eTextInput:447 io.flutter.plugin.editing.TextInputPlugin.access$400:44 io.flutter.plugin.editing.TextInputPlugin$2.hide:122  
I/IMM\_LC  (12314): hideSoftInputFromWindow - mService.hideSoftInput 
D/InputConnectionAdaptor(12314): The input method toggled cursor monitoring off 
D/InsetsSourceConsumer(12314): setRequestedVisible: visible=false, type=19, host=com.afzalhossen.taskly/com.afzalhossen.taskly.MainActivity, from=android.view\.InsetsSourceConsumer.hide:253 android.view\.ImeInsetsSourceConsumer.hide:68 an
droid.view\.ImeInsetsSourceConsumer.hide:74 android.view\.InsetsController.hideDirectly:1473 android.view\.InsetsController.controlAnimationUnchecked:1139 android.view\.InsetsController.applyAnimation:1456 android.view\.InsetsController.appl
yAnimation:1437 android.view\.InsetsController.hide:1006 android.view\.ViewRootImpl$ViewRootHandler.handleMessageImpl:6487 android.view\.ViewRootImpl$ViewRootHandler.handleMessage:6408  
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
D/InsetsSourceConsumer(12314): ensureControlAlpha: for ITYPE\_NAVIGATION\_BAR on com.afzalhossen.taskly/com.afzalhossen.taskly.MainActivity 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@a1b9885 fN = 18 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@117a70b fN = 19 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@979a9e8 fN = 20 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@c023801 fN = 21 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@bc856a6 fN = 22 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@917a8e7 fN = 23 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@e337c94 fN = 24 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@a59533d fN = 25 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@d933732 fN = 26 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@52bec83 fN = 27 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@615ce00 fN = 28 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@ce639 fN = 29 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$scheduleAp
ply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@cb9947e fN = 30 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
I/IMM\_LC  (12314): notifyImeHidden 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
D/InputMethodManager(12314): startInputInner - Id : 0 
I/InputMethodManager(12314): startInputInner - mService.startInputOrWindowGainedFocus 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@db6cddf fN = 31 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
D/InputMethodManager(12314): startInputInner - Id : 0 
I/InputMethodManager(12314): startInputInner - mService.startInputOrWindowGainedFocus 
I/IMM\_LC  (12314): showSoftInput(View,I) 
I/IMM\_LC  (12314): ssi() - flag : 0 view : com.afzalhossen.taskly reason = SHOW\_SOFT\_INPUT 
I/IMM\_LC  (12314): ssi() view is not EditText 
D/InputConnectionAdaptor(12314): The input method toggled cursor monitoring on 
D/InsetsController(12314): show(ime(), fromIme=true) 
D/InsetsSourceConsumer(12314): setRequestedVisible: visible=true, type=19, host=com.afzalhossen.taskly/com.afzalhossen.taskly.MainActivity, from=android.view\.InsetsSourceConsumer.show:246 android.view\.InsetsController.showDirectly:1489 
android.view\.InsetsController.controlAnimationUnchecked:1137 android.view\.InsetsController.applyAnimation:1456 android.view\.InsetsController.applyAnimation:1437 android.view\.InsetsController.show:976 android.view\.ViewRootImpl$ViewRootHa
ndler.handleMessageImpl:6483 android.view\.ViewRootImpl$ViewRootHandler.handleMessage:6408 android.os.Handler.dispatchMessage:106 android.os.Looper.loopOnce:226  
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@e567a8a fN = 32 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@a5f5d18 fN = 33 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@1882371 fN = 34 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@c29b556 fN = 35 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@98699d7 fN = 36 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@47932c4 fN = 37 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@caa85ad fN = 38 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@a23d0e2 fN = 39 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@bb0fc73 fN = 40 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@b38b730 fN = 41 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@e16cfa9 fN = 42 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@8b2192e fN = 43 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@f14eccf fN = 44 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@32a165c fN = 45 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@2e3bd65 fN = 46 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@fca9a3a fN = 47 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@71d86eb fN = 48 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@b703c48 fN = 49 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
D/InputMethodManager(12314): startInputInner - Id : 0 
I/InputMethodManager(12314): startInputInner - mService.startInputOrWindowGainedFocus 
I/IMM\_LC  (12314): showSoftInput(View,I) 
I/IMM\_LC  (12314): ssi() - flag : 0 view : com.afzalhossen.taskly reason = SHOW\_SOFT\_INPUT 
I/IMM\_LC  (12314): ssi() view is not EditText 
D/InputConnectionAdaptor(12314): The input method toggled cursor monitoring on 
D/InputConnectionAdaptor(12314): The input method toggled cursor monitoring off 
D/InputConnectionAdaptor(12314): The input method toggled cursor monitoring on 
D/InsetsController(12314): show(ime(), fromIme=true) 
D/InsetsController(12314): show(ime(), fromIme=true) 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
D/InputMethodManager(12314): startInputInner - Id : 0 
I/InputMethodManager(12314): startInputInner - mService.startInputOrWindowGainedFocus 
I/IMM\_LC  (12314): showSoftInput(View,I) 
I/IMM\_LC  (12314): ssi() - flag : 0 view : com.afzalhossen.taskly reason = SHOW\_SOFT\_INPUT 
I/IMM\_LC  (12314): ssi() view is not EditText 
D/InputConnectionAdaptor(12314): The input method toggled cursor monitoring on 
D/InputConnectionAdaptor(12314): The input method toggled cursor monitoring off 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
D/InputConnectionAdaptor(12314): The input method toggled cursor monitoring on 
D/InsetsController(12314): show(ime(), fromIme=true) 
D/InsetsController(12314): show(ime(), fromIme=true) 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/IMM\_LC  (12314): showSoftInput(View,I) 
I/IMM\_LC  (12314): ssi() - flag : 0 view : com.afzalhossen.taskly reason = SHOW\_SOFT\_INPUT 
I/IMM\_LC  (12314): ssi() view is not EditText 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
D/InsetsController(12314): show(ime(), fromIme=true) 
I/IMM\_LC  (12314): showSoftInput(View,I) 
I/IMM\_LC  (12314): ssi() - flag : 0 view : com.afzalhossen.taskly reason = SHOW\_SOFT\_INPUT 
I/IMM\_LC  (12314): ssi() view is not EditText 
I/IMM\_LC  (12314): showSoftInput(View,I) 
I/IMM\_LC  (12314): ssi() - flag : 0 view : com.afzalhossen.taskly reason = SHOW\_SOFT\_INPUT 
I/IMM\_LC  (12314): ssi() view is not EditText 
D/InsetsController(12314): show(ime(), fromIme=true) 
D/InsetsController(12314): show(ime(), fromIme=true) 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/IMM\_LC  (12314): showSoftInput(View,I) 
I/IMM\_LC  (12314): ssi() - flag : 0 view : com.afzalhossen.taskly reason = SHOW\_SOFT\_INPUT 
I/IMM\_LC  (12314): ssi() view is not EditText 
I/IMM\_LC  (12314): showSoftInput(View,I) 
I/IMM\_LC  (12314): ssi() - flag : 0 view : com.afzalhossen.taskly reason = SHOW\_SOFT\_INPUT 
I/IMM\_LC  (12314): ssi() view is not EditText 
D/InsetsController(12314): show(ime(), fromIme=true) 
D/InsetsController(12314): show(ime(), fromIme=true) 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/IMM\_LC  (12314): showSoftInput(View,I) 
I/IMM\_LC  (12314): ssi() - flag : 0 view : com.afzalhossen.taskly reason = SHOW\_SOFT\_INPUT 
I/IMM\_LC  (12314): ssi() view is not EditText 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
D/InsetsController(12314): show(ime(), fromIme=true) 
I/IMM\_LC  (12314): showSoftInput(View,I) 
I/IMM\_LC  (12314): ssi() - flag : 0 view : com.afzalhossen.taskly reason = SHOW\_SOFT\_INPUT 
I/IMM\_LC  (12314): ssi() view is not EditText 
D/InsetsController(12314): show(ime(), fromIme=true) 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/IMM\_LC  (12314): showSoftInput(View,I) 
I/IMM\_LC  (12314): ssi() - flag : 0 view : com.afzalhossen.taskly reason = SHOW\_SOFT\_INPUT 
I/IMM\_LC  (12314): ssi() view is not EditText 
D/InsetsController(12314): show(ime(), fromIme=true) 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
D/InputMethodManager(12314): startInputInner - Id : 0 
I/InputMethodManager(12314): startInputInner - mService.startInputOrWindowGainedFocus 
I/IMM\_LC  (12314): showSoftInput(View,I) 
I/IMM\_LC  (12314): ssi() - flag : 0 view : com.afzalhossen.taskly reason = SHOW\_SOFT\_INPUT 
I/IMM\_LC  (12314): ssi() view is not EditText 
D/InputConnectionAdaptor(12314): The input method toggled cursor monitoring on 
D/InputConnectionAdaptor(12314): The input method toggled cursor monitoring off 
D/InputConnectionAdaptor(12314): The input method toggled cursor monitoring on 
D/InsetsController(12314): show(ime(), fromIme=true) 
D/InsetsController(12314): show(ime(), fromIme=true) 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
D/InputMethodManager(12314): startInputInner - Id : 0 
I/InputMethodManager(12314): startInputInner - mService.startInputOrWindowGainedFocus 
I/IMM\_LC  (12314): showSoftInput(View,I) 
I/IMM\_LC  (12314): ssi() - flag : 0 view : com.afzalhossen.taskly reason = SHOW\_SOFT\_INPUT 
I/IMM\_LC  (12314): ssi() view is not EditText 
D/InputConnectionAdaptor(12314): The input method toggled cursor monitoring on 
D/InputConnectionAdaptor(12314): The input method toggled cursor monitoring off 
D/InputConnectionAdaptor(12314): The input method toggled cursor monitoring on 
D/InsetsController(12314): show(ime(), fromIme=true) 
D/InsetsController(12314): show(ime(), fromIme=true) 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
D/InputMethodManager(12314): startInputInner - Id : 0 
I/InputMethodManager(12314): startInputInner - mService.startInputOrWindowGainedFocus 
I/IMM\_LC  (12314): showSoftInput(View,I) 
I/IMM\_LC  (12314): ssi() - flag : 0 view : com.afzalhossen.taskly reason = SHOW\_SOFT\_INPUT 
I/IMM\_LC  (12314): ssi() view is not EditText 
D/InputConnectionAdaptor(12314): The input method toggled cursor monitoring on 
D/InputConnectionAdaptor(12314): The input method toggled cursor monitoring off 
D/InputConnectionAdaptor(12314): The input method toggled cursor monitoring on 
D/InsetsController(12314): show(ime(), fromIme=true) 
D/InsetsController(12314): show(ime(), fromIme=true) 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
D/InputMethodManager(12314): startInputInner - Id : 0 
I/InputMethodManager(12314): startInputInner - mService.startInputOrWindowGainedFocus 
I/IMM\_LC  (12314): showSoftInput(View,I) 
I/IMM\_LC  (12314): ssi() - flag : 0 view : com.afzalhossen.taskly reason = SHOW\_SOFT\_INPUT 
I/IMM\_LC  (12314): ssi() view is not EditText 
D/InputConnectionAdaptor(12314): The input method toggled cursor monitoring on 
D/InputConnectionAdaptor(12314): The input method toggled cursor monitoring off 
D/InputConnectionAdaptor(12314): The input method toggled cursor monitoring on 
D/InsetsController(12314): show(ime(), fromIme=true) 
D/InsetsController(12314): show(ime(), fromIme=true) 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/Choreographer(12314): Skipped 220 frames!  The application may be doing too much work on its main thread. 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/MSHandlerLifeCycle(12314): isMultiSplitHandlerRequested: windowingMode=1 isFullscreen=true isPopOver=false isHidden=false skipActivityType=false isHandlerType=true this: DecorView\@16719b2[MainActivity] 
I/IMM\_LC  (12314): hsifw() - flags=0, caller=android.view\.inputmethod.InputMethodManager.hideSoftInputFromWindow:1858 android.view\.inputmethod.InputMethodManager.hideSoftInputFromWindow:1827 io.flutter.plugin.editing.TextInputPlugin.hid
eTextInput:447 io.flutter.plugin.editing.TextInputPlugin.access$400:44 io.flutter.plugin.editing.TextInputPlugin$2.hide:122  
I/IMM\_LC  (12314): hideSoftInputFromWindow - mService.hideSoftInput 
D/InsetsSourceConsumer(12314): setRequestedVisible: visible=false, type=19, host=com.afzalhossen.taskly/com.afzalhossen.taskly.MainActivity, from=android.view\.InsetsSourceConsumer.hide:253 android.view\.ImeInsetsSourceConsumer.hide:68 an
droid.view\.ImeInsetsSourceConsumer.hide:74 android.view\.InsetsController.hideDirectly:1473 android.view\.InsetsController.controlAnimationUnchecked:1139 android.view\.InsetsController.applyAnimation:1456 android.view\.InsetsController.appl
yAnimation:1437 android.view\.InsetsController.hide:1006 android.view\.ViewRootImpl$ViewRootHandler.handleMessageImpl:6487 android.view\.ViewRootImpl$ViewRootHandler.handleMessage:6408  
D/InputConnectionAdaptor(12314): The input method toggled cursor monitoring off 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@3d7c9d5 fN = 50 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/InsetsSourceConsumer(12314): ensureControlAlpha: for ITYPE\_NAVIGATION\_BAR on com.afzalhossen.taskly/com.afzalhossen.taskly.MainActivity 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@99200db fN = 51 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@3cf4778 fN = 52 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@5d82e51 fN = 53 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@ece96b6 fN = 54 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@6a5cfb7 fN = 55 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@86d6324 fN = 56 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@ca05e8d fN = 57 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@b256842 fN = 58 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@9bdb053 fN = 59 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@4af8d90 fN = 60 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 
I/IMM\_LC  (12314): notifyImeHidden 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
D/FlutterJNI(12314): Sending viewport metrics to the engine. 
D/InputMethodManager(12314): startInputInner - Id : 0 
I/InputMethodManager(12314): startInputInner - mService.startInputOrWindowGainedFocus 
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: t = android.view\.SurfaceControl$Transaction\@9415689 fN = 61 android.view\.SyncRtSurfaceTransactionApplier.applyTransaction:94 android.view\.SyncRtSurfaceTransactionApplier.lambda$schedule
Apply$0$SyncRtSurfaceTransactionApplier:71 android.view\.SyncRtSurfaceTransactionApplier$$ExternalSyntheticLambda0.onFrameDraw:4  
I/ViewRootImpl\@33eb480[MainActivity]\(12314): mWNT: merge t to BBQ 

 
  