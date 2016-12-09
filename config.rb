# Dir['extensions/*.rb'].each { |file| require file }
require 'extensions/remarky'
activate :remarky

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

remarks.each do |r|
  remark_name = File.basename(r)
  stylesheet = extract_stylesheet(r)
  proxy output_filename(remark_name), '/remark.html',
        layout: 'remark', locals: { remark: r, stylesheet: stylesheet }
end

proxy '/slides/', '/index.html'
proxy '/remarks', '/index.html'

# General configuration

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript
  ignore 'remark.html.haml'
end
