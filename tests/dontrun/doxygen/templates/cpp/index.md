---
title: "Doxydoc"
output:
  rmarkdown::html_document:
    theme: readable
    toc: true
    toc_float: true
---

```{r, include = FALSE}
# R processing
source("parse_proto.R")
```

# Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
{{#each filtered.members}}{{cell proto}}            | {{cell summary}}
{{/each}}{{#each filtered.compounds}}{{cell proto}} | {{cell summary}}
{{/each}}

{{#if filtered.members}}
## Members

{{#each filtered.members}}
#### {{title proto}} <a id="`r parse_refid('{{refid}}')`"></a>

{{briefdescription}}

{{#if enumvalue}}
 Values                         | Descriptions                                
--------------------------------|---------------------------------------------
{{#each enumvalue}}{{cell name}}            | {{cell summary}}
{{/each}}
{{/if}}

{{detaileddescription}}

{{/each}}
{{/if}}
