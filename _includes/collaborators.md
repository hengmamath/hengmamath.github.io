{% comment %}
  自动生成合作者列表。
  数据来源：_data/publications.yml 中每篇论文的 authors 字段。
  排序方式：优先使用 author.sort_as；如果没有 sort_as，则按姓名最后一个单词排序。
  例如 "Pascal Maillard" 默认按 Maillard 排；
  "Loïc de Raphélis" 可以在 publications.yml 里设置 sort_as: "de Raphélis"。
  如果 author.url 有值，就自动生成主页超链接；如果为空，就只显示姓名。
{% endcomment %}
{%- assign collaborator_entries = "" -%}
{%- for paper in site.data.publications.main -%}
  {%- for author in paper.authors -%}
    {%- if author.sort_as -%}
      {%- assign sort_key = author.sort_as | downcase -%}
    {%- else -%}
      {%- assign name_parts = author.name | split: " " -%}
      {%- assign sort_key = name_parts | last | downcase -%}
    {%- endif -%}
    {%- capture entry -%}{{ sort_key }}|{{ author.name }}|{{ author.url }}{%- endcapture -%}
    {%- assign collaborator_entries = collaborator_entries | append: entry | append: ";;" -%}
  {%- endfor -%}
{%- endfor -%}
{%- assign collaborators = collaborator_entries | split: ";;" | uniq | sort -%}
{%- for collaborator in collaborators -%}
  {%- unless collaborator == "" -%}
    {%- assign fields = collaborator | split: "|" -%}
    {%- assign name = fields[1] -%}
    {%- assign url = fields[2] -%}
    {%- if url and url != "" -%}<a href="{{ url }}" target="_blank" rel="noopener">{{ name }}</a>{%- else -%}{{ name }}{%- endif -%}{%- unless forloop.last -%}, {% else %}.{% endunless -%}
  {%- endunless -%}
{%- endfor -%}
