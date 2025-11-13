{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$componentName = 'product-miniature'}

{block name='product_miniature_item'}
  <article
    class="{$componentName} js-{$componentName}{if !empty($productClasses)} {$productClasses}{/if}"
    data-id-product="{$product.id_product}"
    data-id-product-attribute="{$product.id_product_attribute}"
  >
    <div class="card">
      <a href="{$product.url}" class="{$componentName}__link">
        {include file='catalog/_partials/product-flags.tpl'}
      </a>
      {block name='product_miniature_image'}
        <div class="{$componentName}__image-container thumbnail-container">
          <a href="{$product.url}" class="{$componentName}__link">
            {if isset($product.cover) && $product.cover}

              {* визначаємо чи вимагаємо "оригінальної" (non-crop) картинки за легендою *}
              {assign var='use_original_aspect' value=false}
              {if isset($product.cover.legend) && $product.cover.legend != $product.name}
                {if $product.cover.legend == 'left' || $product.cover.legend == 'right' || $product.cover.legend == 'center'}
                  {assign var='use_original_aspect' value=true}
                {/if}
              {/if}

              {* Набори ключів: підстав свої реальні ключі з $product.cover.bySize *}
              {* non-crop — великі версії з оригінальною пропорцією *}
              {assign var='sizes_keys_noncrop' value=["fullscreen_product_xs","fullscreen_product_m","fullscreen_product_md","fullscreen_product_main"]}
              {* crop — квадратні (thumbnail) версії *}
              {assign var='sizes_keys_crop' value=["default_xs","default_m","default_md","product_main"]}

              {* обираємо набор відповідно до легенди *}
              {if $use_original_aspect}
                {assign var='sizes_keys' value=$sizes_keys_noncrop}
              {else}
                {assign var='sizes_keys' value=$sizes_keys_crop}
              {/if}

              {* Підготовка srcset-строк *}
              {assign var='srcset_avif' value=''}
              {assign var='srcset_webp' value=''}
              {assign var='srcset_fallback' value=''}

              {foreach from=$sizes_keys item=key}
                {if isset($product.cover.bySize[$key])}
                  {assign var='s' value=$product.cover.bySize[$key]}
                  {if isset($s.sources.avif)}
                    {assign var='srcset_avif' value=$srcset_avif|cat:$s.sources.avif|cat:" "|cat:$s.width|cat:"w, "}
                  {/if}
                  {if isset($s.sources.webp)}
                    {assign var='srcset_webp' value=$srcset_webp|cat:$s.sources.webp|cat:" "|cat:$s.width|cat:"w, "}
                  {/if}
                  {if isset($s.url)}
                    {assign var='srcset_fallback' value=$srcset_fallback|cat:$s.url|cat:" "|cat:$s.width|cat:"w, "}
                  {/if}
                {/if}
              {/foreach}

              {* trim *}
              {assign var='srcset_avif' value=$srcset_avif|trim}
              {assign var='srcset_webp' value=$srcset_webp|trim}
              {assign var='srcset_fallback' value=$srcset_fallback|trim}

              {* object-position згідно legend (твоя логіка) *}
              {assign var='image_style' value=''}
              {if isset($product.cover.legend) && $product.cover.legend != $product.name}
                {if $product.cover.legend == 'left'}
                  {assign var='image_style' value='object-position:left;'}
                {elseif $product.cover.legend == 'right'}
                  {assign var='image_style' value='object-position:right;'}
                {elseif $product.cover.legend == 'center'}
                  {assign var='image_style' value='object-position:center;'}
                {/if}
              {/if}

              {* sizes — підбери під свій макет; тут приклад, можна змінити *}
              {if $use_original_aspect}
                {assign var='sizes_attr' value="(max-width:600px) 100vw, (max-width:1200px) 60vw, 40vw"}
              {else}
                {assign var='sizes_attr' value="(max-width:600px) 100vw, (max-width:1200px) 33vw, 25vw"}
              {/if}

              <picture>
                {if $srcset_avif neq ''}
                  <source type="image/avif" srcset="{$srcset_avif}" sizes="{$sizes_attr}">
                {/if}

                {if $srcset_webp neq ''}
                  <source type="image/webp" srcset="{$srcset_webp}" sizes="{$sizes_attr}">
                {/if}

                {* fallback img: на випадок якщо нічого не згенеровано - беремо original через getImageLink *}
                <img class="product-miniature__image card-img-top"
                  src="{if isset($product.cover.bySize[$sizes_keys[0]].url)}{$product.cover.bySize[$sizes_keys[0]].url}{else}{$product.cover.bySize.default_md.url}{/if}"
                  {if $srcset_fallback neq ''}srcset="{$srcset_fallback}"{/if}
                  sizes="{$sizes_attr}"
                  alt="{$product.name|escape:'html'}"
                  loading="lazy"
                  decoding="async"
                  style="{$image_style}"
                />
              </picture>
            {else}
              <picture>
                {if isset($urls.no_picture_image.bySize.default_md.sources.avif)}
                  <source
                    srcset="
                      {$urls.no_picture_image.bySize.default_xs.sources.avif} 120w,
                      {$urls.no_picture_image.bySize.default_m.sources.avif} 200w,
                      {$urls.no_picture_image.bySize.default_md.sources.avif} 320w,
                      {$urls.no_picture_image.bySize.product_main.sources.avif} 720w"
                    sizes="(min-width: 1300px) 720px, (min-width: 768px) 50vw, 50vw"
                    type="image/avif"
                  >
                {/if}

                {if isset($urls.no_picture_image.bySize.default_md.sources.webp)}
                  <source
                    srcset="
                      {$urls.no_picture_image.bySize.default_xs.sources.webp} 120w,
                      {$urls.no_picture_image.bySize.default_m.sources.webp} 200w,
                      {$urls.no_picture_image.bySize.default_md.sources.webp} 320w,
                      {$urls.no_picture_image.bySize.product_main.sources.webp} 720w"
                    sizes="(min-width: 1300px) 320px, (min-width: 768px) 120px, 50vw"
                    type="image/webp"
                  >
                {/if}

                <img
                  class="{$componentName}__image card-img-top"
                  srcset="
                    {$urls.no_picture_image.bySize.default_xs.url} 120w,
                    {$urls.no_picture_image.bySize.default_m.url} 200w,
                    {$urls.no_picture_image.bySize.default_md.url} 320w,
                    {$urls.no_picture_image.bySize.product_main.url} 720w"
                  sizes="(min-width: 1300px) 320px, (min-width: 768px) 120px, 50vw"
                  width="{$urls.no_picture_image.bySize.default_md.width}"
                  height="{$urls.no_picture_image.bySize.default_md.height}"
                  src="{$urls.no_picture_image.bySize.default_md.url}"
                  loading="lazy"
                  alt="{l s='No image available' d='Shop.Theme.Catalog'}"
                  title="{l s='No image available' d='Shop.Theme.Catalog'}"
                  data-full-size-image-url="{$urls.no_picture_image.bySize.home_default.url}"
                >
              </picture>
            {/if}
          </a>
          {hook h='displayProductActions' product=$product}
          <a href="{$product.url}" class="{$componentName}__view-link">
            <svg class="action-cart-icon action-icon" viewBox="0 0 35 35" xmlns="http://www.w3.org/2000/svg">
              <path class="action-icon-outline" d="M10.5097 35C9.54632 35 8.7216 34.6573 8.03555 33.9719C7.3495 33.2865 7.00647 32.4625 7.00647 31.5C7.00647 30.5375 7.3495 29.7135 8.03555 29.0281C8.7216 28.3427 9.54632 28 10.5097 28C11.4731 28 12.2978 28.3427 12.9839 29.0281C13.6699 29.7135 14.0129 30.5375 14.0129 31.5C14.0129 32.4625 13.6699 33.2865 12.9839 33.9719C12.2978 34.6573 11.4731 35 10.5097 35ZM28.0259 35C27.0625 35 26.2378 34.6573 25.5517 33.9719C24.8657 33.2865 24.5227 32.4625 24.5227 31.5C24.5227 30.5375 24.8657 29.7135 25.5517 29.0281C26.2378 28.3427 27.0625 28 28.0259 28C28.9893 28 29.814 28.3427 30.5001 29.0281C31.1861 29.7135 31.5291 30.5375 31.5291 31.5C31.5291 32.4625 31.1861 33.2865 30.5001 33.9719C29.814 34.6573 28.9893 35 28.0259 35ZM9.02083 7L13.2247 15.75H25.486L30.303 7H9.02083ZM7.3568 3.5H33.1932C33.8646 3.5 34.3755 3.79896 34.7258 4.39688C35.0762 4.99479 35.0908 5.6 34.7696 6.2125L28.5514 17.4125C28.2302 17.9958 27.7996 18.4479 27.2596 18.7687C26.7195 19.0896 26.1283 19.25 25.486 19.25H12.4365L10.5097 22.75H31.5291V26.25H10.5097C9.196 26.25 8.20341 25.674 7.53196 24.5219C6.86051 23.3698 6.83131 22.225 7.44438 21.0875L9.80906 16.8L3.50324 3.5H0V0H5.69276L7.3568 3.5Z"/>
              <path class="action-icon-filler" d="M9.02083 7L13.2247 15.75H25.486L30.303 7H9.02083Z"/>
            </svg>
          </a>
        </div>
      {/block}

      {block name='product_miniature_bottom'}
        <div class="{$componentName}__infos card-body">
          <div class="{$componentName}__infos__top">
            {block name='product_category'}
              <a href="{$link->getCategoryLink($product.id_category_default)}" class="{$componentName}__category"><p>{$product.category_name}</p></a>
            {/block}

            {block name='product_reviews'}
              {hook h='displayProductListReviews' product=$product}
            {/block}

          </div>

          <div class="{$componentName}__infos__middle">
            {block name='product_name'}
              <a href="{$product.url}" class="{$componentName}__title"><p>{$product.name}</p></a>
            {/block}
          </div>

          <div class="{$componentName}__infos__bottom">
            {if true == false}
              {block name='product_variants'}
                <div class="{$componentName}__variants">
                  {if $product.main_variants}
                    {include file='catalog/_partials/variant-links.tpl' variants=$product.main_variants}
                  {/if}
                </div>
              {/block}
            {/if}

            <div class="{$componentName}__prices">
              {block name='product_price'}
                {if $product.show_price}
                  {hook h='displayProductPriceBlock' product=$product type="before_price"}

                  <span class="{$componentName}__price" aria-label="{l s='Price' d='Shop.Theme.Catalog'}">
                    {capture name='custom_price'}{hook h='displayProductPriceBlock' product=$product type='custom_price' hook_origin='products_list'}{/capture}
                    {if '' !== $smarty.capture.custom_price}
                      {$smarty.capture.custom_price nofilter}
                    {else}
                      {$product.price}
                    {/if}
                  </span>

                  {hook h='displayProductPriceBlock' product=$product type='unit_price'}

                  {hook h='displayProductPriceBlock' product=$product type='weight'}
                {/if}
              {/block}

              {block name='product_discount_price'}
                {if $product.show_price}
                  <div class="{$componentName}__discount-price">
                    {if $product.has_discount}
                      {hook h='displayProductPriceBlock' product=$product type="old_price"}

                      <span class="{$componentName}__regular-price" aria-label="{l s='Regular price' d='Shop.Theme.Catalog'}">{$product.regular_price}</span>
                    {/if}
                  </div>
                {/if}
              {/block}
            </div>
          </div>
        </div>
      {/block}
    </div>
  </article>
{/block}
