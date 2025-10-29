{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$headerTopName = 'header-top'}
{$headerBottomName = 'header-bottom'}

{block name='header_banner'}
  <div class="header__banner">
    {hook h='displayBanner'}
  </div>
{/block}

{block name='header_nav'}
  <nav class="{$headerTopName}">
    <div class="sami-container {$headerTopName}__container">
      <div class="{$headerTopName}-desktop d-none d-md-flex row">
        <div class="{$headerTopName}__left col-12">
          {hook h='displayNav1'}
        </div>

        <div class="{$headerTopName}__right d-none">
          {hook h='displayNav2'}
        </div>
      </div>
    </div>
  </nav>
{/block}

{block name='header_bottom'}
  <div class="{$headerBottomName}">
    <div class="sami-container {$headerBottomName}__container">
      <div class="gx-2 align-items-stretch {$headerBottomName}__row">
        <div class="d-flex align-items-center justify-content-left logo-container">
          {if $shop.logo_details}
            {if $page.page_name == 'index'}<h1 class="{$headerBottomName}__h1 mb-0">{/if}
              {renderLogo}
            {if $page.page_name == 'index'}</h1>{/if}
          {/if}
        </div>

        <div class="d-flex align-items-center justify-content-center navigation-container">
          <a class="">
            <i class="material-symbols-outlined header-block__icon" aria-hidden="true">favorite</i>
            <span class="header-block__action-btn">
              {l s='Cancel' d='Shop.Theme.Global'}
            </span>
          </a>

          <div class="search__mobile d-md-none d-flex">

            <div class="header-block d-flex align-items-center">
              <a class="header-block__action-btn" href="#" role="button" data-bs-toggle="offcanvas" data-bs-target="#searchCanvas" aria-controls="searchCanvas" aria-label="{l s='Show search bar' d='Shop.Theme.Global'}">
                <span class="material-symbols-outlined header-block__icon">search</span>
              </a>
            </div>

            <div class="search__offcanvas js-search-offcanvas offcanvas offcanvas-top h-auto" data-bs-backdrop="false" data-bs-scroll="true" tabindex="-1" id="searchCanvas" aria-labelledby="offcanvasTopLabel">
              <div class="offcanvas-header">
                <div id="_mobile_search" class="search__container"></div>
                <button type="button" class="btn-close text-reset ms-1" data-bs-dismiss="offcanvas" aria-label="Close">{l s='Cancel' d='Shop.Theme.Global'}</button>
              </div>
            </div>
          </div>

          {hook h='displayTopSearch'}
        </div>
    
        <div class="d-flex align-items-center justify-content-right actions-container">
          <a href="{$urls.pages.my_account}" id="user_info" class="action-btn {if $urls.current_url === $urls.pages.my_account} active{/if}">
            <span class="">
              <i class="material-symbols-outlined action-icon" aria-hidden="true">person</i>
            </span>
          </a>

          <a href="{$link->getModuleLink('blockwishlist', 'lists', array(), true)|escape:'html':'UTF-8'}" id="wishlist" class="action-btn {if $urls.current_url === $link->getModuleLink('blockwishlist', 'lists', array(), true)|escape:'html':'UTF-8'} active{/if}">
            <span class="">
              <i class="material-symbols-outlined action-icon" aria-hidden="true">favorite</i>
            </span>
          </a>

          <a href="{$urls.pages.cart}" href="{$urls.pages.my_account}" id="cart" class="action-btn {if $urls.current_url === $urls.pages.cart} active{/if}">
            <span class="">
              <i class="material-symbols-outlined action-icon" aria-hidden="true">shopping_cart</i>
              <span class="action-cart-badge">{$cart.products_count}</span>
            </span>
          </a>
        </div>
      </div>
    </div>
  </div>

  {hook h='displayNavFullWidth'}
{/block}
