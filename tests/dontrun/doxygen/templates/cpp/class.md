# {{kind}} `{{name}}` <a id="`r parse_refid('{{refid}}')`"></a>

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
{{#each filtered.compounds}}[`{{cell name}}()`](#`r parse_refid('{{refid}}')`)        | {{cell summary}}
{{/each}}{{#each filtered.members}}[`{{cell name}}()`](#`r parse_refid('{{refid}}')`) | {{cell summary}}
{{/each}}

## Members

{{#each filtered.compounds}}
#### {{title proto}} <a id="`r parse_refid('{{refid}}')`"></a>

{{briefdescription}}

{{detaileddescription}}
{{/each}}

{{#each filtered.members}}
#### `{{title name}}()` <a id="`r parse_refid('{{refid}}')`"></a>

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
