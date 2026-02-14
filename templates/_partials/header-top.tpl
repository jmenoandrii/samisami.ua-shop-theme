{$headerTopName = 'header-top'}

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
        </div>
      </div>
    </div>
  </nav>
{/block}