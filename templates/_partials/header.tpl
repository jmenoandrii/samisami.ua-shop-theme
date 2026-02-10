{**
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *}
{$headerBottomName = 'header-bottom'}
{$headerMegaMenuName = 'header-mega-menu'}

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
          <button class="catalog-btn">
            <span class="catalog-btn-content">
              <i class="material-symbols-outlined catalog-open-span catalog-icon" aria-hidden="true">menu</i>
              <i class="material-symbols-outlined catalog-close-span catalog-icon" aria-hidden="true">close</i>
              <span class="catalog-span">
                {l s='Catalog' d='Shop.Theme.Global'}
              </span>
            </span>
          </button>

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
              <svg class="action-user-icon action-icon" viewBox="0 0 35 35" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path class="action-icon-outline" d="M17.5 16.9082C15.0938 16.9082 13.125 16.1192 11.5938 14.5411C10.0625 12.963 9.29687 10.934 9.29687 8.45411C9.29687 5.97424 10.0625 3.94525 11.5938 2.36715C13.125 0.78905 15.0938 0 17.5 0C19.9063 0 21.875 0.78905 23.4063 2.36715C24.9375 3.94525 25.7031 5.97424 25.7031 8.45411C25.7031 10.934 24.9375 12.963 23.4063 14.5411C21.875 16.1192 19.9063 16.9082 17.5 16.9082ZM0 35V29.7021C0 28.2743 0.346354 27.0531 1.03906 26.0386C1.73177 25.0242 2.625 24.2539 3.71875 23.7279C6.16146 22.6006 8.50391 21.7552 10.7461 21.1916C12.9883 20.628 15.2396 20.3462 17.5 20.3462C19.7604 20.3462 22.0026 20.6374 24.2266 21.2198C26.4505 21.8022 28.7824 22.6418 31.2222 23.7386C32.3633 24.2695 33.2783 25.0392 33.967 26.0477C34.6556 27.0561 35 28.2743 35 29.7021V35H0ZM3.28125 31.6184H31.7187V29.7021C31.7187 29.1009 31.5456 28.5279 31.1992 27.9831C30.8529 27.4383 30.4245 27.0344 29.9141 26.7713C27.5807 25.6065 25.4479 24.8081 23.5156 24.376C21.5833 23.9439 19.5781 23.7279 17.5 23.7279C15.4219 23.7279 13.3984 23.9439 11.4297 24.376C9.46094 24.8081 7.32812 25.6065 5.03125 26.7713C4.52083 27.0344 4.10156 27.4383 3.77344 27.9831C3.44531 28.5279 3.28125 29.1009 3.28125 29.7021V31.6184ZM17.5 13.5266C18.9219 13.5266 20.0977 13.0475 21.0273 12.0894C21.957 11.1312 22.4219 9.91948 22.4219 8.45411C22.4219 6.98873 21.957 5.77697 21.0273 4.81884C20.0977 3.86071 18.9219 3.38164 17.5 3.38164C16.0781 3.38164 14.9023 3.86071 13.9727 4.81884C13.043 5.77697 12.5781 6.98873 12.5781 8.45411C12.5781 9.91948 13.043 11.1312 13.9727 12.0894C14.9023 13.0475 16.0781 13.5266 17.5 13.5266Z"/>
                <path class="action-icon-filler" d="M17.5 13.5266C18.9219 13.5266 20.0977 13.0475 21.0273 12.0894C21.957 11.1312 22.4219 9.91948 22.4219 8.45411C22.4219 6.98873 21.957 5.77697 21.0273 4.81884C20.0977 3.86071 18.9219 3.38164 17.5 3.38164C16.0781 3.38164 14.9023 3.86071 13.9727 4.81884C13.043 5.77697 12.5781 6.98873 12.5781 8.45411C12.5781 9.91948 13.043 11.1312 13.9727 12.0894C14.9023 13.0475 16.0781 13.5266 17.5 13.5266Z"/>
                <path class="action-icon-filler" d="M3.28125 31.6184H31.7187V29.7021C31.7187 29.1009 31.5456 28.5279 31.1992 27.9831C30.8529 27.4383 30.4245 27.0344 29.9141 26.7713C27.5807 25.6065 25.4479 24.8081 23.5156 24.376C21.5833 23.9439 19.5781 23.7279 17.5 23.7279C15.4219 23.7279 13.3984 23.9439 11.4297 24.376C9.46094 24.8081 7.32812 25.6065 5.03125 26.7713C4.52083 27.0344 4.10156 27.4383 3.77344 27.9831C3.44531 28.5279 3.28125 29.1009 3.28125 29.7021V31.6184Z"/>
              </svg>
            </span>
          </a>

          <a href="{$link->getModuleLink('ets_wishlist_pres17', 'lists', array(), true)|escape:'html':'UTF-8'}" id="wishlist" class="action-btn {if $urls.current_url === $link->getModuleLink('ets_wishlist_pres17', 'lists', array(), true)|escape:'html':'UTF-8'} active{/if}">
            <span class="">
              <svg class="action-wishlist-icon action-icon" viewBox="0 0 39 33" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path class="action-icon-filler" d="M10.3111 1.56152C15.1455 1.56152 19.0611 5.27375 19.0611 9.85323C19.0611 5.27375 22.9768 1.56152 27.8111 1.56152C32.6455 1.56152 36.5611 5.27375 36.5611 9.85323C36.5611 16.7552 29.4868 19.1899 19.9186 30.1764C19.8133 30.297 19.682 30.394 19.5339 30.4605C19.3858 30.5271 19.2244 30.5615 19.0611 30.5615C18.8978 30.5615 18.7365 30.5271 18.5884 30.4605C18.4403 30.394 18.309 30.297 18.2036 30.1764C8.6355 19.1899 1.56113 16.7552 1.56113 9.85323C1.56113 5.27375 5.47675 1.56152 10.3111 1.56152Z" stroke="#402120" stroke-width="3.12225"/>
              </svg>
            </span>
          </a>

          {hook h='displayShoppingCart'}
        </div>
      </div>
    </div>
  </div>
{/block}

{block name='header_mega_menu'}
  <div class="{$headerMegaMenuName}">
    <div class ="{$headerMegaMenuName}__wrapper">
      {hook h='displayMegaMenu'}
    </div>
    <div class="{$headerMegaMenuName}__background">
    </div>
  </div>
{/block}