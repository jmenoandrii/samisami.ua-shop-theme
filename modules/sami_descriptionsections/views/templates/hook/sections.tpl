{if $description_sections}
  {foreach $description_sections as $s}
    <div class="product-description__item">
      <h3 class="product-description__title">{$s.title}</h3>
      <div class="product-description__content rich-text">{$s.content nofilter}</div>
    </div>
  {/foreach}
{else}
  <div class="product-description__item">
    <h3 class="product-description__title">{l s='Description' d='Shop.Theme.Catalog'}</h3>
    <div class="product-description__content rich-text">{$product.description nofilter}</div>
  </div>
{/if}