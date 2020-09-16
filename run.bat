mkdir %namespace%.%name% && cd %namespace%.%name%
pac pcf init -ns %namespace% -n %name% -t %template%
mkdir Solution && cd Solution
mkdir %name% && cd %name%
pac solution init -pn %publisherprefix% -pp %publishername%
pac solution add-reference -p ..\..\
npm install && echo cd c:\src\%namespace%.%name% > C:\run.bat