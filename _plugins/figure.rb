require "jekyll-spark"

module Jekyll
  class FigureComponent < ComponentTag
    def template(context)
      caption = @props["caption"]
      src = @props["src"]
      alt = @props["alt"]

      render = %Q[
        <figure class="figure">
          <img src="#{src}" class="figure-img img-fluid" alt="#{alt}">
          <figcaption class="figure-caption">#{caption}</figcaption>
        </figure>
      ]
    end
  end
end

Liquid::Template.register_tag(
  "Figure",
  Jekyll::FigureComponent,
)
