{foreach $description_sections as $s}
  <div class="product-description__item">
    <h3 class="product-description__title">{$s.title}</h3>
    <div class="product-description__content rich-text">{$s.content nofilter}</div>
  </div>
{/foreach}
