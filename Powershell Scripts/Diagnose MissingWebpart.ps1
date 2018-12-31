#Diagnose Missing Webpart
#http://get-spscripts.com/2011/08/diagnose-missingwebpart-and.html


-- missing web part

SELECT * from AllDocs inner join AllWebParts on AllDocs.Id = AllWebParts.tp_PageUrlID 
where AllWebParts.tp_WebPartTypeID = '8f45bd4f-bd2c-93cc-0ea0-2288d323a0e7'


-- missing assembly

SELECT * from EventReceivers 
where Assembly = 'MainNewsEventRecevier, Version=1.0.0.0, Culture=neutral, PublicKeyToken=f49d00a34b63827b'



/*$site = Get-SPSite -Limit all | where {$_.Id -eq "27E90E41-2426-4C6B-A243-2E6287875099"}
$web = $site | Get-SPWeb -Limit all | where {$_.Id -eq "EBDE660A-EF0D-44F7-A7BD-AD720F3C710C"}
$web.Url
*/

/* 1. event receiver
$list = $web.Lists | where {$_.Id -eq "ECA5473D-E9EE-44C9-B26D-1700670E57A7"}

$er = $list.EventReceivers | where {$_.Id -eq "CD53BBCB-E568-4743-A907-2EA3A5F218D6"}
$er.Delete()

$list = $web.Lists | where {$_.Id -eq "ECA5473D-E9EE-44C9-B26D-1700670E57A7"}

$er = $list.EventReceivers | where {$_.Id -eq "99E667EF-06ED-47BA-ACEF-2248EA9E8706"}
$er.Delete()

$list = $web.Lists | where {$_.Id -eq "ECA5473D-E9EE-44C9-B26D-1700670E57A7"}

$er = $list.EventReceivers | where {$_.Id -eq "355A19A2-DFAF-4D0C-A354-F59536F462F0"}
$er.Delete()

$list = $web.Lists | where {$_.Id -eq "ECA5473D-E9EE-44C9-B26D-1700670E57A7"}

$er = $list.EventReceivers | where {$_.Id -eq "509A2829-0749-49DC-B10C-84A848C617C2"}
$er.Delete()
*/
