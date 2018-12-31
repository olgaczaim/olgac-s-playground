#Here are the PowerShell commands to restore a deleted SharePoint site
Get-SPDeletedSite | select Path , siteid

#This will generate a list of all deleted sites and their GUIDs)
#Then, run the command:
Restore-SPDeletedSite -Identity (SITE ID)

Restore-SpDeletedSite –Identity 4bff0c0e-4d56-4fec-8174-a60a16daeaac
#This final command will restore the site