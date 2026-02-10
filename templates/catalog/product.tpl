{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{extends file=$layout}

{block name='head' append}
  <meta property="og:type" content="product">
  <meta content="{$product.url}">

  {if $product.cover}
    <meta property="og:image" content="{$product.cover.large.url}">
  {/if}

  {if $product.show_price}
    <meta property="product:pretax_price:amount" content="{$product.price_tax_exc}">
    <meta property="product:pretax_price:currency" content="{$currency.iso_code}">
    <meta property="product:price:amount" content="{$product.price_amount}">
    <meta property="product:price:currency" content="{$currency.iso_code}">
  {/if}
  {if isset($product.weight) && ($product.weight != 0)}
  <meta property="product:weight:value" content="{$product.weight}">
  <meta property="product:weight:units" content="{$product.weight_unit}">
  {/if}
{/block}

{block name='head_microdata_special'}
  {include file='_partials/microdata/product-jsonld.tpl'}
{/block}

{block name='content'}
  {* FIRST PART - PHOTO, NAME, PRICES, ADD TO CART*}
  {$componentName = 'product'}
  <div class="{$componentName} product-container js-product-container">
    <div class="{$componentName}__left">
      {block name='product_cover_thumbnails'}
        {include file='catalog/_partials/product-cover-thumbnails.tpl'}
      {/block}
    </div>

    <div class="{$componentName}__right {$componentName}__col">
      {block name='product_header'}
        <h1 class="{$componentName}__name">{block name='page_title'}{$product.name}{/block}</h1>
      {/block}

      {block name='product_prices'}
        {include file='catalog/_partials/product-prices.tpl'}

        {block name='product_availability'}
          <div id="product-availability" class="product-availability js-product-availability">
            {if $product.show_availability}
              <h4 class="product-availability__title">
                {if $product.quantity >= 1}
                  <strong>
                  {l s='In stock' d='Shop.Theme.Catalog'}: 
                  </strong>
                  <span>
                  {if $product.quantity <= Configuration::get('PS_LAST_QTIES')}
                  {l s='Only %q% left!' sprintf=['%q%' => $product.quantity] d='Shop.Theme.Catalog'}
                  {else}
                    {$product.quantity}
                  {/if}
                  </span>
                {elseif $product.availability == 'available'}
                  <span>{l s='Made to order!' d='Shop.Theme.Catalog'}</span>
                {else}
                  <span>{l s='Currently out of stock!' d='Shop.Theme.Catalog'}</span>
                {/if}
              </h4>
            {/if}
          </div>
        {/block}
      {/block}

      {block name='product_description_short'}
        <div class="{$componentName}__description-short rich-text">{$product.description_short nofilter}</div>
      {/block}

      {block name='product_customization' hide}
        {if $product.is_customizable && count($product.customizations.fields)}
          {include file='catalog/_partials/product-customization.tpl' customizations=$product.customizations}
        {/if}
      {/block}

      <div class="{$componentName}__actions js-product-actions">
        {block name='product_buy'}
          <form action="{$urls.pages.cart}" method="post" id="add-to-cart-or-refresh">
            <input type="hidden" name="token" value="{$static_token}">
            <input type="hidden" name="id_product" value="{$product.id}" id="product_page_product_id">
            <input type="hidden" name="id_customization" value="{$product.id_customization}" id="product_customization_id" class="js-product-customization-id">

            {block name='product_variants'}
              {include file='catalog/_partials/product-variants.tpl'}
            {/block}

            {block name='product_pack'}
              {if $packItems}
                {include file='catalog/_partials/product-pack.tpl'}
              {/if}
            {/block}

            {block name='product_discounts'}
              {include file='catalog/_partials/product-discounts.tpl'}
            {/block}

            {block name='product_add_to_cart'}
              {include file='catalog/_partials/product-add-to-cart.tpl'}
            {/block}

            {block name='product_additional_info' hide}
              {include file='catalog/_partials/product-additional-info.tpl'}
            {/block}

            {block name='product_out_of_stock'}
              {hook h='actionProductOutOfStock' product=$product}
            {/block}

            {* Input to refresh product HTML removed, block kept for compatibility with themes *}
            {block name='product_refresh'}{/block}
          </form>
        {/block}
      </div>{* /product-actions *}
    </div>{* /col *}
  </div>{* /row *}
  {* END OF FIRST PART *}

  {* SECOND PART - REASSURANCE, TABS *}
  <div class="{$componentName}-bottom">
    {block name='product_tabs'}
        <ul class="product-tabs">
          {if $product.description}
            <li class="product-tabs__item">
              <a class="product-tabs__link" data-id="product-description">{l s='Product Details' d='Shop.Theme.Catalog'}</a>
            </li>
          {/if}
          {if $product.grouped_features}
            <li class="product-tabs__item">
              <a class="product-tabs__link" data-id="product-features">{l s='Data sheet' d='Shop.Theme.Catalog'}</a>
            </li>
          {/if}
          <li class="product-tabs__item">
            <a class="product-tabs__link" data-id="product-comments">{l s='Comments' d='Modules.Productcomments.Shop'}</a>
          </li>
          <li class="product-tabs__item product-tabs__item-close">
            <a class="product-tabs__close">
              <i class="material-symbols-outlined" aria-hidden="true">close</i>
            </a>
          </li>

        </ul>
        <div class="product__infos" id="product-infos-accordion">

          {block name='product_description'}
            {if $product.description}
              <div id="product-description" class="product-tabs__content product-description">
                {hook h='displayProductDescription' product=$product}
              </div>
            {/if}
          {/block}

          {block name='product_features'}
            {if $product.grouped_features}
              <div id="product-features" class="product-tabs__content product-features">
                <ul class="product-features__details">
                  {foreach from=$product.grouped_features item=feature}
                    <li class="detail">
                      <div class="detail__left">
                        <span class="detail__title">{$feature.name}</span>
                      </div>

                      <div class="detail__right">
                        <span>{$feature.value|escape:'htmlall'|nl2br nofilter}</span>
                      </div>
                    </li>
                  {/foreach}
                </ul>
              </div>
            {/if}
          {/block}

          {block name='product_footer'}
            <div id="product-comments" class="product-tabs__content product-comments">
              {hook h='displayFooterProduct' product=$product category=$category}
            </div>
          {/block}

          {block name='product_details' hide}
            {include file='catalog/_partials/product-details.tpl'}
          {/block}

          {block name='product_attachments' hide}
            {if $product.attachments}
              <div class="info accordion-item" id="attachments">
                <h2 class="info__title accordion-header" id="product-attachments-heading">
                  <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#product-attachments-collapse" aria-expanded="true" aria-controls="product-attachments-collapse">
                    {l s='Download' d='Shop.Theme.Actions'}
                  </button>
                </h2>
                <div id="product-attachments-collapse" class="info__content accordion-collapse collapse" data-bs-parent="#product-infos-accordion" aria-labelledby="product-attachments-heading">
                  <div class="product__attachments accordion-body">
                    {foreach from=$product.attachments item=attachment}
                      <div class="attachment">
                        <p class="h5"><a href="{url entity='attachment' params=['id_attachment' => $attachment.id_attachment]}">{$attachment.name}</a></p>
                        <p>{$attachment.description}</p>
                        <a href="{url entity='attachment' params=['id_attachment' => $attachment.id_attachment]}">
                          {l s='Download' d='Shop.Theme.Actions'} ({$attachment.file_size_formatted})
                        </a>
                      </div>
                    {/foreach}
                  </div>
                </div>
              </div>
            {/if}
          {/block}

          {* New collapses for module hooked content *}
          {foreach from=$product.extraContent item=extra key=extraKey}
            <div class="info accordion-item" id="extra-{$extraKey}" {foreach $extra.attr as $key => $val} {$key}="{$val}"{/foreach}>
              <h2 class="info__title accordion-header" id="product-extra{$extraKey}-heading">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#product-extra{$extraKey}-collapse" aria-expanded="true" aria-controls="product-extra{$extraKey}-collapse">
                  {$extra.title}
                </button>
              </h2>
              <div id="product-extra{$extraKey}-collapse" class="info__content accordion-collapse collapse" data-bs-parent="#product-infos-accordion" aria-labelledby="product-extra{$extraKey}-heading">
                <div class="accordion-body">
                  {$extra.content nofilter}
                </div>
              </div>
            </div>
          {/foreach}

        </div>
    {/block}
  </div>{* /row *}
  {* END OF SECOND PART *}

  {block name='product_accessories'}
    {if $accessories}
      {include file='catalog/_partials/product-accessories.tpl'}
    {/if}
  {/block}

  {block name='page_footer_container'}
    {block name='page_footer'}
    {/block}
  {/block}
{/block}
