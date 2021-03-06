 '*******************************************************************************  
 '     Program: Install.vbs  
 '      Author: 
 '        Date: 
 '    Modified: 
 '  
 '     Program: 
 '     Version: 
 ' Description: This will install   
 '                 1) Define the relative installation path  
 '                 2) Create the Log Folder  
 '                 *) Install   
 '                 *) Cleanup Global Variables  
 '*******************************************************************************  
 Option Explicit  

 REM Define Constants  
 CONST TempFolder  = "c:\temp\"  
 CONST LogFolderName = ""  

 REM Define Global Variables  
 DIM LogFolder   : LogFolder    = TempFolder & LogFolderName & "\"  
 DIM RelativePath : Set RelativePath = Nothing  

 REM Define the relative installation path  
 DefineRelativePath()  
 REM Create the Log Folder  
 CreateLogFolder()  
 REM Install   
 Install  
 REM Cleanup Global Variables  
 GlobalVariableCleanup()  

 '*******************************************************************************  
 '*******************************************************************************  

 Sub DefineRelativePath()  
      REM Get File Name with full relative path  
      RelativePath = WScript.ScriptFullName  
      REM Remove file name, leaving relative path only  
      RelativePath = Left(RelativePath, InStrRev(RelativePath, "\"))  
 End Sub  

 '*******************************************************************************  

 Sub CreateLogFolder()  
      REM Define Local Objects  
      DIM FSO : Set FSO = CreateObject("Scripting.FileSystemObject")  

      If NOT FSO.FolderExists(TempFolder) then  
           FSO.CreateFolder(TempFolder)  
      End If  
      If NOT FSO.FolderExists(LogFolder) then  
           FSO.CreateFolder(LogFolder)  
      End If  

      REM Cleanup Local Variables  
      Set FSO = Nothing  
 End Sub  

 '*******************************************************************************  

 Sub Install()  
      REM Define Local Objects  
      DIM oShell : SET oShell = CreateObject("Wscript.Shell") 
 
      REM Define Local Variables  
      DIM MSI        : MSI        = Chr(32) & RelativePath & ".msi"  
      DIM Logs       : Logs       = Chr(32) & "/lvx" & Chr(32) & LogFolder & ""  
      DIM Parameters : Parameters = Chr(32) & "/qb- /norestart"  
      DIM Transforms : Transforms = Chr(32) & "Transforms=" & RelativePath & ""
      DIM Install    : Install    = "msiexec.exe /i" & MSI & Logs & Parameters  

      oShell.Run Install, 1, True  

      REM Cleanup Local Variables  
      Set Install    = Nothing  
      Set Logs       = Nothing  
      Set MSI        = Nothing  
      Set oShell     = Nothing  
      Set Parameters = Nothing  
      Set Transforms = Nothing
 End Sub  

 '*******************************************************************************  

 Sub GlobalVariableCleanup()  
      Set LogFolder    = Nothing  
      Set RelativePath = Nothing  
 End Sub  
