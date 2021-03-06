#If you build a web part or any other solution package you will get .wsp file. And you should upload and deploy that solution to the server farm.
Add-SPSolution -LiteralPath c:\contoso_solution.wsp

#Then you need to deploy solution:
Install-SPSolution -Identity contoso_solution.wsp -GACDeployment

#The Update-SPSolution cmdlet upgrades a deployed SharePoint solution in the farm. Use this cmdlet only if a new solution contains the same set of files and features as the deployed solution. If files and features are different, the solution must be retracted and redeployed by using the Uninstall-SPSolution and Install-SPSolution cmdlets, respectively.
Update-SPSolution -Identity contoso_solution.wsp -LiteralPath c:\contoso_solution_v2.wsp -GACDeployment

#The Uninstall-SPSolution cmdlet retracts a deployed SharePoint solution in preparation for removing it from the farm entirely. This cmdlet removes files from the front-end Web server. Use the Remove-SPSolution cmdlet to delete the solution package from the solution store of the farm; be sure to use the Remove-SPSolution cmdlet only after you have run Uninstall-SPSolution.
Uninstall-SPSolution -Identity contoso_solution.wsp

#The Remove-SPSolution cmdlet deletes a SharePoint solution from a farm. Before you use this cmdlet, you must use the Uninstall-SPSolution cmdlet to retract the solution files from the front-end Web server.
Remove-SPSolution -Identity contoso_solution.wsp