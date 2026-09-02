#!/usr/bin/env ruby
# frozen_string_literal: true
#
# 校验 _data/publications.yml 里的合作者名字是否都在 _data/coauthors.yml 中登记。
#
#   ruby scripts/check_coauthors.rb
#
# 为什么需要它：名字写错时网页不会报错，只会静默地少一个主页链接，
# 很难肉眼发现。这个脚本把这类问题直接列出来。
#
# 退出码：名字对不上 -> 1（其余情况 0，只是提示）。

require "yaml"

ROOT = File.expand_path("..", __dir__)
PUBS = File.join(ROOT, "_data", "publications.yml")
DIR  = File.join(ROOT, "_data", "coauthors.yml")

def load_yaml(path)
  YAML.load_file(path) || {}
rescue Psych::SyntaxError => e
  abort "❌ #{File.basename(path)} YAML 语法错误：#{e.message}"
end

papers    = load_yaml(PUBS)["main"] || []
directory = load_yaml(DIR)

# 与模板一致的拆分方式："A and B" / "A, B" 都拆成 ["A", "B"]
def split_names(field)
  field.to_s.gsub(" and ", ", ").gsub(/ {2,}/, " ").split(",").map(&:strip).reject(&:empty?)
end

used = Hash.new { |h, k| h[k] = [] } # 名字 => 出现在哪些论文
papers.each do |paper|
  split_names(paper["coauthors"]).each { |name| used[name] << paper["title"] }
end

errors   = []
warnings = []
notes    = []

# 1. 论文里用到、但通讯录没登记的名字（多半是拼写不一致）
(used.keys - directory.keys).sort.each do |name|
  hint = directory.keys.find { |k| k.downcase.gsub(/[^a-z]/, "") == name.downcase.gsub(/[^a-z]/, "") }
  msg  = "  «#{name}»  —— 出现在：#{used[name].first.to_s[0, 60]}…"
  msg += "\n      通讯录里有个很像的：«#{hint}» —— 是不是拼写不一致？" if hint
  errors << msg
end

# 2. 通讯录条目格式检查（防止 ulr: 之类的手滑）
directory.each do |name, info|
  next if info.nil?
  unless info.is_a?(Hash)
    errors << "  «#{name}»  —— 格式不对，应该是 `url:` / `sort_as:` 缩进在名字下面"
    next
  end
  bad = info.keys - %w[url sort_as]
  errors << "  «#{name}»  —— 无法识别的字段 #{bad.join(', ')}（只支持 url / sort_as）" unless bad.empty?
end

# 3. 登记了但还没有共同论文的人
(directory.keys - used.keys).sort.each { |name| warnings << "  «#{name}»" }

# 4. 还没有主页链接的人
used.keys.sort.each do |name|
  info = directory[name]
  notes << "  «#{name}»" if info.nil? || info["url"].to_s.strip.empty?
end

puts "论文 #{papers.size} 篇，合作者 #{used.size} 人，通讯录 #{directory.size} 条。"

unless errors.empty?
  puts "\n❌ 名字对不上（网页会少掉主页链接）："
  puts errors
end

unless warnings.empty?
  puts "\n⚠️  通讯录里登记了、但还没有共同论文（不会显示在 Coauthors 名单里）："
  puts warnings
end

unless notes.empty?
  puts "\nℹ️  还没有主页链接（只显示姓名，属正常情况）："
  puts notes
end

if errors.empty?
  puts "\n✅ 全部名字都能查到。"
  exit 0
else
  exit 1
end
