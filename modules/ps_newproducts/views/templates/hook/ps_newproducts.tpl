{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}

<section class="new-products mt-3">
    <div class="container sami-container">
        {include file='components/section-title.tpl' title={l s='New products' d='Shop.Theme.Catalog'} link=$allNewProductsLink}
        {include file='catalog/_partials/productlist.tpl' products=$products productClass='col-12 col-xs-6 col-lg-4 col-xl-3'}
    </div>
</section>
