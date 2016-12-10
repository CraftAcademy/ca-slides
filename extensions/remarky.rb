# The code for this extension is taken from https://github.com/camerond/remarkymark/blob/master/config.rb
# Authored by Cameron Daigle (https://github.com/camerond)
class Remarky < Middleman::Extension
  expose_to_config :remarks, :remark_link, :extract_content,
                   :extract_stylesheet, :stylesheet_regex, :output_filename
  expose_to_template :remarks, :remark_link, :extract_content, :slide_title

  def remarks
    Dir.glob('source/slides/*.remark')
  end

  def remark_link(file, css_class = '')
    filename = file_name(file)
    title = slide_title(file)
    url = "/slides/#{filename}.html"

    app.link_to title, url, class: css_class
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

  def slide_title(file)
    filename = file_name(file)
    filename.tr('_', ' ').titleize
  end

  def file_name(file)
    File.basename(file, '.remark')
  end

  def output_filename(file)
    "/slides/#{file_name(file)}.html"
  end

  ::Middleman::Extensions.register(:remarky, Remarky)
end
