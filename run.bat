mkdir %namespace%.%name% && cd %namespace%.%name%
pac pcf init -ns %namespace% -n %name% -t %template%
mkdir Solution && cd Solution
mkdir %name% && cd %name%
pac solution init -pn %publisherprefix% -pp %publishername%
pac solution add-reference -p ..\..\
cd c:\src\%namespace%.%name% && npm install && C:\BuildTools\Common7\Tools\VsDevCmd.bat