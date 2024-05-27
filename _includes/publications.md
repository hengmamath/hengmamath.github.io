<h2 id="publications" style="margin: 2px 0px -15px;">Publications</h2>

<div class="publications">
<ol class="bibliography">

{% for link in site.data.publications.main %}


<li>
<div class="pub-row">
  <div class="col-sm-3 abbr" style="position: relative;padding-right: 15px;padding-left: 15px;">
    {% if link.image %} 
     <img src="{{ link.image }}" class="teaser img-fluid z-depth-1" width="500">
    {% endif %}
  </div>
  <div class="col-sm-9" style="position: relative;padding-right: 15px;padding-left: 20px;">
      <div class="title"><a href="{{ link.arXiv }}">{{ link.title }}</a></div>
      <div class="author">with {{ link.coauthors }}</div>
      <div class="periodical"><em>{{ link.journal }}</em></div>
    <div class="links">
      {% if link.arXiv %} 
      <a href="{{ link.arXiv }}" class="btn btn-sm z-depth-0" role="button" target="_blank" style="font-size:12px;">arXiv</a>
      {% endif %}
      {% if link.journalpage %} 
      <a href="{{ link.journalpage }}" class="btn btn-sm z-depth-0" role="button" target="_blank" style="font-size:12px;">journal</a>
      {% endif %}
    </div>
  </div>
</div>
</li>


<br>

{% endfor %}

</ol>
</div>

