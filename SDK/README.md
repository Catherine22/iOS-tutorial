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
8. You can either build frameworks manually or do it via [build script], the frameworks will be saved in [Output] directory   
```sh
sh build_framework.sh
```


# Build settings
| config | description | value |
| -- | -- | --|
| Dead Code Stripping | remove non executed code | No |
| Link With Standard Libraries |  | No |
| Mach-O Type | | Static Library |
| Architectures | | $(ARCHS_STANDARD), armv7s |
| Build Active Architecture Only | | No |



[SampleApp](https://github.com/Catherine22/iOS-tutorial/blob/master/SDK/SampleApp)
[build script](https://github.com/Catherine22/iOS-tutorial/blob/master/SDK/SampleApp/build_framework.sh)
[Output](https://github.com/Catherine22/iOS-tutorial/blob/master/SDK/SampleApp/output)
