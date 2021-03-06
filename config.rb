###
# Blog settings
###

activate :blog do |blog|
  blog.permalink = "{title}.html"
  blog.layout = "layouts/blog"
  blog.summary_separator =/SPLIT_SUMMARY_BEFORE_THIS/
  blog.summary_length = 250
  blog.default_extension = ".markdown"
  blog.tag_template = "tag.html"
  blog.paginate = true
  blog.per_page = 10
  blog.page_link = "page:num"
end


page "/feed.xml", layout: false

  activate :directory_indexes

activate :deploy do |deploy|
 deploy.method = :git
   deploy.build_before = true
   deploy.branch   = "master"
end
###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", layout: false
#
# With alternative layout
# page "/path/to/file.html", layout: :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

###
# Helpers
###
helpers do

  def relative_path(path)
    basename = File.basename(current_page.path)
    File.join(basename, path)
  end

end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

set :host, "phironaka.com"

# Build-specific configuration

configure :build do
  activate :favicon_maker, :icons => {
    "_favicon_template.png" => [
      { icon: "apple-touch-icon-152x152-precomposed.png" },
      { icon: "apple-touch-icon-114x114-precomposed.png" },
      { icon: "apple-touch-icon-72x72-precomposed.png" },
       { icon: "favicon.png", size: "16x16" },
    ]
  }
end

def img(relative_path, alt=nil)
  if $current_listed_article.nil?
    # On page
    url = current_page.url
  else
    # In listing
    url = $current_listed_article.url
  end
  alt ? alt_attr = "alt='#{alt}' " : alt_attr = ''

  "<img #{alt_attr} src='#{url}/#{relative_path}'>"  # return
end

configure :build do
  # Minify Javascript on build
  activate :minify_javascript
  # Enable cache buster
  # activate :asset_hash
  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end


  
