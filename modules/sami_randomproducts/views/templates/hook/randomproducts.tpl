
{if isset($random_products) && !empty($random_products)}
    <section class="product-randomproducts">
        {include file='components/section-title.tpl' title={l s='You might also like' d='Shop.Theme.Catalog'}}
        {include file='catalog/_partials/productlist.tpl' products=$random_products productClass='col-12 col-xs-6 col-lg-4 col-xl-3'}
    </section>
{/if}