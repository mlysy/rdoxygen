# {{kind}} `{{name}}` {{anchor refid}}

{{#if basecompoundref}}
```
{{kind}} {{name}}
  {{#each basecompoundref}}
  : {{prot}} {{name}}
  {{/each}}
```  
{{/if}}

{{briefdescription}}

{{detaileddescription}}

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
{{#each filtered.compounds}}[`{{cell name}}()`](#{{refid}})        | {{cell summary}}
{{/each}}{{#each filtered.members}}[`{{cell name}}()`](#{{refid}}) | {{cell summary}}
{{/each}}

## Members

{{#each filtered.compounds}}
#### {{title proto}} {{anchor refid}}

{{briefdescription}}

{{detaileddescription}}
{{/each}}

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
