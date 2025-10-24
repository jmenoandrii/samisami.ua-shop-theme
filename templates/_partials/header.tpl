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
      <div class="row gx-2 align-items-stretch {$headerBottomName}__row">
        <div class="d-flex align-items-center col-auto logo-container">
          {if $shop.logo_details}
            {if $page.page_name == 'index'}<h1 class="{$headerBottomName}__h1 mb-0">{/if}
              {renderLogo}
            {if $page.page_name == 'index'}</h1>{/if}
          {/if}
        </div>

        <div class="search__mobile d-md-none d-flex col-auto">

          <div class="header-block d-flex align-items-center">
            <a class="header-block__action-btn" href="#" role="button" data-bs-toggle="offcanvas" data-bs-target="#searchCanvas" aria-controls="searchCanvas" aria-label="{l s='Show search bar' d='Shop.Theme.Global'}">
              <span class="material-icons header-block__icon">search</span>
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

    
        <a href="{$urls.pages.my_account}" id="user_info" class="col-auto d-flex {if $urls.current_url === $urls.pages.my_account} active{/if}">
          <div class="header-block">
            <span class="header-block__action-btn">
              <i class="material-icons header-block__icon" aria-hidden="true">&#xE7FD;</i>
            </span>
          </div>
        </a>

        <a href="{$link->getModuleLink('blockwishlist', 'lists', array(), true)|escape:'html':'UTF-8'}" id="wishlist" class="col-auto d-flex {if $urls.current_url === $link->getModuleLink('blockwishlist', 'lists', array(), true)|escape:'html':'UTF-8'} active{/if}">
          <div class="header-block">
            <span class="header-block__action-btn">
              <i class="material-icons header-block__icon" aria-hidden="true">favorite</i>
            </span>
          </div>
        </a>

        <a href="{$urls.pages.cart}" href="{$urls.pages.my_account}" id="cart" class="col-auto d-flex {if $urls.current_url === $urls.pages.cart} active{/if}">
          <div class="header-block d-flex align-items-center">
            <span class="header-block__action-btn">
              <i class="material-icons header-block__icon" aria-hidden="true">shopping_cart</i>
              <span class="header-block__badge">{$cart.products_count}</span>
            </span>
          </div>
        </a>
      </div>
    </div>
  </div>

  {hook h='displayNavFullWidth'}
{/block}
