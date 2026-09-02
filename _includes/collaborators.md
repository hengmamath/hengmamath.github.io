{% comment %}
  自动生成 Coauthors 名单。
  名字来源：_data/publications.yml 各篇论文的 coauthors 字段（自动去重）。
  主页/排序：_data/coauthors.yml 查表。
  排序方式：优先用 sort_as；没有就按名字最后一个单词（姓氏）排。
  只有真正发表过合作论文的人才会出现在这里 —— 通讯录里登记了但还没有
  共同论文的人不会显示。
{% endcomment %}
{%- assign entries = "" -%}
{%- for paper in site.data.publications.main -%}
  {%- assign names = paper.coauthors | replace: " and ", ", " | replace: "  ", " " | split: "," -%}
  {%- for raw_name in names -%}
    {%- assign name = raw_name | strip -%}
    {%- if name != "" -%}
      {%- assign person = site.data.coauthors[name] -%}
      {%- if person.sort_as -%}
        {%- assign sort_key = person.sort_as | downcase -%}
      {%- else -%}
        {%- assign sort_key = name | split: " " | last | downcase -%}
      {%- endif -%}
      {%- assign entries = entries | append: sort_key | append: "|" | append: name | append: ";;" -%}
    {%- endif -%}
  {%- endfor -%}
{%- endfor -%}
{%- assign collaborators = entries | split: ";;" | uniq | sort -%}
{%- for collaborator in collaborators -%}
  {%- assign name = collaborator | split: "|" | last -%}
  {%- assign person = site.data.coauthors[name] -%}
  {%- if person.url and person.url != "" -%}<a href="{{ person.url }}" target="_blank" rel="noopener">{{ name }}</a>{%- else -%}{{ name }}{%- endif -%}
  {%- unless forloop.last -%}, {% else %}.{% endunless -%}
{%- endfor -%}
