
### Multiline curl command
For Linux and MacOS: Use the `\` escape character:
```
curl "http://WEBSITE" -H "Host: WEBSITE" \
-H "Accept: text/html,application/xhtml+xml \
,application/xml;q=0.9,*/*;q=0.8"
```
For Windows: Use the `^` escape character:
```
curl "http://WEBSITE" -H "Host: WEBSITE" ^
-H "Accept: text/html,application/xhtml+xml ^
,application/xml;q=0.9,*/*;q=0.8"
```
NOTE: watch out for the tendency to indent on multiple line commands, 
as it will embed spaces and screw up the curl command. 
the sed command replaces embedded spaces within the variables with the 
string so that spaces can be used embedded in the strings you pass as variables


ref: https://stackoverflow.com/questions/32341091/multiline-curl-command

to run
```
curl -XGET localhost:9200/library/book/_search?pretty=true -d {
    "query" : {
        "query_string" : { "query" : "title:crime" }
    }
}
```

```
curl -XPOST http://localhost:9200/_search -d^
"{^
    \"query\": {^
        \"query_string\": {^
            \"query\": \"year:2003\"^
        }^
    }^
}"
```
^ to extend a command to next line and
\" to escape " on the json
