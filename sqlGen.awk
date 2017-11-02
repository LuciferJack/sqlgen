#!/bin/awk -f
BEGIN{\
FS="|"; \
head="insert into ";\
fieldName = ""; \
fieldValue = "";\
}		\
#exe block start
{		\
#start if 
if(2 == NR){	\
for(i=1;i<NF;i++){\
if($i==""){		  \
continue;
}
if(i==NF-1){
fieldName = fieldName trim($i); \
}else{
fieldName = fieldName trim($i) ","; \
}
#end for
}				\
#print fieldName; 	\
#get the file name
getTableName(FILENAME);
#end if
}else if(NR > 2){
fieldValue = "";
for(i=1;i<NF;i++){\
if($i==""){               \
continue;
}
if(i==NF-1){
fieldValue = fieldValue "'"trim($i)"'"; 
}else{
fieldValue = fieldValue "'"trim($i)"'" ","; 
}
#end for
}
#print the sql statement
if(fieldValue != ""){
print head getTableName(FILENAME) "("fieldName")""values" "("fieldValue")"";"; 
}
}
#end exe block
}		


function ltrim(s) { sub(/^[ \t\r\n]+/, "", s); return s }
function rtrim(s) { sub(/[ \t\r\n]+$/, "", s); return s }
function trim(s) { return rtrim(ltrim(s)); }
function getTableName(name){if(match(name,".")!=0){split(name,tableName,".");return tableName[1];}}
