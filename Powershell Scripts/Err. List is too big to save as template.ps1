#If you are getting error while saving a list or a document library as a template, try to increase template document size.

/**/
stsadm -o setproperty -propertyname max-template-document-size -propertyvalue 500000000
/**/

#500000000 is like 500mb. You can change the size based on your requirements.