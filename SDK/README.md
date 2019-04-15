# SDK Packaging

1. Create a Cocoa Touch Framework in your app   
![screenshot](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/sdk1.png)  
2. Let's say you've finished the framework, import the framework in the sample app    
3. Config build settings with the following table   
4. Import headers. In this case, I skip this step in this swift project, you might have to import third party OC headers    
5. Expose public files    
![screenshot](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/sdk2.png)  
6. Have a simulator or your iPhone device selected, then build    
7. Find where the framework we just build is    
![screenshot](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/sdk3.png)   
8. You could either build frameworks manually or do it via [build script], the frameworks will be saved in [Output] directory   
```sh
sh build_framework.sh
```
Now, we have two frameworks - one for simulator, another for iPhone. The following instructions show how to merge two frameworks into a single framework.   
9. Merge iphoneos and iphonesimulator frameworks by executing   
```sh
lipo -create Debug-iphoneos/SDK.framework/SDK  Debug-iphonesimulator/SDK.framework/SDK -output SDK
```
10. Replace SDK file in iphoneos framework, and this framework will be the final version    


**NOTICE: Drag the framework to your app's physical directory before import.**

# Build settings
| config | description | value |
| -- | -- | --|
| Dead Code Stripping | remove non executed code | No |
| Link With Standard Libraries |  | No |
| Mach-O Type | | Static Library |
| Architectures | | $(ARCHS_STANDARD), armv7s |
| Build Active Architecture Only | | No |


# Reference
[How to build iOS with command](https://medium.com/@marksiu/how-to-build-ios-project-with-command-82f20fda5ec5)
[How to create your own dynamic frameworks](https://www.jianshu.com/p/62e22ee6f59e)


[SampleApp]:<https://github.com/Catherine22/iOS-tutorial/blob/master/SDK/SampleApp>
[build script]:<https://github.com/Catherine22/iOS-tutorial/blob/master/SDK/SampleApp/build_framework.sh>
[Output]:<https://github.com/Catherine22/iOS-tutorial/blob/master/SDK/SampleApp/output>
