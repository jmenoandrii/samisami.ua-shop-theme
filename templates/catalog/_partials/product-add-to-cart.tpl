{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
<div class="product__add-to-cart product-add-to-cart js-product-add-to-cart">
  {if !$configuration.is_catalog}
    {block name='product_quantity'}
      <div class="product-actions-container">
        <div class="product-actions__quantity quantity-button js-quantity-button">
          {include file='components/qty-input.tpl'
            attributes=[
              "id" => "quantity_wanted",
              "class" => "form-control js-quantity-wanted",
              "value" => "{$product.minimal_quantity}",
              "min" => "{$product.minimal_quantity}"
            ]
          }
        </div>

        <div class="product-actions__button add">
          <button
            class="add-to-cart"
            data-button-action="add-to-cart"
            type="submit"
            {if !$product.add_to_cart_url}
              disabled
            {/if}
         >
            {l s='Add to cart' d='Shop.Theme.Actions'}
          </button>
        </div>

      </div>
    {/block}

    {block name='product_minimal_quantity' hide}
      <p class="product__minimal-quantity product-minimal-quantity js-product-minimal-quantity d-flex align-items-center mt-3 mt-md-0">
        {if $product.minimal_quantity> 1}
          <i class="material-icons me-2" aria-hidden="true">&#xE88F;</i>
          {l
            s='The minimum purchase order quantity for the product is %quantity%.'
            d='Shop.Theme.Checkout'
            sprintf=['%quantity%' => $product.minimal_quantity]
          }
        {/if}
      </p>
    {/block}
  {/if}
</div>
