<h2 id="publications" style="margin: 2px 0px -15px;">
<!-- Papers -->
</h2>

<div class="publications">
<ol class="bibliography">

{% for link in site.data.publications.main %}


<li>
<div class="pub-row"> 
<div class="col-sm-3 abbr" style="position: relative;padding-right: 15px;padding-left: 15px;">
    {% if link.image %} 
    <img src="{{ link.image }}" class="teaser img-fluid z-depth-1" style="width=100;height=40%">
    {% endif %} 
  </div>

  <div class="col-sm-9" style="position: relative;padding-right: 15px;padding-left: 20px;">
      <div class="title"><a href="{{ link.arXiv }}">{{ link.title }}</a></div>
      <div class="author">with {{ link.coauthors }}</div>
      <div class="periodical"><em>{{ link.journal }}</em></div>
    <div class="links">
    {% if link.journalpage %} 
      <a href="{{ link.journalpage }}" class="btn btn-sm z-depth-0" role="button" target="_blank" style="font-size:12px;">journal</a>
      {% endif %}
      {% if link.arXiv %} 
      <a href="{{ link.arXiv }}" class="btn btn-sm z-depth-0" role="button" target="_blank" style="font-size:12px;">arXiv</a>
      {% endif %}
      {% if link.poster %} 
      <a href="{{ link.poster }}" class="btn btn-sm z-depth-0" role="button" target="_blank" style="font-size:12px;">poster</a>
      {% endif %}
      {% if link.talk %} 
      <a href="{{ link.talk }}" class="btn btn-sm z-depth-0" role="button" target="_blank" style="font-size:12px;">slides</a>
      {% endif %}
    </div>
  </div>
</div>
</li>


<br>

{% endfor %}

</ol>
</div>

