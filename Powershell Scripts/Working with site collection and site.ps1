#Most of the cmdlets commonly used in the management of site collections or sites end in SPSite or SPWeb. To pick up a reference to a site collection, we can use the following
$site=Get-SPSite -Identity

#Or we can return a list of all site collections by using this:
Get-SPSite

#When it comes to managing site objects (SPWeb), we can pick up a specific web site using this:
$web=Get-SPWeb -Identity

#To return a list of sites, we need to use either the Site parameter or an SPSite object:
Get-SPWeb -Site

#or

Get-SPWeb -Site $site

#Creating Site Collections and Sites
#We can create a new site collection using the New-SPSite cmdlet:
New-SPSite -Url http://localhost/Sites/NewSiteCollection- OwnerAlias username

#We can also add new sites using the New-SPWeb cmdlet:
New-SPWeb -Url http://localhost/Sites/NewSiteCollection/NewWeb -Name MyNewWeb

#Deleting Site Collections and Sites
#We can delete site collections and sites by using the Remove-SPSite or the Remove-SPWeb cmdlet.
Remove-SPWeb -Identity http://localhost/Sites/NewSiteCollection/NewWeb

#or
Remove-SPSite -Identity http://localhost/Sites/NewSiteCollection

#Setting Properties on SharePoint Objects
#When setting properties on the objects returned by SharePoint management cmdlets, we need to call the Update method in the same manner as when updating properties using the Server Object Model. Here’s an example:

$web=SP-GetSPWeb -Identity http://myweburl
$web.Title="My New Title"
$web.Update()

#Working with Lists and Libraries
#Similarly to how lists and libraries are accessed in the Server Object Model, they can be accessed via SPWeb objects. For example, we can enumerate the lists on a site using the following:
Get-SPWeb -Identity | Select -Expand lists| Select Title

#We can add new lists using the Add method of the Lists property:
Get-SPWeb -Identity | ForEach {$_.Lists.Add("My Task List", "", $_.ListTemplates["Tasks"])}<strong> </strong>

#Changing the Business Connectivity Thresholds
#The maximum number of rows that can be retrieved via a Business Connectivity Services (BCS) connection is limited. The only way to change this value is via PowerShell. We can use the following command to retrieve the current settings:
$proxies=Get-SPServiceApplicationProxy | Where {$_.TypeName -like "Business Data*"} $rule=Get-SPBusinessDataCatalogThrottleConfig -ServiceApplicationProxy $proxies -Scope -> Database -ThrottleType Items $rule

#We can then update the value using the following:
Set-SPBusinessDataCatalogThrottleConfig -Identity $rule -Maximum 10000  Default 10000

#Working with Content
#We can retrieve a list of all items in a site using the following:
Get-SPWeb -Identity | Select -Expand Lists | Select -Expand Items |->select Name, Url

#Or
#we can apply a filter to show only documents:
Get-SPWeb -Identity | Select -Expand Lists | Where {$_.BaseType -eq -> "DocumentLibrary"} | Select -Expand Items | select Name, Url

#We  can also make use of filters to search for a specific item:
Get-SPWeb -Identity http://myweburl | Select -Expand Lists | Select -Expand Items | -> Where {$_.Name -like "foo*"} | select Name, Url

#Creating New Documents
#To create a new document in a document library, use the following:

function New-SPFile($WebUrl, $ListName, $DocumentName,$Content)
{
  $stream = new-object System.IO.MemoryStream
  $writer = new-object System.IO.StreamWriter($stream)
  $writer.Write($content)
  $writer.Flush()
  $list=(Get-SPWeb $WebUrl).Lists.TryGetList($ListName)
  $file=$list.RootFolder.Files.Add($DocumentName, $stream,$true)
  $file.Update()
}
 
New-SPFile -WebUrl "" -ListName "Shared Documents" -DocumentName -> "PowerShellDocument.txt" -Content "Document Content"

#Working with Timer Jobs
#SharePoint makes use of timer jobs to perform a lot of back-end processing. We can use PowerShell to get a list of all timer jobs:

Get-SPTimerJob

#Or
#we can get a list of job failures grouped by the job name:
Get-SPTimerJob | Select -Expand HistoryEntries | Where {$_.Status -ne "Succeeded"} -> | group JobDefinitionTitl