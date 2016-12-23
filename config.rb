Dir['extensions/*.rb'].each { |file| require file }
activate :remarky

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

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
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash

  ignore 'remark.html.haml'
end

activate :deploy do |deploy|
  deploy.deploy_method   = :rsync
  #deploy.host            = ENV.fetch('DEPLOY_HOST')
  #deploy.path            = ENV.fetch('DEPLOY_DIR')
  deploy.build_before    = true
  deploy.clean           = true
end
