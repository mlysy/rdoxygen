# {{kind}} `{{name}}` {{anchor refid}}

{{briefdescription}}

{{detaileddescription}}

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
{{#each filtered.members}}[`{{cell name}}()`](#{{refid}})           | {{cell summary}}
{{/each}}{{#each filtered.compounds}}[`{{cell name}}()`](#{{refid}})| {{cell summary}}
{{/each}}

{{#if filtered.members}}
## Members

{{#each filtered.members}}
#### `{{title name}}()` {{anchor refid}}

```{r, echo = FALSE, results = "asis"}
parse_proto("{{title proto}}")
```

{{#if enumvalue}}
 Values                         | Descriptions                                
--------------------------------|---------------------------------------------
{{#each enumvalue}}{{cell name}}            | {{cell summary}}
{{/each}}
{{/if}}

{{briefdescription}}

{{detaileddescription}}

{{/each}}
{{/if}}
