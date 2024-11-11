# Building the Site: The Blog

*Published: 2024-11-09 by Kim* / 
*Last Update: 2024-11-11 by Kim*

Welcome to the blog! You'll find here posts about the process of building this site, as well as other topics that I 
find interesting.

Let's start a bit meta, with a post about building the blog itself.

## Why?

Since I want to build the site in public, I also want to share the journey here. In my opinion, the blog format is
a great way to document moments in time, and to share thoughts and ideas.

I reckon there will be plenty of lessons learned, challenges overcome and past decisions overruled, and will be nice to capture
those moments here.

## What?

I currently want a pretty basic setup that let's me push out content by deploying a new release. This lets me defer the 
data modeling until I have a better idea of what I want.

In addition, I wanted to be able to write posts in markdown (and rendered as HTML) since it is a in my opinion a
quick and handy way to produce structured content.

## How?

With `redcarpet` I found a markdown parser that seems well maintained and high adoption (with 92m downloads on RubyGems).

In the controller for the blog, I fetch the markdown file with the same name from disk and render it as HTML.
Clearly this is not a scalable solution, but it will do for now.

```ruby
post_filename = ActiveStorage::Filename.new("#{params[:slug]}.md").sanitized
markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, fenced_code_blocks: true)
@rendered_html = markdown.render(File.read("app/views/blogs/#{post_filename}"))
```

Also, since there is a file read based on user input, I will need to prevent directory traversal by sanitizing the 
slug in the first line.

## Next Steps & Final Thoughts

Once a visual identity is established, I will need to create a layout for the blog posts. 

If you want to follow along, you can find the code for this site on [GitHub](https://github.com/1klap/railsguru-web)

