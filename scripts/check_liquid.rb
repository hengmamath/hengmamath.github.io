#!/usr/bin/env ruby
# frozen_string_literal: true
#
# 检查所有 .md / .html 文件的 Liquid 语法。
#
#   ruby scripts/check_liquid.rb
#
# 为什么需要它：GitHub Pages 用的是 github-pages gem，比本地 jekyll 多装了
# jekyll-optional-front-matter 等插件，会把**没有 front matter 的 .md 也当页面渲染**
# —— 包括 README。所以在 README 里写 `{% ... %}` 当示例（哪怕包在反引号或代码块里，
# 反引号挡不住 Liquid）会让线上构建直接失败，而本地 jekyll build 完全不报错。
#
# 在 README 之类的文档里写 Liquid 示例，必须包在 {% raw %} … {% endraw %} 里。
#
# 退出码：有语法错误 -> 1。

require "liquid"

# Jekyll 和它的插件自带一些 Liquid 核心没有的标签。这里注册成空实现，
# 否则它们会被误报成语法错误。真正不认识的标签（比如落单的 when）仍会报错。
JEKYLL_TAGS       = %w[include_relative link post_url seo gist avatar
                       github_edit_link imgproc].freeze
JEKYLL_TAG_BLOCKS = %w[highlight].freeze
JEKYLL_TAGS.each       { |t| Liquid::Template.register_tag(t, Class.new(Liquid::Tag)) }
JEKYLL_TAG_BLOCKS.each { |t| Liquid::Template.register_tag(t, Class.new(Liquid::Block)) }

ROOT = File.expand_path("..", __dir__)
SKIP = %w[_site html_source_file .git .jekyll-cache node_modules vendor].freeze

files = Dir.chdir(ROOT) { Dir.glob("**/*.{md,html}") }
              .reject { |f| SKIP.any? { |d| f.start_with?("#{d}/") } }
              .sort

errors = []
files.each do |rel|
  body = File.read(File.join(ROOT, rel), encoding: "UTF-8")
  # 去掉 YAML front matter，Jekyll 也是这么做的
  body = body.sub(/\A---\s*\n.*?\n---\s*\n/m, "")
  next unless body.include?("{%") || body.include?("{{")

  begin
    Liquid::Template.parse(body)
  rescue Liquid::SyntaxError => e
    errors << [rel, e.message]
  end
end

puts "检查了 #{files.size} 个 .md / .html 文件的 Liquid 语法。"

if errors.empty?
  puts "\n✅ 没有语法错误。"
  exit 0
else
  puts "\n❌ 以下文件会让 GitHub Pages 构建失败："
  errors.each do |rel, msg|
    puts "  #{rel}"
    puts "    #{msg}"
    puts "    → 文档里的 Liquid 示例请包在 {% raw %} … {% endraw %} 里"
  end
  exit 1
end
