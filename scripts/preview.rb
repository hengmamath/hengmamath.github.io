#!/usr/bin/env ruby
# frozen_string_literal: true

# 本地预览：ruby scripts/preview.rb
# 换端口：ruby scripts/preview.rb --port 4002
# 直接使用 Ruby 已安装的 Jekyll，不依赖终端是否能找到 jekyll 命令。
require "rubygems"

Dir.chdir(File.expand_path("..", __dir__)) do
  ARGV.unshift("serve", "--host", "127.0.0.1")
  load Gem.bin_path("jekyll", "jekyll")
end
