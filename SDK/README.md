# SDK Packaging

1. Create a Cocoa Touch Framework in your app   
![screenshot](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/sdk1.png)  
2. Let's say you've finished the framework, import the framework in the sample app    
3. Config build settings with the following table   
4. Import headers. In this case, I skip this step in this swift project, you might have to import third party OC headers    
5. Expose public files    
![screenshot](https://raw.githubusercontent.com/Catherine22/iOS-tutorial/master/screenshots/sdk2.png)  
6. Have a simulator or your iPhone device selected, then build    





# Build settings
| config | description | value |
| -- | -- | --|
| Dead Code Stripping | remove non executed code | No |
| Link With Standard Libraries |  | No |
| Mach-O Type | | Static Library |
| Architectures | | $(ARCHS_STANDARD), armv7s |
| Build Active Architecture Only | | No |
