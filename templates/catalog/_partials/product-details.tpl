
<div
  class="info js-product-details accordion-item"
  id="product-details"
  data-product="{$product.embedded_attributes|json_encode}"
>
  <h2 class="info__title accordion-header" id="product-details-heading">
    <button class="accordion-button {if $product.description}collapsed{/if}" type="button" data-bs-toggle="collapse" data-bs-target="#product-details-collapse" aria-expanded="{if $product.description}false{else}true{/if}"
      aria-controls="product-details-collapse">
      {l s='Product Details' d='Shop.Theme.Catalog'}
    </button>
  </h2>
  <div id="product-details-collapse" class="info__content accordion-collapse collapse {if !$product.description}show{/if}" data-bs-parent="#product-details-heading" aria-labelledby="product-details-heading">
    <div class="accordion-body">
      <ul class="product__details">
        {block name='product_manufacturer' hide}
          {if isset($product_manufacturer->id)}
            <li class="detail">
              <div class="detail__left">
                <span class="detail__title">{l s='Brand' d='Shop.Theme.Catalog'}</span>
              </div>

              <div class="detail__right">
                {if isset($manufacturer_image_url)}
                  <a href="{$product_brand_url}">
                    <img src="{$manufacturer_image_url}" class="img-fluid detail__manufacturer-logo" alt="{$product_manufacturer->name}" loading="lazy" width="98" height="50">
                  </a>
                {else}
                  <a href="{$product_brand_url}">{$product_manufacturer->name}</a>
                {/if}
              </div>
            </li>
          {/if}
        {/block}

        {block name='product_reference' hide}
          {if !empty($product.reference_to_display)}
            <li class="detail">
              <div class="detail__left">
                <span class="detail__title">{l s='Reference' d='Shop.Theme.Catalog'}</span>
              </div>

              <div class="detail__right">
                <span>{$product.reference_to_display}</span>
              </div>
            </li>
          {/if}
        {/block}

        {block name='product_quantities'}
          {if $product.show_quantities}
            <li class="detail">
              <div class="detail__left">
                <span class="detail__title">{l s='In stock' d='Shop.Theme.Catalog'}</span>
              </div>

              <div class="detail__right">
                <span data-stock="{$product.quantity}" data-allow-oosp="{$product.allow_oosp}">{$product.quantity} {$product.quantity_label}</span>
              </div>
            </li>
          {/if}
        {/block}

        {block name='product_availability_date'}
          {if $product.availability_date}
            <li class="detail">
              <div class="detail__left">
                <span class="detail__title">{l s='Availability date:' d='Shop.Theme.Catalog'}</span>
              </div>

              <div class="detail__right">
                <span>{$product.availability_date}</span>
              </div>
            </li>
          {/if}
        {/block}

        {* if product have specific references, a table will be added to product details section *}
        {block name='product_condition'}
          {if $product.condition}
            <li class="detail">
              <div class="detail__left">
                <span class="detail__title">{l s='Condition' d='Shop.Theme.Catalog'}</span>
              </div>

              <div class="detail__right">
                <span>{$product.condition.label}</span>
              </div>
            </li>
          {/if}
        {/block}

        {block name='product_specific_references'}
          {if !empty($product.specific_references)}
            {foreach from=$product.specific_references item=reference key=key}
              <li class="detail">
                <div class="detail__left">
                  <span class="detail__title">{$key}</span>
                </div>

                <div class="detail__right">
                  <span>{$reference}</span>
                </div>
              </li>
            {/foreach}
          {/if}
        {/block}
      </ul>
    </div>
  </div>
</div>
