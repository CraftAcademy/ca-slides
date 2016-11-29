# The code for this extension is taken from https://github.com/camerond/remarkymark/blob/master/config.rb
# Authored by Cameron Daigle (https://github.com/camerond)
class Remarky < Middleman::Extension
  expose_to_config :remarks, :remark_link, :extract_content,
                   :extract_stylesheet, :stylesheet_regex
  expose_to_template :remarks, :remark_link, :extract_content

  def remarks
    Dir.glob('source/remarks/*.remark')
  end

  def remark_link(file)
    filename = File.basename(file, '.remark')
    title = filename.tr('_', ' ').titleize
    url = "/remarks/#{filename}.remark"

    app.link_to title, url
  end

  def extract_content(filename)
    file = File.read(filename)
    file.sub(stylesheet_regex, '')
  end

  def extract_stylesheet(filemane)
    file = File.read(filemane)
    stylesheet_regex.match(file) { |m| m[1] } || 'default'
  end

  def stylesheet_regex
    /\A!!! (\S*)$/
  end

  ::Middleman::Extensions.register(:remarky, Remarky)
end
