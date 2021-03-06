#Extract all solutions from your farm

﻿(Get-SPFarm).Solutions | ForEach-Object{$var = (Get-Location).Path + "\" + $_.Name; $_.SolutionFile.SaveAs($var)}

#** I must note here that utilizing the (Get-Location).Path will drop all the solutions where you currently located in the file system, so ensure to navigate to the appropriate folder before running this command, or modify the command to hard code in the path you need. We do not like hard coded path's therefore we just call our current location.

#Import all solutions to another farm
Get-ChildItem | ForEach-Object{Add-SPSolution -LiteralPath $_.Fullname}

#** Once again this calls your current location in the filesystem so ensure you navigate to the folder containing your newly exported solutions prior to executing this script.

#Deploy all solutions on the new farm

Get-SPSolution | ForEach-Object {If ($_.ContainsWebApplicationResource -eq $False) {Install-SPSolution -Identity $_ -GACDeployment} else {Install-SPSolution -Identity $_ -AllWebApplications -GACDeployment}}