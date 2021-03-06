#Clear sharepoint list
#################################################################################

param($weburl,$listname)
if ($weburl -eq $null -or $listname -eq $null)
{
    write-host -foregroundcolor red "-weburl or -listname are null."
    return
}
 
Add-PSSnapin Microsoft.SharePoint.Powershell -EA 0
$web = get-spweb $weburl
$list = $web.lists[$listname]
 
$stringbuilder = new-object System.Text.StringBuilder
 
try
{
    $stringbuilder.Append("<?xml version=`"1.0`" encoding=`"UTF-8`"?><ows:Batch OnError=`"Return`">") > $null
 
    $i=0
 
    $spQuery = New-Object Microsoft.SharePoint.SPQuery
    $spQuery.ViewFieldsOnly = $true
 
    $items = $list.GetItems($spQuery);
    $count = $items.Count
 
    while ($i -le ($count-1))
    {
        write-host $i
        $item = $items[$i]
 	
        $stringbuilder.AppendFormat("<Method ID=`"{0}`">", $i) > $null
        $stringbuilder.AppendFormat("<SetList Scope=`"Request`">{0}</SetList>", $list.ID) > $null
        $stringbuilder.AppendFormat("<SetVar Name=`"ID`">{0}</SetVar>", $item.Id) > $null
        $stringbuilder.Append("<SetVar Name=`"Cmd`">Delete</SetVar>") > $null
        $stringbuilder.Append("</Method>") > $null
 
        $i++
    }
    $stringbuilder.Append("</ows:Batch>") > $null
 
    $web.ProcessBatchData($stringbuilder.ToString()) > $null
}
catch
{
    Write-Host -ForegroundColor Red $_.Exception.ToString()
}
 
write-host -ForegroundColor Green "done."


######################################################################################
#.\ClearList.ps1 -weburl http://app-server -listname RecordList