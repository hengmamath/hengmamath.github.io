<!--
  Research 页面论文列表模板。
  数据来源：
    _data/publications.yml —— 论文本身（标题、期刊、链接、图片、合作者名字）
    _data/coauthors.yml    —— 合作者主页（每人只登记一次，这里自动查表）
  日常添加/修改论文只需要改这两个 yml，本文件一般不用动。
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
          publications.yml 里只写名字（逗号分隔）：
            coauthors: "Xinxin Chen, Yichao Huang"
          下面把这行按逗号拆开，逐个去 _data/coauthors.yml 查主页：
            查到 url -> 显示成超链接；查不到或没有 url -> 只显示姓名。
          最后一位合作者前面自动用 "and" 连接。
          没有 coauthors 字段的（独作论文）整段不显示。
        -->
        {% if link.coauthors and link.coauthors != "" %}
        <p class="publication-authors">
          with{% assign coauthor_names = link.coauthors | replace: " and ", ", " | replace: "  ", " " | split: "," %}{% for raw_name in coauthor_names %}{% assign name = raw_name | strip %}{% assign person = site.data.coauthors[name] %} {% if person.url and person.url != "" %}<a href="{{ person.url }}" target="_blank" rel="noopener">{{ name }}</a>{% else %}{{ name }}{% endif %}{% unless forloop.last %}{% if forloop.rindex == 2 %} and{% else %},{% endif %}{% endunless %}{% endfor %}
        </p>
        {% endif %}

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
