# BlockEdfLoaderClass

Class version of EDF loader class.  Provides additional funcitonality that minimizes the amount of code required to access EDF contents than [BlockEdfLoad](https://github.com/DennisDean/BlockEdfLoad).  Class includes an [EDF checker](https://github.com/DennisDean/BlockEdfLoadClass/releases), a function for identifying EDF's in a folder and a function for checking an EDFs content.

## Public Methods

* Constructor
   
   obj = BlockEdfLoadClass(edfFN)  
   obj = BlockEdfLoadClass(edfFN, signalLabels)  
   obj = BlockEdfLoadClass(edfFN, signalLabels, epochs)   

* Load Prototypes (set load properties first)

   obj = obj.blockEdfLoad                                Default entire file, return class  
   obj = obj.blockEdfLoad (outArgClass)                  Select between class or structured return  
   obj = obj.blockEdfLoad (outArgClass, numCompToLoad)  

* Summary Functions

   obj.PrintEdfHeader                                    Write header contents to console  
   obj.WriteEdfHeader                                    Write header to file defined in private properties  
   obj.PrintEdfSignalHeader                              Write signal header information to console  
   obj.WriteEdfSignalHeader                              Write signal header to file defined in private properties  
   obj.PlotEdfSignalStart                                Plot signal start  
   obj.CheckEdf                                          Check EDF header and signal header  
   obj.DispCheck                                         Display results of check to console  
   obj.WriteCheck                                        Write results of check to file  
              
## Test functions
A limited set of test functions are provide to demonstrate the major functionality. Test functions and supporting files can be found in the release section and include:

1. Test load/plot functionality
2. Evaluate Memory saving features
3. Use static function to identify EDF files
4. Control the number of components loaded (Signals Not Loaded)
5. Get edf file names from folder
6. Dependent variables provide direct access to signal labels and sampling rate
7. EDF Checker  
8. Check flag to invert swapped signals



