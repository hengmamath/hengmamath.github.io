<!--
  Research 页面论文列表模板。
  真正的论文数据不在这里，而是在 _data/publications.yml。
  通常添加、删除、修改论文时，只需要改 _data/publications.yml。
-->
<div class="publications">
  <ol class="bibliography">
    <!-- 遍历 _data/publications.yml 里 main: 下面的每一篇论文。 -->
    {% for link in site.data.publications.main %}
    <!-- 如果某篇论文没有 image 字段，就加 no-image class，让 CSS 使用无图片布局。 -->
    <li class="publication-item{% unless link.image %} no-image{% endunless %}">
      <!-- 论文图片。图片路径来自 publications.yml 的 image 字段。 -->
      {% if link.image %}
      <div class="publication-image">
        <img src="{{ link.image | relative_url }}" class="teaser" alt="{{ link.title | escape }}">
      </div>
      {% endif %}

      <div class="publication-content">
        <!-- 论文标题。如果有 arXiv 字段，标题会自动链接到 arXiv。 -->
        <h2 class="publication-title">
          {% if link.arXiv %}
          <a href="{{ link.arXiv }}">{{ link.title }}</a>
          {% else %}
          {{ link.title }}
          {% endif %}
        </h2>

        <!--
          合作者列表。
          优先使用 publications.yml 里的 authors 列表：
            authors:
              - name: "Author Name"
                url: "https://author-homepage.example"
          如果 author.url 为空，就只显示姓名；如果有 url，就显示为超链接。
          如果某篇论文还没有 authors 字段，则 fallback 到旧的 coauthors 纯文本字段。
        -->
        <p class="publication-authors">
          with
          {% if link.authors %}
            {% for author in link.authors %}
              {% if author.url %}
              <a href="{{ author.url }}" target="_blank" rel="noopener">{{ author.name }}</a>{% else %}{{ author.name }}{% endif %}{% unless forloop.last %}{% if forloop.rindex == 2 %} and {% else %}, {% endif %}{% endunless %}
            {% endfor %}
          {% else %}
            {{ link.coauthors }}
          {% endif %}
        </p>

        <!-- 期刊、会议、arXiv 状态等信息，来自 publications.yml 的 journal 字段。 -->
        <p class="publication-venue"><em>{{ link.journal }}</em></p>

        <!--
          论文相关按钮。
          只有 publications.yml 中存在对应字段时，按钮才会显示。
        -->
        <div class="publication-links">
          <!-- 期刊正式页面链接。 -->
          {% if link.journalpage %}
          <a href="{{ link.journalpage }}" class="btn btn-sm z-depth-0" role="button" target="_blank" rel="noopener">journal</a>
          {% endif %}

          <!-- arXiv 链接。 -->
          {% if link.arXiv %}
          <a href="{{ link.arXiv }}" class="btn btn-sm z-depth-0" role="button" target="_blank" rel="noopener">arXiv</a>
          {% endif %}

          <!-- poster PDF，通常放在 assets/files/。 -->
          {% if link.poster %}
          <a href="{{ link.poster | relative_url }}" class="btn btn-sm z-depth-0" role="button" target="_blank" rel="noopener">poster</a>
          {% endif %}

          <!-- slides PDF，通常放在 assets/files/。 -->
          {% if link.talk %}
          <a href="{{ link.talk | relative_url }}" class="btn btn-sm z-depth-0" role="button" target="_blank" rel="noopener">slides</a>
          {% endif %}
        </div>
      </div>
    </li>
    {% endfor %}
  </ol>
</div>
