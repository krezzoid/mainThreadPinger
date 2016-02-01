//
//  mainThreadPinger.swift
//
//  Created by Ilya Seliverstov on 01.02.16.
//  Copyright 2015 Ilya Seliverstov. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

import Foundation

class mainThreadPinger: NSThread {
    static let sharedInstance = mainThreadPinger()
    
    private var pingRunning = false
    private var semaphore = dispatch_semaphore_create(0)
    
    private override init() {
        super.init()
        
        self.start()
    }
    
    override func main() {
        while !self.cancelled {
            pingRunning = true
            
            dispatch_async(dispatch_get_main_queue(), {
                self.pingRunning = false
                dispatch_semaphore_signal(self.semaphore)
            })
            
            // check once per 400msec
            NSThread.sleepForTimeInterval(0.4)
            if pingRunning {
                print("WARNING - slow UI/main thread detected!")
            }
            
            dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER)
        }
    }
}
