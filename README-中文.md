# Heng Ma Academic Homepage 维护说明

这份说明是给以后自己改网页用的。大多数情况下，你只需要改 `.md` 或 `.yml` 文件，不需要碰 HTML / CSS。

## 先看网页效果

进入这个文件夹：

```bash
cd /Users/heng/Library/CloudStorage/OneDrive-Technion/Documents/Codes/Homepage/ai
```

启动本地预览：

```bash
jekyll serve
```

然后在浏览器打开：

```text
http://localhost:4000
```

如果 4000 端口被占用，用：

```bash
jekyll serve --port 4001
```

然后打开：

```text
http://localhost:4001
```

## 最常改的文件

### 1. 改 Home 页面文字

文件：

```text
index.md
```

这里改首页正文，比如：

- Introduction
- Academic Background
- Research Interests
- Selected Links

一般只需要改 `---` 下面的正文部分。

### 2. 改 Research 页面正文

文件：

```text
research.md
```

这里主要控制 Research 页面正文，以及是否显示论文列表。

不要删掉这一行：

```liquid
{% include_relative _includes/publications.md %}
```

这一行负责把论文列表显示出来。

### 3. 添加、删除、修改论文

文件：

```text
_data/publications.yml
```

每篇论文长这样：

```yaml
- title: "Paper Title"
  coauthors: "Name One and Name Two"
  authors:
    - name: "Name One"
      url: "https://example.com"
    - name: "Name Two"
      url:
  journal: "arxiv, 2026+"
  arXiv: "https://arxiv.org/abs/xxxx.xxxxx"
  image: "assets/img/example.png"
  talk: "assets/files/example_talk.pdf"
  poster: "assets/files/example_poster.pdf"
```

说明：

- `title`: 论文标题
- `coauthors`: 旧版纯文字合作者信息，建议保留
- `authors`: 新版合作者列表，可以加主页链接
- `url`: 合作者主页；没有主页就留空
- `journal`: 期刊、会议、arXiv 状态
- `arXiv`: arXiv 链接
- `journalpage`: 期刊正式页面链接，如果有就加
- `image`: Research 页面里的论文图片
- `talk`: slides PDF
- `poster`: poster PDF

如果要给合作者加主页链接，改这里：

```yaml
authors:
  - name: "Pascal Maillard"
    url: "https://example.com"
```

如果没有主页链接，写成：

```yaml
authors:
  - name: "Pascal Maillard"
    url:
```

### 4. 改 Teaching 页面

文件：

```text
teaching.md
```

以后课程信息、讲义、作业、office hour 都可以写在这里。

### 5. 改个人基本信息

文件：

```text
_config.yml
```

常用项目：

```yaml
title: Heng Ma
title_cn: 马恒
position: Postdoc
affiliation: Technion
affiliation_link: https://probability.technion.ac.il
email: hengmamath (at) gmail.com ; heng.ma (at) campus.technion.ac.il
cv_link: assets/files/CV_Heng_Ma.pdf
google_scholar: ...
orcid: ...
avatar: assets/img/avatar.png
```

比如要换头像，就把新图片放到：

```text
assets/img/
```

然后修改：

```yaml
avatar: assets/img/your_new_photo.png
```

### 6. 添加图片、PDF、slides

图片放这里：

```text
assets/img/
```

PDF、CV、slides、poster 放这里：

```text
assets/files/
```

然后在 `_data/publications.yml` 里引用它们，例如：

```yaml
image: "assets/img/my_picture.png"
talk: "assets/files/my_slides.pdf"
poster: "assets/files/my_poster.pdf"
```

## 不太常改的文件

### 改网页整体布局

文件：

```text
_layouts/homepage.html
```

这里控制：

- 顶部导航栏
- Home / Research / Teaching 的整体页面结构
- Home 页面左侧个人信息栏

不熟悉 HTML / Liquid 时，尽量不要改这个文件。

### 改论文列表的显示格式

文件：

```text
_includes/publications.md
```

这里控制 Research 页面每篇论文怎么显示，包括：

- 论文标题
- 合作者
- journal / arXiv 信息
- journal / arXiv / poster / slides 按钮

如果只是添加论文，不要改这个文件；改 `_data/publications.yml` 就够了。

### 改颜色、宽度、字体大小、间距

文件：

```text
_sass/academic-site.scss
```

常见位置：

- 普通链接颜色：`--link`
- 标题深蓝色：`--accent`
- Research 页面宽度：`.page-layout.no-sidebar .content-panel`
- 论文图片大小：`.publications ol.bibliography li.publication-item`
- 导航栏字体大小：`.site-nav a`

深色模式颜色在：

```text
_sass/academic-site-dark.scss
```

## Markdown 最基本写法

标题：

```markdown
## Section Title
```

列表：

```markdown
- item one
- item two
```

链接：

```markdown
[显示文字](https://example.com)
```

加粗：

```markdown
**important text**
```

## 每次修改后的检查

改完后运行：

```bash
jekyll serve
```

然后刷新浏览器看效果。

如果网页报错，优先检查：

1. `_data/publications.yml` 里的缩进是否正确。
2. 每个冒号 `:` 后面是否有空格。
3. 文件路径是否真的存在。
4. 引号是否成对出现。

YAML 文件最怕缩进错。比如下面这种是正确的：

```yaml
authors:
  - name: "Name One"
    url: "https://example.com"
  - name: "Name Two"
    url:
```

## 最简单的维护原则

- 改首页文字：改 `index.md`
- 改 Research 说明：改 `research.md`
- 改论文：改 `_data/publications.yml`
- 改 Teaching：改 `teaching.md`
- 改姓名、邮箱、头像、CV 链接：改 `_config.yml`
- 改颜色和页面宽度：改 `_sass/academic-site.scss`
- 不确定时，不要先改 `_layouts/homepage.html`
